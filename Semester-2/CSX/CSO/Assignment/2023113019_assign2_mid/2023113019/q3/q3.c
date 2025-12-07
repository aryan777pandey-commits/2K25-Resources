#include <stdio.h>

//this hasnt been implemented here because using program stack directly in assembly
extern void solve(int arr[], int n, int result[]);

int main() {
    int n;
    scanf("%d", &n);
    int arr[n], result[n];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }
    solve(arr, n, result);
    for (int i = 0; i < n; i++) {
        printf("%d ", result[i]);
    }
    printf("\n");
    return 0;
}