/**
 * usage: select_sort n
 * n is the number of the array that will be sorted, 10 by default
 */

#include <stdio.h>
#include <stdlib.h>

void print_arr(int *arr, int n);
void select_sort(int *arr, int n);

int main(int argc, char **argv)
{
	int n;
	srand(time(0));
	if(argc == 1){
		n = 10;
	}else{
		n = atoi(argv[1]);
	}
	int *arr = (int *)malloc(sizeof(int) * n);
	int i;
	for(i=0; i<n; i++){
		arr[i] = (int)(rand() % 100);
	}
	printf("ini_array: ");
	print_arr(arr, n);
	select_sort(arr, n);
	printf("sorted_arr: ");
	print_arr(arr, n);
	free(arr);
}

void print_arr(int *arr, int n)
{
	int i;
	for(i=0; i<n; i++){
		if(!i){
			printf("%d", arr[i]);
		}else{
			printf(" %d", arr[i]);
		}
	}
	printf("\n");
}

void select_sort(int *arr, int n)
{
	int i;
	for(i=0; i<n; i++){
		int j, min_pos=i;
		for(j=i; j<n; j++){
			if(arr[j]<arr[min_pos]){
				min_pos = j;
			}
		}
		int tmp = arr[min_pos];
		arr[min_pos] = arr[i];
		arr[i] = tmp;
	}
}
