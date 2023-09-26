//Stuff from in class
#include <stdio.h>
#include <stdlib.h>


extern int maxUint8(int x, int y);
extern uint32_t StrLen(char s[20]);
extern uint32_t StrLenSpec(char s[20], char n);
extern uint32_t StrLenSpecInt(char s[20], char n, int m);

int main()
{
    char s[20] = "Hello World";
    //s = "Hello World";
    int m = 2; //nth number of letters in string
    int x = 8;
    int y = 16;

    int z = maxUint8(x, y);

    printf("%d", z);

    return 0;
}