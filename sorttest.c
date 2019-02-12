#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

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
      return 1;
    }
  }
  return 0;
}

//prints an array and a newline at the end
void printArray(int arr[], int n) {
  for(int i = 0; i < n; i++) {
    printf("%d", arr[i]);
  }
  printf("\n");
}

//program sorts an n length array with values up to m range with
//algorithm x. It repeats the process y times, and verifies if sort
//worked as desired.
int main(int argc, char *argv[]) {
  if(argc != 6) {
    printf("Usage: ./sorttest <algo_name> <arr_length> <arr_range> <num_reps> <verify?>\n");
    exit(1);
  }

  //string algo = argv[1]
  int arr_length = atoi(argv[2]);
  int arr_range = atoi(argv[3]);
  int num_reps = atoi(argv[4]);
  //string verify = argv[5]

  int num_correct = 0;
  
  int arr[arr_length];
  srand(time(NULL));
  
  for(int i = 0; i < num_reps; i++) {

    for(int i = 0; i < arr_length; i++) {
      arr[i] = rand() % arr_range;
    }

    //printArray(arr, arr_length);
 
    if (strcmp(argv[1], "bubble") == 0) {
      bubble_sort(arr, arr_length);
    } else if (strcmp(argv[1], "counting") == 0) {
      counting_sort(arr, arr_length, arr_range);
    } else if (strcmp(argv[1], "insertion") == 0) {
      insertion_sort(arr, arr_length);    
    } else if (strcmp(argv[1], "merge") == 0) {
      merge_sort(arr, arr_length);
    } else if (strcmp(argv[1], "quick") == 0) {
      quick_sort(arr, 0, arr_length - 1);
    } else if (strcmp(argv[1], "radix") == 0) {
      radix_sort(arr, arr_length);
    } else if (strcmp(argv[1], "selection") == 0) {
      selection_sort(arr, arr_length);
    } else {
      printf("Sorting algorithm not supported.\n");
      exit(1);
    }

    //printArray(arr, arr_length);

    if(strcmp(argv[5], "TRUE") == 0 && isSorted(arr, arr_length) == 0) {
      num_correct++;
    }
  }

  if(strcmp(argv[5], "TRUE") == 0) {
    printf("Correctly Sorted: %d/%d\n", num_correct, num_reps);
  }
    
  return 0;
}
