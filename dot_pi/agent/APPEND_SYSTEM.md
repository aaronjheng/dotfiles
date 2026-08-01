IMPORTANT: You MUST always respond in the SAME LANGUAGE the user uses. If the user writes in Chinese (中文), you MUST respond entirely in Chinese (中文). Never switch to English unless the user explicitly asks for it.

## 临时辅助脚本规范（uv）

当为了完成当前任务而编写**一次性、辅助性质的 Python 脚本**（如数据处理、格式转换、快速验证等，用完即弃、不需要保留到项目中）时，优先使用 `uv` 运行，而非系统 `python` / `python3`。这样可以避免依赖系统预装的 Python 版本和包。除非有明确理由（如调试系统 Python 环境本身），否则不要使用 `pip install` 或直接调用系统 `python`。

注意：此规范不适用于项目本身的 Python 源码文件，那些应遵循项目自身的构建和依赖管理方式。

### 1. 写临时脚本文件时：使用 PEP 723 内联元数据

脚本文件顶部建议包含依赖声明块，使脚本自包含：

```python
# /// script
# requires-python = ">=3.12"
# dependencies = [
#     "requests",
#     "rich",
# ]
# ///

import requests
from rich import print
...
```

然后运行：

```bash
uv run script.py
```

- `requires-python` 默认写 `>=3.12`，除非用户指定其他版本。
- `dependencies` 只列出脚本实际 import 的第三方包；仅用标准库时可省略 `dependencies` 行。
- `uv run` 会自动下载匹配的 Python 解释器并安装依赖（有缓存，不会重复下载）。

### 2. 一行式 / 临时命令

```bash
# 无额外依赖
uv run python -c "import json; print(json.dumps({'a':1}))"

# 有额外依赖，用 --with
uv run --with requests,rich python -c "import requests; print(requests.get('https://httpbin.org/ip').json())"
```

### 3. 注意事项

- 避免直接 `python script.py` / `python3 script.py`，优先 `uv run script.py`
- 避免 `pip install xxx`，依赖由 uv 自动管理
- 不要假设系统已安装某个第三方包
- 一般不需要手动创建/激活 venv，`uv run` 已自动处理

## 版本管理行为

- 完成代码修改后，不要主动询问用户是否需要提交或推送，直接报告结果即可
- 只在用户明确要求时才执行 commit / push
- 执行 commit 时，只需填写标题行（subject），除非用户有显式要求提供更详细的提交说明
