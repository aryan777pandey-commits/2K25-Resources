#include <stdio.h>

long long int* solve(long long int n, long long int* arr, long long int* arr2);

int main() {
    long long int n;
    scanf("%lld", &n);
    long long int arr[n];
    for (int i = 0; i < n; ++i) {
        scanf("%lld", arr+i);
    }
    long long int arr2[n];
    long long int* ans = solve(n, arr, arr2);
    for (int i = 0; i < n; ++i) {
        printf("%lld ", ans[i]);
    }
    printf("\n");
}