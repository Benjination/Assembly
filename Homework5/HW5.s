.global  sumS32
.global  dotpS32
.global  countAboveLimit
.global  findCityAligned
.global  findCityPacked

.text

sumS32: //sums the numbers in an integer array
//R0 = array of integers, R1 = Number of elements in array, R2 = Sum of integers
    PUSH {R4}             //Gives access to register 4
    MOV R2, #0            //Sum set to 0
    MOV R3, R1            //Moves number of elements into register 3
loop:                     //exits loop when count is reduced to 0
    LDR R1, [R0], #4      //Loads first integer into R1
    ADD R2, R2, R1        //adds integer in R1 to running sum and places in R2
    SUBS R3, R3, #1       //decrement the number of integers left in array by 1, sets flags
    BNE loop              //Loops if number of integers laft in array is not zero
    MOV R0, R2            //Moves running sum into R0 to be returned
    POP {R4}              //Restores R4 to original form
    BX LR                 //Returns to C


dotpS32:  // returns the dot product of the values in the arrays (x and y) containing count entries.
//(const int32_t x[], const int32_t y[], uint32_t count)
//R0= integer array 1, R1 = Integer Array 2, R2 = Number of integer sets to multiply x^n=y^n, R3=Will hold IntArray1
//[2,4,6]
//[1,5,8]
//Will multiply the matrixes together and sum the products
//returns single 32 bit integer...
    PUSH {R4}             //Allows access to Register 4
    MOV R3, R0            //Move intarray in R0 to R3
    MOV R0, #0            //Sets running sum to 0
    loop_start:           //exits loop when decrement count reaches zero
        CMP R1, #0        //Checks to see if integer array is empty
        BEQ exit          //If there are no integers in array, returns 0
        LDR R3, [R3], #4  //Loads integer from intarray1 into reg3, post iterates 4 bytes (sizeof int)
        LDR R4, [R1], #4  //Loads integer from intarray2 into reg4, moves to next int
        MUL R3, R3, R4    //Multiplies two integers selected from the arrays, places in R3
        ADD R0, R0, R3    //Adds product to running sum
        SUB R2, R2, #1    //Decrement counter by 1
        CMP R2, #0        //Compare counter to 0
        BNE loop_start    //If counter has not reached zero, jump to loop
    exit:
        POP {R4}           //Restores Register 4 to original conditions 
        BX LR              //Returns to C Program


countAboveLimit:
//Returns single 32 bit integer
//(const int32_t x[], int32_t limit, uint32_t count)
//R0 = integer array(later count of numbers greater thsn delim), R1= Delimiter (Number to compare) 
//R2 = Number of integers in array, r3=move array here, r4= number to be compared
//returns number of values in the array (x) containing count entries that are > limit
    PUSH {R4}              //Grants access to register 4
    MOV R3, R0             //Moves int array from R0 to R3
    MOV R0, #0             //Initializes count to zero
    loop_start:            //exit loop when count is reduced to zer0
        CMP r2, #0         //Checks to see if there are still integers in the array
        BEQ loop_end       //If there are no more integers to check, jump to loop_end
        LDR r4, [r3], #4   //Loads first integer into register 4
        CMP r4, r1         //Compares integer to delimiter
        BLE loop_start     //If int is less then or equal to delim, jump back to loop_start
        ADD r0, r0, #1     //if int is larger, increase counter by one
        SUBS r2, r2, #1    //reduces number of integers left to check by one
        B loop_start       //Always go back to loop_start
    loop_end:              //exits the program
    POP {R4}               //Restore R4 to original conditions
    BX LR                  //Returns to C program

findCityAligned:
//int32_t findCityAligned (const char city[], const BUSINESS2 business[], uint32_t count)
//R0 = City
//R1 = Business Array
//R2 = Number of Businesses in array
//R4 = Address of Business array
//R5 = City
    PUSH {R4-R10}
    MOV R5, R0	     //Moves City name into R5 "Clean Copy"
    MOV R4, R1	     //Move the address of 1st business into R4
    ADD R4, R4, #72  //Move head to address of city in first business array
    MOV R3, #112     //Create a variable equal to the size of the business array
    MOV R10, #0	     //R10 will hold the Index until we are ready to return the index to C
    CMP R2, #0	     //Check if the array is empty
test_string:
    BEQ test_exit_not_found   //If the array is empty, break to sub-function
    MOV R6, R4			      //It is necessary to keep R4 at the beginning of the city for when we increment by size of struct
    //                          So this is a copy of R4 that will change as we compare strings
    MOV R7, R0			      //Make a copy of the City name we are testing. 
test_string_loop:             //This will test the string against the City name inside the struct
    LDRSB R8, [R6], #1        //Loads the first letter of the City name inside the struct
    LDRSB R9, [R7], #1        //Loads the first letter of the string
    CMP R8, R9                //Checks if they are the same
    BNE next_business		  //If the strings do not match, break to sub-function
    CMP R8, #0			      //Checks for Null terminator
    BEQ test_exit_found       //If R8 reaches null terminator without finding any difference, City is found
    B test_string_loop        //Null Terminator not found, loop to next letter in strings
next_business:                //Previous strings did not match, move to next struct
    ADD R4, R4, R3			  //Add the total length of struct to R4 to move pointer to next struct 
    ADD R10, R10, #1		  //Increment the index counter
    SUBS R2, R2, #1			  //Decrement the number of businesses left in the array and set flags
    B test_string             //Always break to sub-function
test_exit_found:              //Exits with index of array
    MOV R0, R10               //Moves index into R0 to return
    POP {R4-R10}              //Restores R4-R10 to original conditions
    BX  LR                    //Returns to C
test_exit_not_found:          //Exits without finding match
    MOV R0, #-1               //Places -1 into R0
    POP {R4-R10}              //Restores R4-R10 to original conditions
    BX  LR                    //Returns to C

findCityPacked:
/* We are just going to set the values for a Packed Array and use the above function */
//extern  int32_t findCityPacked (const char city[], const BUSINESS2 business[], uint32_t count);
//R0 = String to be checked
//R1 = Array of Businesses
//R2 = Number of businesses in the array
    PUSH {R4-R10}             //Gives access to any register between 4 and 10
    MOV R5, R0	              //Clean copy of the city to be checked
    MOV R4, R1	              //Clean copy of business in R4
    ADD R4, R4, #71           //Moves head to city inside business array
    MOV R3, #108              //Sets variable for packed size of array
    MOV R10, #0	              //R10 will keep track of which Index we are on
    CMP R2, #0	              //Checks if the array is empty
    B test_string             //Always break to sub-function
    test_string:
    BEQ test_exit_not_found   //If the array is empty, break to sub-function
    MOV R6, R4			      //It is necessary to keep R4 at the beginning of the city for when we increment by size of struct
    //                          So this is a copy of R4 that will change as we compare strings
    MOV R7, R0			      //Make a copy of the City name we are testing. 
test_string_loop:             //This will test the string against the City name inside the struct
    LDRSB R8, [R6], #1        //Loads the first letter of the City name inside the struct
    LDRSB R9, [R7], #1        //Loads the first letter of the string
    CMP R8, R9                //Checks if they are the same
    BNE next_business		  //If the strings do not match, break to sub-function
    CMP R8, #0			      //Checks for Null terminator
    BEQ test_exit_found       //If R8 reaches null terminator without finding any difference, City is found
    B test_string_loop        //Null Terminator not found, loop to next letter in strings
next_business:                //Previous strings did not match, move to next struct
    ADD R4, R4, R3			  //Add the total length of struct to R4 to move pointer to next struct 
    ADD R10, R10, #1		  //Increment the index counter
    SUBS R2, R2, #1			  //Decrement the number of businesses left in the array and set flags
    B test_string             //Always break to sub-function
test_exit_found:              //Exits with index of array
    MOV R0, R10               //Moves index into R0 to return
    POP {R4-R10}              //Restores R4-R10 to original conditions
    BX  LR                    //Returns to C
test_exit_not_found:          //Exits without finding match
    MOV R0, #-1               //Places -1 into R0
    POP {R4-R10}              //Restores R4-R10 to original conditions
    BX  LR                    //Returns to C
