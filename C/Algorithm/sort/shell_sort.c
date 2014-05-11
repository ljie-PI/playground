/**
 * usage: shell_sort n
 * n is the number of the array that will be sorted, 10 by default
 */

#include <stdio.h>
#include <stdlib.h>

void print_arr(int *arr, int n);
void shell_sort(int *arr, int n);
void exch(int * arr, int i, int j);

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
	shell_sort(arr, n);
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

void exch(int * arr, int i, int j){
	int tmp = arr[i];
	arr[i] = arr[j];
	arr[j] = tmp;
}

/*
void shell_sort(int *arr, int n)
{
	int step = 1;
	while(step * 3 <= n) step = step * 3 + 1;
	while(step >= 1){
		int i;
		for(i=step; i<n; i++){
			int j;
			for(j=i; j>=step; j-=step){
				if(arr[j] < arr[j-step]) exch(arr, j, j-step);
			}
		}
		step /= 3;
	}
}
*/
void shell_sort(int *arr, int n)
{
	int step = 1;
	while(step * 3 <= n) step = step * 3 + 1;
	while(step >= 1){
		int i;
		for(i=step; i<n; i++){
			int j;
			for(j=i; j>=step && arr[j]<arr[j-step]; j-=step){
				exch(arr, j, j-step);
			}
		}
		step /= 3;
	}
}
