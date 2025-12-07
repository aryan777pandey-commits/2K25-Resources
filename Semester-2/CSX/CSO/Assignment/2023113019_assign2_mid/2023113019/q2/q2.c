#include <stdio.h>

extern int n_fact(int i, int r);
extern int solve(int n, int r);

// int n_fact(int i, int r){
// this code doesnt handle base case 0
//     if(i==r)
//     return 1;
//     return i*n_fact(i-1,r);
// }

// int solve(int n, int r){
//     // printf("flag n(n-1)...(n-r+1) %d\n",n_fact(n,r));
//     return n_fact(n,n-r)/n_fact(r,1);
// }

int main(){
    int n, r;
    scanf("%d %d",&n,&r);
    int ans = solve(n,r);
    printf("%d\n",ans);
    return 0;
}