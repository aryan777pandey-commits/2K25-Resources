#include <stdio.h>

extern void prefix_sum(int n, int arr[], int psum[]);
extern int solve(int arr[], int n,int*psar);

// void prefix_sum(int n, int arr[],int * psum){
//     //calculates prefix sum with n+1 index
//     psum[0] = 0;
//     for(int i = 0;i<n;i++){
//         psum[i+1] = psum[i]+arr[i];
//     }
// }

// int solve(int arr[], int n,int*psar){
//     int ans = 0;
//     for(int i = 0;i<n+1;i++){
//         for(int j = i+1;j<n+1;j++){
//             if(psar[i]==psar[j]){
//                 // printf("flag i: %d j:%d psar[i+1]:%d psar[j+1]:%d\n",i,j,psar[i+1],psar[j+1]);
//                 ans++;
//             }
//         }
//     }
//     // printf("\n"); // debug line
//     return ans;
// }

int main(){
    int n;
    scanf("%d", &n);
    int arr[n];
    for(int i = 0;i<n;i++){
        scanf("%d", &arr[i]);
    }
    int psum[n+1];
    prefix_sum(n,arr,psum);
    int ans = solve(arr, n, psum);
    printf("%d\n", ans);
    return 0;
}