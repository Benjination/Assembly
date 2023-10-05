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
    LDRSB R2, [R0, R4]   //Loads first symbol of Str1 into R2, displaced by R4
        //Could use post increment here instead: LDRSB R2, [R0], #1
    LDRSB R3, [R1, R4]   //Loads first symbol of Str2 into R3, displaced by R4
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
//Ro=Address of first string, R1= Address of second String, R2=Character to add to result string
    LDRSB R2, [R0], #1    //Loads the first symbol of the string in R0 into R2 and post iterates R0 by 1. 
    CMP R2, #0            //Checks to see if R2 is at the end of the string
    BNE strConcatenate    //If it is not the end of the string, Loop strConcatenate
    SUB R0, R0, #1        //Subtract 1 from R0 and then put the result in R0, places R0 address at null terminator
loop2:                    //Continues when first string is entirely spent.
    LDRSB R2, [R1], #1    //Loads first letter of second string into R2 and post iterates R1 by 1 (Moves to next letter in string)
    STRB R2, [R0], #1     //Stores the information in R2 into the address at R0 and then post iterates to move to next symbol.
    CMP R2, #0            //Compares R2 to 0 to see if we are at the end of the second string
    BNE loop2             //If it is not at the end, Go back to Loop 2
    BX LR                 //Return to C

leftString:               //Moves part of string from one location in memory to a different location
//R0=address of string out, R1=address of string in, R2= Length of string in, R3=Symbol to be added to , R4= Counter
    PUSH {R4}
    MOV R4, #0            //Sets R4 to 0
loopl:                    //ends loop when string is entirely consumed
    LDRSB R3, [R1, R4]    //Loads char of string in into R3 offset by R4
    ADD R4, R4, #1        //Iterates counter by 1
    STRB R3, [R0], #1     //Stores R3 into first memory space in string out, and post increments R0 by one
    SUB R2, R2, #1        //Reduces strlen of strin by 1
    CMP R2, #0            //Checks if we are at the end of string in
    BNE loopl             //If we are not at the end, loop
    POP {R4}              //resores original status to R4, removes from stack
    BX LR                 //Returns to C

decimalStringToInt16:     //Converts string into 16 bit integer
//R0 = address of String passed into function, then 0, R1= Space to hold String, R2= Holds number 1
//R3 = Holds char to be converted, R4= Holds number 10
    MOV R1, R0            //Moves information in R0 into R1
    MOV R0, #0            //Sets R0 to zero
    MOV R2, #1            //Sets R2 to 1
    MOV R4, #10           //Sets R4 to 10
dloop:
    LDRSB R3, [R1], #1    //
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