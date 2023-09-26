

.global maxUint8
.global StrLen
.text

maxUint8:
    CMP R0, R1
    MOVLO R0, R1
    BX LR

StrLen: //Finds the length of a string
MOV R2, #0 //Moves Zero into R2
Loop:
    LDRSB R1, [R0, R1] //Load a character, Adds R1 to R0 (Moves bit right by the "Offset" in R1)
    CMP R1, #0     //Check to see if it's zero
    ADD R1, R1, #1 //Adds one byte to R1 to move the address by one byte. 
    BNE Loop     //If the branch is not zero, repeat. When string runs out of letters, Branch is equal to 0. No loop
    SUB R0, R1, #2 //Moves R1 minus 2 into R0 (The address has counted one past the null terminator)
    BX LR          //Returns R0

StrLenSpec: //Finds the length of part of a string to a specific letter
//R0 Address in memory
//R1 char n
//R2 char to test
//R3 count
MOV R3, #0 //Moves Zero into R2
Loop:
    LDRSB R2, [R0, R3] //Load a character, Adds R1 to R0 (Moves bit right by the "Offset" in R1)
    CMP R1, R2     //Check to see if it's zero
    ADD R3, R3, #1 //Adds one byte to R1 to move the address by one byte. 
    BNE Loop     //If the branch is not zero, repeat. When string runs out of letters, Branch is equal to 0. No loop
    SUB R0, R3, #1 //Moves R1 minus 2 into R0
    BX LR          //Returns R0

StrLenSpecInt: //Finds the length of part of a string to a specific letter
//R0 Address in memory
//R1 char n
//R2 int x
//R3 count
//R4 iteration
PUSH {R4} //Pushes R4 onto the stack LIFO
MOV R3, #0 //Moves Zero into R2
Loop:           //Exit conditions "Finds nth number of char in string", "Find End of String"
    LDRSB R4, [R0, R3] //Load a character, Adds R1 to R0 (Moves bit right by the "Offset" in R1) Puts in R4
    CMP R4, R1     //Check to see if it's zero
    SUBEQ R2, R2, #1 //If the two symbols are equal, reduce the count m by 1.
    ADD R3, R3, #1 //Adds one byte to R1 to move the address by one byte. 
    CMP R2, #0     //Check if m has reduced to 0
    BNE Loop     //If the branch is not zero, repeat. When string runs out of letters, Branch is equal to 0. No loop
    CMP R4, #0
    SUB R0, R3, #1 //Moves R1 minus 2 into R0
    POP {R4}       //Removes access to register R4
    BX LR          //Returns R0
