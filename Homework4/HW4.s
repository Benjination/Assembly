//In order to use Register 4, You must restore the contents of the register before
//ending the program. First you must Push the register onto the stack, and then
//pop the register back off before BX LR

.global isStrEqual 
.global strConcatenate
.global leftString
.global decimalStringToInt16
.global hexStringToUint8

.text

isStrEqual:   //Determines if two strings are the same
//R0 = Address of Str1, R1 = Address of Str2, R2 = 1st Char to Test, R3 = 2nd char to test, PUSH R4 = Counter
    PUSH {R4}            //Gives access to R4
    MOV R4, #0           //R4 will be iterator, and is set to zero 
LOOP:
    LDRSB R2, [R0, R3]   //Loads first symbol of Str1 into R2, displaced by R4
        //Could use post increment here instead: LDRSB R2, [R0], #1
    LDRSB R3, [R1, R3]   //Loads first symbol of Str2 into R3, displaced by R4
    CMP R2, R3           //Compares first two symbols
    BNE FAIL             //Strings are not equal, jump to Fail label
    CMP R3, #0           //Tests if symbol in R3 is NULL terminator indicating end of string
    ADD R4, #1           //Moves counter to the next symbol in the string
    BNE LOOP             //If R3 is not zero, program loops
    MOV R0 #1            //Strings are equal
    POP {R4}             //Removes access to R4
    BX LR                //Return to C program
FAIL:
    MOV R0, #0           //R0 is becomes = 0.
    POP {R4}             //Removes access to R4
    BX LR                //Returns to C

strConcatenate:
    LDRSB R2, [R0], #1
    CMP R2, #0
    BNE loop1
    SUB R0, R0, #1
loop2:
    LDRSB R2, [R1], #1
    STRB R2, [R0], #1
    CMP R2, #0
    BNE loop2
    BX LR

leftString:
    MOV R4, #0
loopl:
    LDRSB R3, [R1, R4]
    ADD R4, R4, #1
    STRB R3, [R0], #1
    SUB R2, R2, #1
    CMP R2, #0
    BNE loopl
    BX LR

decimalStringToInt16:
    MOV R1, R0
    MOV R0, #0
    MOV R2, #1
    MOV R4, #10
dloop:
    LDRSB R3, [R1], #1
    CMP R3, #0
    BEQ loopEnd
    CMP R3, #48
    BLT error
    CMP R3, #57
    BGT error
    SUB R3, R3, #48
    MUL R0, R0, R4
    ADD R0, R0, R3
    B dloop
error:
    MOV R0, #-1
loopEnd:
    BX LR

hexStringToUint8:
    MOV R1, R0
    MOV R0, #0
    MOV R2, #1
    MOV R4, #16
oloop:
    LDRSB R3, [R1], #1
    CMP R3, #0
    BEQ loopEnd1
    CMP R3, #48
    BLT error1
    CMP R3, #57
    BGT hex1
    SUB R3, R3, #48
calc:
    MUL R0, R0, R4
    ADD R0, R0, R3
    B oloop
hex1:
    CMP R3, #64
    BGT hex2
    BLE error1
hex2:
    CMP R3, #70
    BGT error1
    SUB R3, R3, #55
    B calc
error1:
    MOV R0, #-1
loopEnd1:
    BX LR


