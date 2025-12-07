#include <stdio.h>

// Function prototype for assembly function
void rotate_right_2(int *arr, int n);

// void rotate_right_2(int *arr, int n) {
//     if (n <= 2) return; // No need to rotate if n <= 2

//     // Store the last two elements
//     int second_last = arr[n - 2];
//     int last = arr[n - 1];

//     // Shift elements to the right by 2 places
//     for (int i = n - 3; i >= 0; i--) {
//         arr[i + 2] = arr[i];
//     }

//     // Place the last two elements at the beginning
//     arr[0] = second_last;
//     arr[1] = last;
// }

int main() {
    int n;
    scanf("%d", &n);  // Read size of the array
    int arr[n];
    for (int i = 0; i < n; i++) {
        scanf("%d", &arr[i]);  // Read array elements
    }

    rotate_right_2(arr, n); // Call assembly function

    for (int i = 0; i < n; i++) {
        printf("%d ", arr[i]); // Print rotated array
    }
    printf("\n");
    return 0;
}