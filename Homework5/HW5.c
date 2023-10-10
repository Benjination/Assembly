#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct _BUSINESS2
{
    uint32_t taxId;
    char name[27];
    char direction;
    char street[35];
    uint32_t addNo;
    char city[30];
    char state[3];
    uint32_t zip;
} BUSINESS2;


extern int32_t sumS32(const int32_t x[], uint32_t count);
extern  int32_t dotpS32(const int32_t x[], const int32_t y[], uint32_t count);
extern  uint32_t countAboveLimit(const int32_t x[], int32_t limit, uint32_t count);
extern  int32_t findCityAligned (const char city[], const BUSINESS2 business[], uint32_t count);
extern  int32_t findCityPacked (const char city[], const BUSINESS2 business[], uint32_t count);


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