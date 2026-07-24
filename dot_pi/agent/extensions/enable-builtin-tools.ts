import type { ExtensionAPI } from "@earendil-works/pi-coding-agent";

const OFF_BY_DEFAULT = ["grep", "find", "ls"];

function applyTools(pi: ExtensionAPI) {
  const all = pi.getAllTools().map((t) => t.name);
  const active = pi.getActiveTools();
  const toAdd = OFF_BY_DEFAULT.filter(
    (t) => all.includes(t) && !active.includes(t),
  );
  if (toAdd.length > 0) {
    pi.setActiveTools([...active, ...toAdd]);
  }
}

export default function (pi: ExtensionAPI) {
  pi.on("session_start", () => applyTools(pi));
  pi.on("session_tree", () => applyTools(pi));
}