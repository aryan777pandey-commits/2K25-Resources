#include <stdio.h>
extern int findPeak(short ar[], int size);

int main() {
    int n;
    scanf("%d", &n);
    short ar[n];
    for (int i = 0; i < n; i++) {
        scanf("%hd", &ar[i]);
    }
    int peakValue = findPeak(ar, n);
    printf("%d\n", peakValue);
    return 0;
}