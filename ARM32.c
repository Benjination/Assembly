#include <stdio.h>
#include <stdlib.h>

// Declare the external assembly function
extern u_int32_t LSL32(u_int32_t x, u_int32_t y);
extern u_int32_t LSR32(u_int32_t x, u_int32_t y);

int main()
{
    int select;
    printf("Select an option\n");
    printf("1. LSL (Right BitShift)\n2. LSR (Left Bitshift)\n");
    scanf("%d", select);
    
    u_int32_t x, y, result;
    
    switch(select)
    {
        case 1:
            printf("Enter decimal number to be shifted");
            scanf("%d", x);
            printf("Enter number of bits to shift");
            scanf("%d", y);
            result = LSL32(x, y);
        case 2:
            printf("Enter decimal number to be shifted");
            scanf("%d", x);
            printf("Enter number of bits to shift");
            scanf("%d", y);
            result = LSR32(x, y);
             
    }
    
    printf("%d\n", result); 

    return 0;
}
