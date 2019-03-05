/*
 * Performance evaluation and optimization project one
 *
 * To compile on the cluster, just run 'make'
 * To compile on most other systems, run 'make CC=gcc'
 */


#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

#include "./algorithms/bubble_sort.h"
#include "./algorithms/counting_sort.h"
#include "./algorithms/insertion_sort.h"
#include "./algorithms/merge_sort.h"
#include "./algorithms/quick_sort.h"
#include "./algorithms/radix_sort.h"
#include "./algorithms/selection_sort.h"

//checks if elements are in order, smallest to largest
int isSorted(int arr[], int n) {
  for(int i = 0; i < n - 1; i++) {
    if(arr[i] > arr[i + 1]) {
      return 0;
    }
  }
  return 1;
}

//prints an array and a newline at the end
void printArray(int arr[], int n) {
  for(int i = 0; i < n; i++) {
    printf("%d", arr[i]);
  }
  printf("\n");
}

//computes the difference from two timespecs in nano seconds and
//accounts for the overflow
long diff_in_ns(struct timespec t1, struct timespec t2) {
  struct timespec diff;
  if (t2.tv_nsec-t1.tv_nsec < 0) {
    diff.tv_sec  = t2.tv_sec - t1.tv_sec - 1;
    diff.tv_nsec = t2.tv_nsec - t1.tv_nsec + 1000000000;
  } else {
    diff.tv_sec  = t2.tv_sec - t1.tv_sec;
    diff.tv_nsec = t2.tv_nsec - t1.tv_nsec;
  }
  return (diff.tv_sec * 1000000000.0 + diff.tv_nsec);
}

int main(int argc, char *argv[]) {

  if(argc != 6) {
    printf("Usage: ./sorttest <algo_name> <arr_length> <arr_range> <num_reps> <verify?>\n");
    exit(1);
  }

  char *algorithm = argv[1];
  int arr_length = atoi(argv[2]);
  int arr_range = atoi(argv[3]);
  int num_reps = atoi(argv[4]);
  char *verify = argv[5];
  int num_correct = 0;
  int arr[arr_length];
  //create function pointers to cut down on if/else statements in the loop
  void (*two_arg_sorting_alg)(int[], int) = bubble_sort;  //the two-arg sorting function to call (initialized arbitrarily)
  void (*three_arg_sorting_alg)(int[], int, int) = quick_sort; //the three-arg sorting function to call (initialized arbitrarily)
  int arg_two = arr_length; //the second argument to the sorting algorithm
  int arg_three = -1; //the third argument to the sorting algorithm (if applicable)


  fprintf(stderr, "DEBUG: arr = %p\n", arr);


  
  //decide on the sorting algorithm
  if (strcmp(algorithm, "bubble") == 0) {
    two_arg_sorting_alg = bubble_sort;
  } else if (strcmp(algorithm, "counting") == 0) {
    arg_three = arr_range;
    three_arg_sorting_alg = counting_sort;
  } else if (strcmp(algorithm, "insertion") == 0) {
    two_arg_sorting_alg = insertion_sort;    
  } else if (strcmp(algorithm, "merge") == 0) {
    two_arg_sorting_alg = merge_sort;
  } else if (strcmp(algorithm, "quick") == 0) {
    arg_two = 0;
    arg_three = arr_length - 1;
    three_arg_sorting_alg = quick_sort;
  } else if (strcmp(algorithm, "radix") == 0) {
    two_arg_sorting_alg = radix_sort;
  } else if (strcmp(algorithm, "selection") == 0) {
    two_arg_sorting_alg = selection_sort;
  } else {
    printf("Sorting algorithm not supported.\n");
    exit(1);
  }


  //run a series of tests for the chosen sorting algorithm
  srand(time(NULL));
  for(int i = 1; i <= num_reps; i++) {
    for(int i = 0; i < arr_length; i++) {
      arr[i] = rand() % arr_range;
    }
    
    // Uncomment to print array pre sorting
    // printArray(arr, arr_length);

    struct timespec start, finish;
    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &start);
    
    if (arg_three < 0) {
      two_arg_sorting_alg(arr, arg_two);
    } else {
      three_arg_sorting_alg(arr, arg_two, arg_three);
    }

    clock_gettime(CLOCK_PROCESS_CPUTIME_ID, &finish);

    long diff = diff_in_ns(start, finish);

    printf("%s,%d,%d,%d,%ld", algorithm, arr_length, arr_range, i, diff);
    printf("\n");
    
    // Uncomment to print array post sorting
    // printArray(arr, arr_length);
    
    if(strcmp(verify, "TRUE") == 0 && isSorted(arr, arr_length)) {
      num_correct++;
    }
  }

  if(strcmp(verify, "TRUE") == 0) {
    printf("Correctly Sorted: %d/%d\n", num_correct, num_reps);
  }
    
  return 0;
}
