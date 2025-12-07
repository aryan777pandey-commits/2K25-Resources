#include <stdio.h>

long long int solve(long long int n, long long int* arr);

int main() {
  long long int n;
  scanf("%lld", &n);
  long long int arr[3*n+1];
  for (int i = 0; i < 3*n+1; i++) {
    scanf("%lld", arr + i);
  }
  long long int m = solve(n, arr);
  printf("%lld\n", m);
  return 0;
}
