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
    int choice = -1, boolResult= -1, length = -1, index = -1, intResult = -1;
    char str1[30], str2[30], strcat[60];
    while(choice != 6)
    {
        printf("What would you like to do?\n1. Check if two strings are the same.\n2. Combine two strings.\n");
        printf("3. Cut part of a srting from a string.\n4. Change a string into a decimal number.\n");
        printf("5. Change a Hexidecimal number into a decimal number.\n6. Exit");
        scanf("%d", &choice);

        switch(choice) 
        {
            case 1:
                printf("You chose option 1.\n");
                printf("Please enter the first string:\n");
                scanf("%s", str1);
                printf("Please enter the second string");
                scanf("%s", str2);
                boolResult = isStrEqual(str1, str2);
                if (boolResult == 1)
                    printf("The strings match.");
                else
                    printf("These two strings are not the same.");
                break;
            case 2:
                printf("You chose option 2.\n");
                printf("Please enter the first string:\n");
                scanf("%s", str1);
                printf("Please enter the second string;\n");
                scanf("%s", str2);
                strConcatenate(str1, str2);
                printf("The new string is %s", str1);
                break;
            case 3:
                printf("You chose option 3.\n");
                printf("Please enter your original String:\n");
                scanf("%s", str1);
                printf("At which index would you like to start you new string?\n");
                printf("Example, %c = 1, %c = 2 %c = 3, etc...", str1[0], str1[1], str1[2]);
                scanf("%d", &index);
                printf("How many characters would you like you new string to be?");
                scanf("%d",length);
                leftString(str2, str1, length);
                printf("Your new string is %s", str2);
                break;
            case 4:
                printf("You chose option 4.\n");
                printf("Please enter a string the is in the form of a number:\n");
                scanf("%s", str1);
                intResult = decimalStringToInt16(str1);
                if(intResult = -1)
                {
                    printf("One of the elements you entered in your string is not in the form of a number, i.e. 1-9\n");
                    printf("Please try again.\n");
                }
                else
                {
                    printf("The integer version of your string is: %d", intResult);
                    printf("You'll just have to take my word for it that this is now saved as an integer instead of a string.");
                }
                break;
            case 5:
                printf("You chose option 5.\n");
                printf("A hexidecimal number countains 0-9 and a-f in place of the numbers 10-15.\n");
                printf("Sometimes they are written with an 0x prefix. Please leave off this prefix when entering your hex-number.\n");
                printf("Please enter your hex-number in the format: 01a8dc112 or some similar number.");
                scanf("%s", str1);
                printf("The hexidecimal number you entered is 0x%s", str1);
                intResult = hexStringToUint8(str1);
                if (intResult != -1)
                    printf("The decimal equivalent of your hex-number is %d", intResult);
                else
                    printf("One of the values of your hex number is not 1-9 or a-f.\nPlease try again. ");
                break;
            case 6:
                printf("You chose option 6.\n");
                printf("Have a nice day.");
                break;
            default:
                printf("Invalid choice. Please try again\n");
                break;
        }
    }

    return 0;
}