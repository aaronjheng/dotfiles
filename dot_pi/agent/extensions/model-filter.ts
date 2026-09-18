// 模型列表过滤扩展(通用)。
//
// 原理:对 PROVIDER_RULES 里配置的 provider,用 pi.registerProvider(id,
// { models }) 按名称覆盖内置 provider。传入 models 时,Pi 会用这份列表
// 【整体替换】该 provider 的模型目录(内置静态目录 + models-store.json
// 缓存的远程目录),同时保留原有认证(auth.json 凭据或对应环境变量),
// 因此无需重新登录。
//
// 数据来源:Pi 的远程目录缓存 ~/.pi/agent/models-store.json(Pi 启动时会
// 自动刷新,过滤结果随之更新),缓存不可用时回退到 pi.dev 的目录接口。
// 注意:列表以官方远程目录为准,内置静态目录里不在远程目录中的旧条目
// 也会一并隐藏。
//
// 配置:PROVIDER_RULES 声明每个 provider 要应用的过滤规则(按顺序应用)。
// 以后要过滤其它 provider 或新增规则,改这一个地方即可。
//
// 目录不可用或过滤结果为空时,该 provider 保持原样,不拦截启动。

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent"
import { readFile } from "node:fs/promises"
import { homedir } from "node:os"
import { join } from "node:path"

const FETCH_TIMEOUT_MS = 8_000

type CatalogModel = {
  id: string
  cost?: { input?: number; output?: number }
  [key: string]: unknown
}

type ModelFilter = (model: CatalogModel) => boolean

// ---- 可复用的规则 ----

// 价格为 0 只是占位、实际计费随路由变化的路由模型(OpenRouter)。
const ROUTER_IDS = new Set(["auto", "openrouter/auto", "openrouter/auto-beta", "openrouter/fusion"])

// 只保留免费模型:":free" 后缀,或 prompt/completion 价格均为 0。
const isFree: ModelFilter = (m) =>
  m.id.endsWith(":free") || (m.cost?.input === 0 && m.cost?.output === 0)

// 排除路由模型。
const notRouter: ModelFilter = (m) => !ROUTER_IDS.has(m.id)

// 按 id 精确排除若干模型。
const exclude =
  (...ids: string[]): ModelFilter =>
  (m) =>
    !ids.includes(m.id)

// ---- 各 provider 的过滤规则(按顺序应用) ----

const PROVIDER_RULES: Record<string, ModelFilter[]> = {
  // OpenRouter:只保留免费模型,并去掉路由模型。
  openrouter: [isFree, notRouter],
  // DeepSeek:去掉不用的模型。
  deepseek: [exclude("deepseek-v4-flash", "deepseek-v4-flash-vision-exp")],
}

// ---- 目录读取 ----

// 兼容 pi 目录接口的三种返回形态:数组 / { models: [...] } / 对象映射。
function parseCatalog(value: unknown): CatalogModel[] {
  let entries: unknown[] = []
  if (Array.isArray(value)) entries = value
  else if (value && typeof value === "object" && Array.isArray((value as any).models))
    entries = (value as any).models
  else if (value && typeof value === "object") entries = Object.values(value)
  return entries.filter(
    (e): e is CatalogModel => !!e && typeof e === "object" && typeof (e as any).id === "string"
  )
}

async function readCachedCatalog(providerId: string): Promise<CatalogModel[]> {
  const raw = await readFile(join(homedir(), ".pi", "agent", "models-store.json"), "utf-8")
  const store = JSON.parse(raw)
  return parseCatalog(store?.[providerId]?.models)
}

async function fetchRemoteCatalog(providerId: string): Promise<CatalogModel[]> {
  const url = `https://pi.dev/api/models/providers/${encodeURIComponent(providerId)}`
  const res = await fetch(url, {
    headers: { accept: "application/json" },
    signal: AbortSignal.timeout(FETCH_TIMEOUT_MS),
  })
  if (!res.ok) throw new Error(`catalog request failed: ${res.status}`)
  return parseCatalog(await res.json())
}

export default async function (pi: ExtensionAPI) {
  for (const [providerId, rules] of Object.entries(PROVIDER_RULES)) {
    let catalog: CatalogModel[] = []

    try {
      catalog = await readCachedCatalog(providerId)
    } catch {
      // 缓存不存在或损坏,忽略,走网络回退。
    }
    if (catalog.length === 0) {
      try {
        catalog = await fetchRemoteCatalog(providerId)
      } catch {
        // 目录不可用,该 provider 保持原样。
        continue
      }
    }

    let models = catalog
    for (const rule of rules) {
      models = models.filter(rule)
    }

    const seen = new Set<string>()
    const filtered: CatalogModel[] = []
    for (const model of models) {
      if (seen.has(model.id)) continue
      seen.add(model.id)
      filtered.push(model)
    }
    filtered.sort((a, b) => a.id.localeCompare(b.id))

    if (filtered.length === 0) continue

    pi.registerProvider(providerId, {
      // 传入 models 即整体替换该 provider 的模型列表;
      // 认证继承内置 provider,api/baseUrl 由目录条目自带,无需额外指定。
      models: filtered as any,
    })
  }
}
