#include <stdio.h>
#include <string.h>

// Function prototype for assembly function
int is_palindrome(const char *s, int len);

int main() {
    char s[1000000];  // Input string
    scanf("%s", s);  // Read input string

    int len = strlen(s);
    int result = is_palindrome(s, len);  // Call assembly function

    printf("%d\n", result);  // Print result
    return 0;
}