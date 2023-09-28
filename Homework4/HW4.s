

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

leftString:

decimalStringToInt16:

hexStringToUint8:

