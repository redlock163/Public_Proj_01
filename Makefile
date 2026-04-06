CC = gcc
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
	mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) -o $(APP) $(SORT_OBJ) $(MAIN_OBJ)

$(TEST): $(SORT_OBJ) $(TEST_OBJ)
	mkdir -p $(BIN_DIR)
	$(CC) $(CFLAGS) -o $(TEST) $(SORT_OBJ) $(TEST_OBJ)

$(SORT_OBJ): src/sort.c include/sort.h
	mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c src/sort.c -o $(SORT_OBJ)

$(MAIN_OBJ): src/main.c include/sort.h
	mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c src/main.c -o $(MAIN_OBJ)

$(TEST_OBJ): tests/sort_test.c include/sort.h
	mkdir -p $(OBJ_DIR)
	$(CC) $(CFLAGS) -c tests/sort_test.c -o $(TEST_OBJ)

run: $(APP)
	./$(APP)

test: $(TEST)
	./$(TEST)

clean:
	rm -rf $(BUILD_DIR) $(BIN_DIR)

.PHONY: all clean run test
