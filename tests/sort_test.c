#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sort.h"

typedef int (*sort_fn)(int[], int);

static void assert_sorted_result(const char* name, int input[], int expected[], int size,
    sort_fn sorter) {
    int* working = (int*)malloc((size_t)size * sizeof(int));

    if (working == NULL) {
        fprintf(stderr, "Failed to allocate test buffer for %s.\n", name);
        exit(EXIT_FAILURE);
    }

    copy_array(input, working, size);
    if (!sorter(working, size)) {
        free(working);
        fprintf(stderr, "%s failed because memory allocation was unsuccessful.\n", name);
        exit(EXIT_FAILURE);
    }

    if (!is_sorted(working, size) ||
        memcmp(working, expected, (size_t)size * sizeof(expected[0])) != 0) {
        free(working);
        fprintf(stderr, "%s failed.\n", name);
        exit(EXIT_FAILURE);
    }

    free(working);
}

static void run_standard_suite(const char* name, sort_fn sorter) {
    int input1[] = {42, 7, 7, 19, -3, 0, 88, 12};
    int expected1[] = {-3, 0, 7, 7, 12, 19, 42, 88};
    int input2[] = {1};
    int expected2[] = {1};
    int input3[] = {9, 5, 3, 1, -2};
    int expected3[] = {-2, 1, 3, 5, 9};
    int input4[] = {1, 2, 3, 4, 5};
    int expected4[] = {1, 2, 3, 4, 5};

    assert_sorted_result(name, input1, expected1,
        (int)(sizeof(input1) / sizeof(input1[0])), sorter);
    assert_sorted_result(name, input2, expected2,
        (int)(sizeof(input2) / sizeof(input2[0])), sorter);
    assert_sorted_result(name, input3, expected3,
        (int)(sizeof(input3) / sizeof(input3[0])), sorter);
    assert_sorted_result(name, input4, expected4,
        (int)(sizeof(input4) / sizeof(input4[0])), sorter);

    if (!sorter(NULL, 0)) {
        fprintf(stderr, "%s should succeed on an empty input.\n", name);
        exit(EXIT_FAILURE);
    }
}

int main(void) {
    run_standard_suite("bubble_sort", bubble_sort);
    run_standard_suite("quick_sort", quick_sort);
    run_standard_suite("merge_sort", merge_sort);

    printf("All sorting tests passed.\n");
    return EXIT_SUCCESS;
}
