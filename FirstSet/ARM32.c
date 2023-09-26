//Benjamin Niccum btn1609@mavs.uta.edu

#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

// Declare the external assembly function
extern u_int32_t LSL32(u_int32_t x, u_int32_t y);
extern u_int32_t LSR32(u_int32_t x, u_int32_t y);
extern u_int32_t ASR32(u_int32_t x, u_int32_t y);
extern u_int32_t ASL32(u_int32_t x, u_int32_t y);

int main()
{
    

    int select;
    printf("Select an option\n");
    printf("1. LSL (Right BitShift)\n2. LSR (Left Bitshift)\n3. ASR (Arithmetic Shift Right)\n4. ASL (Just Use LSL)");
    scanf("%d", &select);
    
    u_int32_t x, y, result;
    
    switch(select)
    {
        case 1:
            printf("Enter decimal number to be shifted\n");
            scanf("%u", &x);
            printf("Enter number of bits to shift\n");
            scanf("%u", &y);
            result = LSL32(x, y);
            break;
        case 2:
            printf("Enter decimal number to be shifted\n");
            scanf("%u", &x);
            printf("Enter number of bits to shift\n");
            scanf("%u", &y);
            result = LSR32(x, y);
            break;
        case 3:
            printf("Enter decimal number to be shifted\n");
            scanf("%u", &x);
            printf("Enter number of bits to shift\n");
            scanf("%u", &y);
            result = ASR32(x, y);
            break;
         case 4:
            printf("The result will be the same as LSL.\n");
            printf("Enter decimal number to be shifted\n");
            scanf("%u", &x);
            printf("Enter number of bits to shift\n");
            scanf("%u", &y);
            result = LSL32(x, y);
            break;
            }
        
            printf("The result is: %u\n", result); 
            char dump;
            printf("Press Enter to end program");
            scanf("%s", dump);
        
       
    return 0;
}
