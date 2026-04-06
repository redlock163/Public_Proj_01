# Sorting Algorithms in C

A small C project for implementing, demonstrating, and testing classic sorting algorithms.

## Features

- Bubble sort
- Quick sort
- Merge sort
- Demo executable for manual runs and timing
- Separate test executable for deterministic verification
- Unified public sort API using `(arr, n)`

## Project Structure

```text
.
├── include/
│   └── sort.h          # Public sorting API
├── src/
│   ├── main.c          # Demo and performance runner
│   └── sort.c          # Sorting implementations
├── tests/
│   └── sort_test.c     # Deterministic correctness checks
├── bin/                # Built executables
├── build/              # Intermediate object files
├── build.bat           # Windows build script
├── Makefile            # GNU Make build file
└── .vscode/            # Editor configuration
```

## Why This Layout

- `include/` keeps the public API easy to find.
- `src/` contains production code only.
- `tests/` avoids mixing test code with implementation code.
- `bin/` and `build/` keep generated files out of the project root.
- Recursive helper functions stay private inside `src/sort.c`.

## Prerequisites

- GCC
- GNU Make if you want to use `make`

## Building

### Windows batch script

```bash
.\build.bat
```

### GNU Make

```bash
make
```

## Running

```bash
bin\sort_demo.exe
```

Or with `make`:

```bash
make run
```

## Testing

```bash
bin\sort_test.exe
```

Or with `make`:

```bash
make test
```

The test program covers:

- empty input
- single element
- repeated values
- reverse-sorted input
- already sorted input
- negative numbers

## Cleaning

```bash
make clean
```

## Time Complexity

| Algorithm   | Average    | Worst      | Space      | Stable |
|-------------|------------|------------|------------|--------|
| Bubble Sort | O(n^2)     | O(n^2)     | O(1)       | Yes    |
| Quick Sort  | O(n log n) | O(n^2)     | O(log n)   | No     |
| Merge Sort  | O(n log n) | O(n log n) | O(n)       | Yes    |
