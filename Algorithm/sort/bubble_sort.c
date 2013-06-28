/**
 * usage: bubble_sort n
 * n is the number of the array that will be sorted, 10 by default
 */

#include <stdio.h>
#include <stdlib.h>

void print_arr(int *arr, int n);
void sort(int *arr, int n);

int main(int argc, char **argv)
{
	int n;
	srand(time(0));
	if(argc == 1){
		n = 10; }else{ n = atoi(argv[1]);
	}
	int *arr = (int *)malloc(sizeof(int) * n);
	int i;
	for(i=0; i<n; i++){
		arr[i] = (int)(rand() % 100);
	}
	printf("ini_array: ");
	print_arr(arr, n);
	sort(arr, n);
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

void sort(int *arr, int n)
{
	int i;
	for(i=n-1; i>0; i--){
		int j;
		for(j=0; j<i; j++){
			if(arr[j] > arr[j+1]){
				int tmp = arr[j];
				arr[j] = arr[j+1];
				arr[j+1] = tmp;
			}
		}
	}
}
