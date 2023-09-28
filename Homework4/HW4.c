#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>


extern bool isStrEqual(const char str1[], const char str2[]);
extern void strConcatenate(char strTo[], const char strFrom[]);
extern void leftString(char* strOut, const char* strIn, uint32_t length);
extern int16_t decimalStringToInt16(const char * str);
extern uint8_t hexStringToUint8(const char * str);


int main()
{
    char s[20] = "Hello World";
    //s = "Hello World";
    int m = 2; //nth number of letters in string
    int x = 8;
    int y = 16;

    int z = isStrEqual(x, y);

    printf("%d", z);

    return 0;
}