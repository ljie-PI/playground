/*
gcc -o test union_find.c
./test < input.txt
*/
#include <stdio.h>
#include <stdlib.h>

typedef struct UF{/*{{{*/
	int *parent;
	int *nodes_num;
	int N;
	int component_num;
} union_find;/*}}}*/

void init_uf(union_find **UFptr, int N){/*{{{*/
	*UFptr = (union_find *)malloc(sizeof(union_find));
	union_find *UF = *UFptr;
	UF->component_num = UF->N = N;
	UF->parent = (int *)malloc(sizeof(int) * N);
	UF->nodes_num = (int *)malloc(sizeof(int) * N);
	int i;
	for(i=0; i<N; i++){
		UF->parent[i]= i;
		UF->nodes_num[i] = 1;
	}
}/*}}}*/

int find_root(union_find *UF, int pos){/*{{{*/
	int root = pos;
	while(UF->parent[root] != root){
		root = UF->parent[root];
	}	
	return root;
}/*}}}*/

void connect(union_find *UF, int node1, int node2){/*{{{*/
	int root1 = find_root(UF, node1);
	int root2 = find_root(UF, node2);
	if(root1 == root2) return;
	
	if(UF->nodes_num[root1] < UF->nodes_num[root2]){
		UF->parent[root1] = root2;
		UF->nodes_num[root2] += UF->nodes_num[root1];
	}else{
		UF->parent[root2] = root1;
		UF->nodes_num[root1] += UF->nodes_num[root2];
	}
	UF->component_num --;
}/*}}}*/

void destroy_uf(union_find **UFptr){/*{{{*/
	union_find *UF = *UFptr;
	free(UF->parent);
	free(UF->nodes_num);
	free(UF);
}/*}}}*/

void print_result(union_find *UF){/*{{{*/
	int i;
	printf("Roots of the elements are: ");
	for(i=0; i<UF->N; i++){
		printf("%d ", find_root(UF, i));
	}
	printf("\nThere are %d components after connections", UF->component_num);
}/*}}}*/

int main(){
	union_find *UF;
	int N;
	scanf("%d\n", &N);
	printf("%d\n", N);
	init_uf(&UF, N);
	int node1, node2;
	while(scanf("%d %d\n", &node1, &node2)>0){
		printf("%d %d\n", node1, node2);
		connect(UF, node1, node2);
	}
	print_result(UF);
	destroy_uf(&UF);
}
