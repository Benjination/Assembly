//Benjamin Niccum
#include <stdio.h>
#include <stdint.h>

typedef struct __attribute__((packed)) _BUSINESS2
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

int main(void) 
{
    printf("Offset of taxId: %p\n", (void*)&((BUSINESS2*)0)->taxId);
    printf("Offset of name: %p\n", (void*)&((BUSINESS2*)0)->name);
    printf("Offset of direction: %p\n", (void*)&((BUSINESS2*)0)->direction);
    printf("Offset of street: %p\n", (void*)&((BUSINESS2*)0)->street);
    printf("Offset of addNo: %p\n", (void*)&((BUSINESS2*)0)->addNo);
    printf("Offset of city: %p\n", (void*)&((BUSINESS2*)0)->city);
    printf("Offset of state: %p\n", (void*)&((BUSINESS2*)0)->state);
    printf("Offset of zip: %p\n", (void*)&((BUSINESS2*)0)->zip);

    return 0;
}