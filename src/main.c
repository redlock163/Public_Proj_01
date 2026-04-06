#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include "sort.h"

static void fill_random_array(int arr[], int n, int max_value) {
    for (int i = 0; i < n; i++) {
        arr[i] = rand() % max_value;
    }
}

static int bubble_sort_adapter(int arr[], int n) {
    bubble_sort(arr, n);
    return 1;
}

static void run_demo_sort(const char* name, int arr[], int size, int (*sorter)(int[], int)) {
    printf("%s:\n", name);
    if (!sorter(arr, size)) {
        fprintf(stderr, "%s failed because memory allocation was unsuccessful.\n", name);
        exit(EXIT_FAILURE);
    }
    print_array(arr, size);
    printf("Sorted: %s\n\n", is_sorted(arr, size) ? "Yes" : "No");
}

static void run_demo(void) {
    const int size = 10;
    int original[size];
    int working[size];

    fill_random_array(original, size, 100);

    printf("Generating random array of size %d:\n", size);
    print_array(original, size);
    printf("\n");

    copy_array(original, working, size);
    bubble_sort(working, size);
    printf("Bubble Sort:\n");
    print_array(working, size);
    printf("Sorted: %s\n\n", is_sorted(working, size) ? "Yes" : "No");

    copy_array(original, working, size);
    run_demo_sort("Quick Sort", working, size, quick_sort);

    copy_array(original, working, size);
    run_demo_sort("Merge Sort", working, size, merge_sort);
}

static void run_benchmark_sort(const char* name, int source[], int working[], int size,
    int (*sorter)(int[], int)) {
    clock_t start, end;
    double time_used;

    copy_array(source, working, size);
    start = clock();
    if (!sorter(working, size)) {
        fprintf(stderr, "%s failed because memory allocation was unsuccessful.\n", name);
        exit(EXIT_FAILURE);
    }
    end = clock();
    time_used = ((double)(end - start)) / CLOCKS_PER_SEC;
    printf("%s time: %.4f seconds\n", name, time_used);
}

static void run_benchmark(void) {
    const int size = 10000;
    int* original = (int*)malloc(size * sizeof(int));
    int* working = (int*)malloc(size * sizeof(int));

    if (original == NULL || working == NULL) {
        free(original);
        free(working);
        fprintf(stderr, "Failed to allocate benchmark buffers.\n");
        exit(EXIT_FAILURE);
    }

    fill_random_array(original, size, 10000);

    printf("Performance test with larger array (%d elements):\n", size);
    run_benchmark_sort("Bubble Sort", original, working, size, bubble_sort_adapter);
    run_benchmark_sort("Quick Sort", original, working, size, quick_sort);
    run_benchmark_sort("Merge Sort", original, working, size, merge_sort);

    free(original);
    free(working);
}

int main(void) {
    srand((unsigned int)time(NULL));
    run_demo();
    run_benchmark();

    return 0;
}
