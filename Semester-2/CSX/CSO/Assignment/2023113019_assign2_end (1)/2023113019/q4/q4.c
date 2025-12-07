#include <stdio.h>
extern long long int findMajorityElement(long long int arr[], int size);

int main() {
    int n;
    scanf("%d", &n);
    long long int arr[n];
    for (int i = 0; i < n; i++) {
        scanf("%lld", &arr[i]);  
    }
    long long int majorityElement = findMajorityElement(arr, n);
    printf("%lld\n", majorityElement);  
    return 0;
}