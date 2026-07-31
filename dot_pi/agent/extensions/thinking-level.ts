/**
 * Thinking Level Command Extension
 *
 * 快速切换 Pi 的 thinking level，无需打开 settings。
 * 通过探测 setThinkingLevel 的 clamp 行为来获取当前模型实际支持的 level。
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

  const available: string[] = [];
  for (const level of ALL_LEVELS) {
    pi.setThinkingLevel(level);
    const actual = pi.getThinkingLevel();
    if (actual === level) {
      available.push(level);
    }
  }

  // 恢复原来的 level
  pi.setThinkingLevel(current as Parameters<typeof pi.setThinkingLevel>[0]);
  return available;
}

export default function thinkingLevelExtension(pi: ExtensionAPI) {
  pi.registerCommand("thinking", {
    description: "Switch thinking level (off/minimal/low/medium/high/xhigh/max)",
    handler: async (args, ctx) => {
      const availableLevels = getAvailableLevels(pi);

      const target = args.trim().toLowerCase();

      if (target === "cycle") {
        const current = pi.getThinkingLevel();
        const idx = availableLevels.indexOf(current);
        const next = availableLevels[(idx + 1) % availableLevels.length];
        pi.setThinkingLevel(next as Parameters<typeof pi.setThinkingLevel>[0]);
        const actual = pi.getThinkingLevel();
        ctx.ui.notify(`Thinking: ${current} → ${actual}`, "info");
        return;
      }

      if (target && ALL_LEVELS.includes(target as typeof ALL_LEVELS[number])) {
        if (!availableLevels.includes(target)) {
          ctx.ui.notify(
            `Current model doesn't support "${target}". Only: ${availableLevels.join(", ")}`,
            "warning",
          );
          return;
        }
        pi.setThinkingLevel(target as Parameters<typeof pi.setThinkingLevel>[0]);
        const actual = pi.getThinkingLevel();
        ctx.ui.notify(`Thinking: ${actual}`, "info");
        return;
      }

      if (target) {
        ctx.ui.notify(
          `Invalid level: "${target}". Valid: ${availableLevels.join(", ")}`,
          "error",
        );
        return;
      }

      // 无参数：弹出菜单
      const current = pi.getThinkingLevel();
      const items = availableLevels.map((l) =>
        l === current ? `${l} (current)` : l
      );

      const choice = await ctx.ui.select("Set Thinking Level:", items);
      if (choice) {
        const level = choice.replace(" (current)", "");
        pi.setThinkingLevel(level as Parameters<typeof pi.setThinkingLevel>[0]);
        const actual = pi.getThinkingLevel();
        ctx.ui.notify(`Thinking: ${actual}`, "info");
      }
    },
  });
}