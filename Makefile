SHELL = cmd.exe
CC = C:/ProgramData/mingw64/mingw64/bin/gcc.exe
CFLAGS = -Wall -Wextra -g -Iinclude
BUILD_DIR = build
OBJ_DIR = $(BUILD_DIR)/obj
BIN_DIR = bin
APP = $(BIN_DIR)/sort_demo.exe
TEST = $(BIN_DIR)/sort_test.exe
SORT_OBJ = $(OBJ_DIR)/sort.o
MAIN_OBJ = $(OBJ_DIR)/main.o
TEST_OBJ = $(OBJ_DIR)/sort_test.o

all: $(APP) $(TEST)

$(APP): $(SORT_OBJ) $(MAIN_OBJ)
	if not exist bin mkdir bin
	$(CC) $(CFLAGS) -o $(APP) $(SORT_OBJ) $(MAIN_OBJ)

$(TEST): $(SORT_OBJ) $(TEST_OBJ)
	if not exist bin mkdir bin
	$(CC) $(CFLAGS) -o $(TEST) $(SORT_OBJ) $(TEST_OBJ)

$(SORT_OBJ): src/sort.c include/sort.h
	if not exist build mkdir build
	if not exist build\obj mkdir build\obj
	$(CC) $(CFLAGS) -c src/sort.c -o $(SORT_OBJ)

$(MAIN_OBJ): src/main.c include/sort.h
	if not exist build mkdir build
	if not exist build\obj mkdir build\obj
	$(CC) $(CFLAGS) -c src/main.c -o $(MAIN_OBJ)

$(TEST_OBJ): tests/sort_test.c include/sort.h
	if not exist build mkdir build
	if not exist build\obj mkdir build\obj
	$(CC) $(CFLAGS) -c tests/sort_test.c -o $(TEST_OBJ)

run: $(APP)
	$(APP)

test: $(TEST)
	$(TEST)

clean:
	if exist build rmdir /s /q build
	if exist bin rmdir /s /q bin

.PHONY: all clean run test
