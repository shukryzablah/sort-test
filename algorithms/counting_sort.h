/*

Counting sort

Worst case performance: O(n+k)
Best case performance: Ω(n+k)
Average performance: Θ(n+k)
Worst case space complexity: O(n+k)

*/

#include <stdlib.h>

/*
  arr -- the input array of integers to be sorted
  n -- the length of the input array
  k -- a number such that all integers are in the range 0..k-1
*/
void counting_sort(int arr[], int n, int k)
{
  int* freq = (int*)calloc(k, sizeof(*freq));

  // using value of integer in the input array as index,
  // store count of each integer in freq[] array
  for (int i = 0; i < n; i++)
    freq[arr[i]]++;
  
  // overwrite the input array with sorted order
  int index = 0;
  for (int i = 0; i < k; i++)
    {
      while (freq[i]--)
	arr[index++] = i;
    }
}

