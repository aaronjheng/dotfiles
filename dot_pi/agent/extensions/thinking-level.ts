/**
 * Thinking Level Command Extension
 *
 * 快速切换 Pi 的 thinking level，无需打开 settings。
 * 通过探测 setThinkingLevel 的 clamp 行为获取当前模型实际支持的 level。
 *
 * 用法:
 *   /thinking          弹出选择菜单快速切换
 *   /thinking off      直接设置为 off
 *   /thinking high     直接设置为 high
 *   /thinking cycle    循环切换当前模型支持的 level
 */

import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const ALL_LEVELS = ["off", "minimal", "low", "medium", "high", "xhigh", "max"] as const;

function getAvailableLevels(pi: ExtensionAPI): string[] {
  const current = pi.getThinkingLevel();

  // 探测每个 level 是否真正可用
  const available: string[] = [];
  for (const level of ALL_LEVELS) {
    pi.setThinkingLevel(level);
    if (pi.getThinkingLevel() === level) {
      available.push(level);
    }
  }

  // 恢复
  pi.setThinkingLevel(current as Parameters<typeof pi.setThinkingLevel>[0]);

  // 如果只探测到 off，说明是非推理模型，直接返回 ["off"]
  // 如果探测到多个但 off 不在其中（强制 reasoning），也正常返回
  return available;
}

export default function thinkingLevelExtension(pi: ExtensionAPI) {
  pi.registerCommand("thinking", {
    description: "Switch thinking level (off/minimal/low/medium/high/xhigh/max)",
    handler: async (args, ctx) => {
      const availableLevels = getAvailableLevels(pi);
      const current = pi.getThinkingLevel();
      const target = args.trim().toLowerCase();

      if (target === "cycle") {
        const idx = availableLevels.indexOf(current);
        const next = availableLevels[(idx + 1) % availableLevels.length];
        pi.setThinkingLevel(next as Parameters<typeof pi.setThinkingLevel>[0]);
        ctx.ui.notify(`Thinking: ${current} → ${pi.getThinkingLevel()}`, "info");
        return;
      }

      if (target) {
        if (!ALL_LEVELS.includes(target as typeof ALL_LEVELS[number])) {
          ctx.ui.notify(
            `Invalid level: "${target}". Available: ${availableLevels.join(", ")}`,
            "error",
          );
          return;
        }
        if (!availableLevels.includes(target)) {
          ctx.ui.notify(
            `"${target}" not available for this model. Available: ${availableLevels.join(", ")}`,
            "warning",
          );
          return;
        }
        pi.setThinkingLevel(target as Parameters<typeof pi.setThinkingLevel>[0]);
        ctx.ui.notify(`Thinking: ${pi.getThinkingLevel()}`, "info");
        return;
      }

      // 无参数：弹出菜单，标注当前值
      const items = availableLevels.map((l) =>
        l === current ? `${l} (current)` : l
      );

      const choice = await ctx.ui.select("Set Thinking Level:", items);
      if (choice) {
        const level = choice.replace(" (current)", "");
        pi.setThinkingLevel(level as Parameters<typeof pi.setThinkingLevel>[0]);
        ctx.ui.notify(`Thinking: ${pi.getThinkingLevel()}`, "info");
      }
    },
  });
}