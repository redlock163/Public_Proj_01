# 联合早报新闻抓取示例

这是一个简单的 Python 项目，主要功能是抓取 `https://www.zaobao.com/` 首页内容，并使用正则表达式提取新闻标题，最后输出前 5 条新闻标题。

## 项目功能

- 请求联合早报首页 HTML
- 使用正则表达式匹配 `<h1>` 到 `<h6>` 标题内容
- 清理 HTML 标签和多余空白
- 去重后输出前 5 条新闻标题

## 环境要求

- Python 3.10 或更高版本
- 推荐使用 VS Code
- 如果要调试，建议安装 VS Code 的 Python 扩展

## 项目文件说明

- `main.py`：主程序，负责抓取网页、提取标题并打印结果
- `pyproject.toml`：项目基础配置文件
- `.vscode/launch.json`：VS Code 调试配置
- `README.md`：项目说明文档

## 运行方法

在项目根目录打开终端，执行：

```bash
python main.py
```

运行成功后，你会看到类似下面的输出：

```text
Top 5 Zaobao news titles:
1. 新闻标题1
2. 新闻标题2
3. 新闻标题3
4. 新闻标题4
5. 新闻标题5
```

## 代码逻辑说明

### 1. `fetch_homepage()`

这个函数负责发送 HTTP 请求，获取联合早报首页 HTML。

功能说明：

- 使用 `urllib.request` 发起请求
- 设置 `User-Agent`，避免被站点直接拒绝
- 自动按网页编码进行解码

### 2. `clean_text()`

这个函数负责清理提取出来的标题文本。

功能说明：

- 去掉 HTML 标签
- 把 HTML 实体转成正常文本
- 合并多余空格和换行

### 3. `extract_titles()`

这个函数使用正则表达式从网页中提取标题。

使用的核心正则是：

```python
r"<h[1-6][^>]*>(.*?)</h[1-6]>"
```

含义说明：

- 匹配 `<h1>` 到 `<h6>` 标签
- 提取标签中间的文本内容
- 再经过清洗和去重，保留前 5 条标题

### 4. `main()`

主函数负责：

- 抓取网页
- 提取标题
- 处理异常
- 打印结果

## 如何在 VS Code 中调试 Python

本项目已经包含 VS Code 的调试配置文件：

- `.vscode/launch.json`

你可以直接在 VS Code 中调试 `main.py`。

## 调试前准备

### 1. 打开项目文件夹

在 VS Code 中打开当前项目根目录。

### 2. 安装 Python 扩展

如果还没有安装，请在 VS Code 扩展市场中安装官方 Python 扩展。

### 3. 选择 Python 解释器

按下 `Ctrl + Shift + P`，输入：

```text
Python: Select Interpreter
```

然后选择你本机可用的 Python 版本。

## 调试步骤

### 方法一：直接调试 `main.py`

1. 打开 `main.py`
2. 在你想暂停的位置点击行号左边空白区域，添加断点
3. 按 `F5`
4. 在顶部或左侧调试面板中，选择：

```text
Python Debugger: main.py
```

5. 程序运行到断点时会自动暂停

### 方法二：调试当前打开文件

如果你想调试当前编辑中的 Python 文件，也可以选择：

```text
Python Debugger: Current File
```

## 推荐断点位置

为了更容易理解程序执行过程，推荐你把断点打在这些位置：

### 1. `page_html = fetch_homepage(URL)`

可以看网页内容是否成功获取。

### 2. `heading_matches = re.findall(...)`

可以看正则表达式是否匹配到标题。

### 3. `title = clean_text(match)`

可以看原始标题和清洗后的标题差别。

### 4. `print(f"{index}. {title}")`

可以看最终输出结果。

## 调试时常用操作

- `F5`：继续运行
- `F10`：单步跳过
- `F11`：单步进入
- `Shift + F11`：跳出当前函数
- `Shift + F5`：停止调试

## 调试面板怎么看

进入调试状态后，VS Code 左侧会出现调试信息。

你可以重点看这几个区域：

- `Variables`：当前变量值
- `Watch`：你手动添加的观察表达式
- `Call Stack`：当前函数调用栈
- `Breakpoints`：当前所有断点

## 推荐观察的变量

调试时你可以重点看这些变量：

- `page_html`：抓取到的网页源码
- `heading_matches`：正则匹配出来的原始标题列表
- `title`：清洗后的单条标题
- `titles`：最终保留下来的新闻标题列表

## 如果无法调试，常见原因

### 1. 没安装 Python 扩展

解决方法：

- 安装 VS Code 官方 Python 扩展

### 2. 没选正确的 Python 解释器

解决方法：

- 执行 `Python: Select Interpreter`
- 重新选择正确的 Python

### 3. 程序运行时报网络错误

可能原因：

- 当前网络无法访问目标网站
- 网站临时拒绝连接

这种情况不是调试配置问题，而是运行环境问题。

## 补充说明

- 本项目只使用 Python 标准库，不依赖第三方库
- 当前标题提取方案依赖网页结构，如果网站 HTML 结构变化，正则规则可能需要调整
- 由于新闻内容会实时变化，每次运行输出的标题不一定相同
