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
    printf("Offset of taxId: HEX %p", (void*)&((BUSINESS2*)0)->taxId);
    printf("  DEC %d\n", (int)((char*)&((BUSINESS2*)0)->taxId - (char*)0));
    printf("Offset of name: HEX %p", (void*)&((BUSINESS2*)0)->name);
    printf("  DEC %d\n", (int)((char*)&((BUSINESS2*)0)->name - (char*)0));
    printf("Offset of direction: HEX %p", (void*)&((BUSINESS2*)0)->direction);
    printf("  DEC %d\n", (int)((char*)&((BUSINESS2*)0)->direction - (char*)0));
    printf("Offset of street: HEX %p", (void*)&((BUSINESS2*)0)->street);
    printf("  DEC %d\n", (int)((char*)&((BUSINESS2*)0)->street - (char*)0));
    printf("Offset of addNo: HEX %p", (void*)&((BUSINESS2*)0)->addNo);
    printf("  DEC %d\n", (int)((char*)&((BUSINESS2*)0)->addNo - (char*)0));
    printf("Offset of city: HEX %p", (void*)&((BUSINESS2*)0)->city);
    printf("  DEC %d\n", (int)((char*)&((BUSINESS2*)0)->city - (char*)0));
    printf("Offset of state: HEX %p", (void*)&((BUSINESS2*)0)->state);
    printf("  DEC %d\n", (int)((char*)&((BUSINESS2*)0)->state - (char*)0));
    printf("Offset of zip: HEX %p", (void*)&((BUSINESS2*)0)->zip);
    printf("  DEC %d\n", (int)((char*)&((BUSINESS2*)0)->zip - (char*)0));

    return 0;
}