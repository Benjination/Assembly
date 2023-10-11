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
        ldr r3, [r3], #4  //Loads integer from intarray1 into reg3, post iterates 4 bytes (sizeof int)
        ldr r4, [r1], #4  //Loads integer from intarray2 into reg4, moves to next int
        mul r3, r3, r4    //Multiplies two integers selected from the arrays, places in R3
        add r0, r0, r3    //Adds product to running sum
        SUB R2, R2, #1    //Decrement counter by 1
        CMP R2, #0        //Compare counter to 0
        BNE loop_start    //If counter has not reached zero, jump to loop
    exit:
        POP {R4}           //Restores Register 4 to original conditions 
        BX LR              //Returns to C Program

/*
countAboveLimit:
    push {lr}           ; save the return address
    mov r2, #0          ; initialize the count to 0
    loop_start:
        cmp r1, #0      ; check if count is 0
        beq loop_end
        ldr r3, [r0], #4 ; load x[i] and increment the pointer
        cmp r3, r1       ; compare x[i] with limit
        ble loop_start   ; if x[i] <= limit, continue loop
        add r2, r2, #1   ; if x[i] > limit, increment count
        subs r1, r1, #1  ; decrement count
        b loop_start
    loop_end:
        mov r0, r2       ; move count to r0
    pop {pc}            ; return
    BX LR

findCityAligned:
    push {lr}           ; save the return address
    mov r2, #0          ; initialize the index to 0
    loop_start:
        cmp r2, r1      ; check if index is equal to count
        beq not_found   ; if index == count, city not found
        ldr r3, [r0], #1 ; load city[i] and increment the pointer
        ldr r4, [r1], #4 ; load business[i].city and increment the pointer
        cmp r3, r4       ; compare city[i] with business[i].city
        bne loop_start   ; if city[i] != business[i].city, continue loop
        mov r0, r2       ; if city[i] == business[i].city, return index
        pop {pc}         ; and restore the return address
    not_found:
        mov r0, #-1      ; if city not found, return -1
    pop {pc}            ; and restore the return address

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
