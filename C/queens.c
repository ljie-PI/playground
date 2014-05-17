#include <stdio.h>
#include <stdlib.h>

void print_queens(int *queens, int n, int resolved)
{
    int i;
    printf("Solution %d: ", resolved);
    for (i = 0; i < n; i++) {
        printf("%d", queens[i]);
        if (i == n-1) {
            printf("\n");
        } else {
            printf(",");
        }
    }
}

void init(int *queens, int n)
{
    int i;
    for (i = 0; i < n; i++) {
        queens[i] = -1;
    }
}

int place_valid(int *queens, int row, int col)
{
    int i;
    for (i = 0; i <= row; i++) {
        if (queens[i] == col)
            return 0;
        if (row - i == queens[i] - col
                || row - i == col - queens[i]) {
            return 0;
        }
    }
    return 1;
}

void resolve(int *queens, int n)
{
    int i = 0, j = 0, resolved = 0;
    while (i < n) {
        while (j < n) {
            if (place_valid(queens, i, j)) {
                queens[i] = j;
                j = 0;
                break;
            } else {
                j++;
            }
        }
        if (queens[i] == -1) { // if no place in (i+1)th row valid
            if (i == 0) { // no place for 1st row valid
                break;
            } else {
                i--;
                j = queens[i] + 1;
                queens[i] = -1;
                continue;
            }
        } else { // valid place for (i+1)th row
            if (i == n - 1) { // valid place for nth row
                resolved++;
                print_queens(queens, n, resolved);
                j = queens[i] + 1;
                queens[i] = -1;
                continue;
            }
        }
        i++;
    }
}

void queens(int n)
{
    int *queens = (int *)malloc(n * sizeof(int));
    init(queens, n);
    resolve(queens, n);
    free(queens);
}

int main()
{
    printf("Please input the number of queeens:\n");
    int n = 0;
    scanf("%d", &n);
    printf("%d queens\n", n);
    queens(n);
    return 0;
}

