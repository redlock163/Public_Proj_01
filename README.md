# C 语言排序算法示例项目

这是一个使用 C 语言实现的排序算法示例项目，包含算法实现、演示程序、测试程序，以及基础的构建脚本，适合学习项目结构整理、排序算法实现和简单性能对比。

## 功能特点

- 实现了冒泡排序
- 实现了快速排序
- 实现了归并排序
- 提供演示程序，可直接查看排序结果与性能测试输出
- 提供独立测试程序，用于验证排序正确性
- 对外排序接口统一为 `(arr, n)` 风格，调用更简单

## 项目结构

```text
.
├── include/
│   └── sort.h          # 对外头文件，声明公共接口
├── src/
│   ├── main.c          # 演示程序与性能测试入口
│   └── sort.c          # 排序算法具体实现
├── tests/
│   └── sort_test.c     # 排序正确性测试程序
├── bin/                # 编译生成的可执行文件
├── build/              # 编译生成的中间文件
├── build.bat           # Windows 下构建脚本
├── make.bat            # Windows 下的 make 包装脚本
├── Makefile            # Make 构建脚本
└── .vscode/            # VS Code 配置文件
```

## 这样组织的好处

- `include/` 用来集中管理公共接口，查找头文件更方便
- `src/` 只放正式功能代码，职责清晰
- `tests/` 专门放测试代码，避免和业务代码混在一起
- `bin/` 与 `build/` 用来放生成文件，保持项目根目录整洁
- 递归辅助函数只保留在 `src/sort.c` 内部，减少对外暴露的实现细节

## 环境要求

- Windows 系统
- MinGW GCC 编译器
- MinGW 自带的 `mingw32-make.exe`

当前项目已经固定使用以下工具绝对路径：

```text
GCC:
C:\ProgramData\mingw64\mingw64\bin\gcc.exe

Make:
C:\ProgramData\mingw64\mingw64\bin\mingw32-make.exe
```

这样做的目的是避免误用其他工具链，例如系统里另外安装的 HighTec `make.exe`。

## 推荐的构建入口

推荐优先使用以下两个入口：

- `build.bat`
- `make.bat`

它们都已经指向当前项目应该使用的 MinGW 工具链，不依赖 PATH，也不会误调用其他环境里的 `gcc` 或 `make`。

## 编译方式

### 方式一：使用 `build.bat`

这是最直接的构建方式，会编译出两个程序：

- `bin\sort_demo.exe`
- `bin\sort_test.exe`

```bash
.\build.bat
```

构建成功后会提示你如何运行 demo 和 test。

### 方式二：使用 `make.bat`

这是给当前项目准备的 Windows 包装脚本，内部会自动调用：

```text
C:\ProgramData\mingw64\mingw64\bin\mingw32-make.exe
```

直接执行：

```bash
.\make.bat
```

如果不带参数，脚本会先显示用法，再执行默认构建。

常用命令如下：

```bash
.\make.bat
.\make.bat run
.\make.bat test
.\make.bat clean
```

### 方式三：直接使用 `mingw32-make.exe`

如果你希望直接调用 make，可以使用绝对路径：

```bash
C:\ProgramData\mingw64\mingw64\bin\mingw32-make.exe
C:\ProgramData\mingw64\mingw64\bin\mingw32-make.exe run
C:\ProgramData\mingw64\mingw64\bin\mingw32-make.exe test
C:\ProgramData\mingw64\mingw64\bin\mingw32-make.exe clean
```

不建议直接使用系统里的 `make` 命令名，因为你的机器上 `make` 可能会解析到其他工具链目录，例如 HighTec，自然就会和当前项目的 MinGW 构建配置不匹配。

## 构建产物

成功构建后会生成：

- `bin\sort_demo.exe`：演示程序
- `bin\sort_test.exe`：测试程序
- `build\obj\*.o`：中间目标文件

## 运行演示程序

```bash
bin\sort_demo.exe
```

或者使用 `make.bat`：

```bash
.\make.bat run
```

## 运行测试程序

```bash
bin\sort_test.exe
```

或者使用 `make.bat`：

```bash
.\make.bat test
```

当前测试覆盖了以下场景：

- 空数组
- 单元素数组
- 含重复值的数组
- 逆序数组
- 已排序数组
- 含负数的数组

## 清理生成文件

```bash
.\make.bat clean
```

如果你更喜欢直接调用 make，也可以使用：

```bash
C:\ProgramData\mingw64\mingw64\bin\mingw32-make.exe clean
```

## 一次完整使用示例

```bash
.\build.bat
bin\sort_demo.exe
bin\sort_test.exe
```

或者：

```bash
.\make.bat
.\make.bat run
.\make.bat test
```

## 常见问题

### 为什么不建议直接用 `make`？

因为当前机器上 `make` 可能不是 MinGW 的版本，而是其他工具链自带的版本。这样即使项目代码没问题，也可能因为 shell、命令语法或工具链不一致而报错。

### 为什么 `Makefile` 和 `build.bat` 要写绝对路径？

因为绝对路径能确保本项目始终使用同一套 GCC 和 make 工具，避免 PATH 变化导致构建行为不稳定。

## 时间复杂度

| 算法 | 平均时间复杂度 | 最坏时间复杂度 | 空间复杂度 | 是否稳定 |
|------|----------------|----------------|------------|----------|
| 冒泡排序 | O(n^2) | O(n^2) | O(1) | 是 |
| 快速排序 | O(n log n) | O(n^2) | O(log n) | 否 |
| 归并排序 | O(n log n) | O(n log n) | O(n) | 是 |
