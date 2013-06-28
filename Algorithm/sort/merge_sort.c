/**
 * usage: merge_sort n
 * n is the number of the array that will be sorted, 10 by default */

#include <stdio.h>
#include <stdlib.h>

void print_arr(int *arr, int n);
void merge_sort(int *arr, int n);
void merge(int *arr, int lo, int mid, int hi);

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
	merge_sort(arr, n);
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

void merge_sort(int *arr, int n)
{
	int step = 1;
	while(step < n){
		int i;
		for(i=0; i<n; i+=2*step){
			if(i+step < n){
				int min = i+step*2 < n ? i+step*2 : n;
				merge(arr, i, i+step, min);
			}
		}
		step *= 2;
	}
}

void merge(int *arr, int lo, int mid, int hi){
	int len = hi - lo;
	int *aux = (int *)malloc(sizeof(int) * len);
	int k,i,j;
	for(k=0; k<len; k++)
		aux[k] = arr[k+lo];
	i = 0; j=mid-lo;
	for(k=lo; k<hi; k++){
		if(i == mid-lo) arr[k] = aux[j++];
		else if(j == hi-lo) arr[k] = aux[i++];
		else if(aux[i] < aux[j]) arr[k] = aux[i++];
		else arr[k] = aux[j++];

	}
	free(aux);
}
