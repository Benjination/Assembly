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
        CMP r1, #0        //Checks to see if integer array is empty
        BEQ exit          //If there are no integers in array, returns 0
        LDR r3, [r3], #4  //Loads integer from intarray1 into reg3, post iterates 4 bytes (sizeof int)
        LDR r4, [r1], #4  //Loads integer from intarray2 into reg4, moves to next int
        MUL r3, r3, r4    //Multiplies two integers selected from the arrays, places in R3
        ADD r0, r0, r3    //Adds product to running sum
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
// returns the index of the first entry in the array (business) containing count entries which matches the requested city.
// If the city is not found, return a value of -1. You can assume that C default alignment is used for this problem.
//(const char city[], const BUSINESS2 business[], uint32_t count)
//R0= String containing city name(later index), R1=Struct containing Business info, R2=Number of City/Business in arrays(count)
//r3=Move String1 here
    PUSH {R4}             //Gives Access to Register 4
    MOV R3, R0            //Opens R0 for count we want to return
    MOV R0, #0            //Sets the index to Zero
    loop_start:
        CMP r0, r2        //Checks if there are still elements in business array
        BEQ not_found     //if address of pointer finds null, jump to not found
        ldr r3, [r3], #1  //Loads string from city array and post increments to next city
                          //This loads the entire string, so only needs to move one bit to reach next string
        ldr r4, [r1], #4  //Loads struct from business and increments to next struct
        cmp r3, r4        //compare city[i] with business[i].city
        bne loop_start    //If the string does not match the business[i].city, loop 
        mov r3, r2       ; if city[i] == business[i].city, return index
        pop {pc}         ; and restore the return address
    not_found:
        mov r0, #-1      ; if city not found, return -1
        POP {R4}              //Restores R4 to original conditions
        BX LR                 //Returns to C

/* 
findCityPacked:
    push {lr}           ; save the return address
    mov r2, #0          ; initialize the index to 0
    loop_start:
        cmp r2, r1      ; check if index is equal to count
        beq not_found   ; if index == count, city not found
        ldrb r3, [r0], #1 ; load city[i] and increment the pointer
        ldr r4, [r1], #8 ; load business[i].city and increment the pointer
        cmp r3, r4       ; compare city[i] with business[i].city
        bne loop_start   ; if city[i] != business[i].city, continue loop
        mov r0, r2       ; if city[i] == business[i].city, return index
        pop {pc}         ; and restore the return address
    not_found:
        mov r0, #-1      ; if city not found, return -1
    pop {pc}            ; and restore the return address
*/
