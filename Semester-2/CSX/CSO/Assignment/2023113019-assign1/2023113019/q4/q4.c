#include <stdio.h>

extern int find_min_max_diff(int* arr, int n);

int main() {
    int n;
    scanf("%d", &n);
    int arr[n];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);
    }
    int result = find_min_max_diff(arr, n);
    printf("%d\n", result);
    return 0;
}