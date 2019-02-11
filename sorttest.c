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

int main(int argc, char *argv[]) {
  //check usage
  if(argc != 5) {
    printf("Usage: ./sorttest <algo> <length> <range> <repetitions>\n");
    exit(1);
  }

  
  //save inputs for convenience
  int arr_length = atoi(argv[2]);
  int arr_range = atoi(argv[3]);
  int num_reps = atoi(argv[4]);
  
  for(int i = 0; i < num_reps; i++) {
    //create random array
    srand(time(NULL));
    int arr[arr_length];
    for(int i = 0; i < arr_length; i++) {
      arr[i] = rand() % arr_range;
    }

 
    //do the sort
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
    
  }
    
  return 0;
}
