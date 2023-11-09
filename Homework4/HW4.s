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
    MOV R0, #1            //Strings are equal
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
//R0=address of string out, R1=address of string in, R2= Length of new string, R3= Holds Symbopl to be added to new string
         
loopl:                    //ends loop when string is entirely consumed
    LDRSB R3, [R1, R2]    //Loads char of string in into R3 offset by R4
    ADD R2, R2, #1        //Iterates counter by 1
    STRB R3, [R0], #1     //Stores R3 into first memory space in string out, and post increments R0 by one
    CMP R2, #0            //Checks if we are at the end of string in
    BNE loopl             //If we are not at the end, loop
    BX LR                 //Returns to C

decimalStringToInt16:     //Converts numeric string into 16 bit integer
//R0 = address of String passed into function, then 0, R1= Space to hold String, R2= Holds number 1
//R3 = Holds char to be converted, R4= Holds number 10
    PUSH {R4}             //Allows temporary access to R4
    MOV R1, R0            //Moves information in R0 into R1
    MOV R0, #0            //Sets R0 to zero
    MOV R2, #1            //Sets R2 to 1
    MOV R4, #10           //Sets R4 to 10 in order to quickly multiply by ten to move decimal places
dloop:
    LDRSB R3, [R1], #1    //Loads the first nth letter of the string into R3 and moves address up by 1
    CMP R3, #0            //checks if address is at null terminator, end of string
    BEQ loopEnd           //If the string is consumed, jump to loopend
    CMP R3, #48           //Compares letter of string to '0'<--Ascii 0, not null.  
    BLT error             //If string letter is less than ascii 0, jump to error
    CMP R3, #57           //Compare letter of string to '9' <---Ascii 9
    BGT error             //If R3 is greate than 9, jump to error
    SUB R3, R3, #48       //Subtract 48 from ascii value of R3 ex: (55-48)=(7-0)=7 
    MUL R0, R0, R4        //Multiplies R0 by ten to move decimal places to tens place
    ADD R0, R0, R3        //Adds R3 to ones place
    B dloop               //Loops to add next symbol in string
error:                    //Creates an error when symbol in string is not a number 0-9
    MOV R0, #-1           //Places a -1 in R0 to indicate an error has occurred
loopEnd:                  //ends the looping
    POP {R4}              //Restores R4 to original conditions
    BX LR                 //Returns to C



hexStringToUint8:          //Converts hex string into 8 bit integer
//R0= string 
PUSH {R4}                  //Gives acces to register 4
    MOV R1, R0             //Move the string into R1 instead of R0
    MOV R0, #0             //Move null into R0
    MOV R2, #1             //Move 1 into R2
    MOV R4, #16            //Hexidecimal requires 16 to move places, quick multiply by 16
oloop:                     //ends loop when hex string is consumed
    LDRSB R3, [R1], #1     //Loads first symbol in hexstring to R3 then post iterates R1
    CMP R3, #0             //Checks to see if string is consumed
    BEQ loopEnd1           //If string is consumed, jump to loopend1.
    CMP R3, #48            //Compares hexstring symbol to Ascii 0
    BLT error1             //If symbol is less than zero, jump to error
    CMP R3, #57            //Compare hexstring symbol to ascii 9
    BGT hex1               //If R3 is greater than 9, jump to hex1
    SUB R3, R3, #48        //Place into R3 the non-string version of hexstring numeric
calc:                      //
//Fixed error here in provided solution.
//Orig: MUL R0, R0, R4 <--- This does not work 
//Fixed: MUL R0, R3, R4 <--- This should
    MUL R0, R3, R4         //Moves symbol to next more significant hex-place
    ADD R0, R0, R3         //Adds R3 to the least significant hex-place
    B oloop                //Repeat process to finf end of string
hex1:                      //This will test range for A,B,C,D,E,F values
    CMP R3, #64            //Compares R3 to ascii A
    BGT hex2               //If greater than ascii value @, the symbol before ascii value A, jump to hex 2
    BLE error1             //If less than or equal to ascii @, jump to error
hex2:                      //Tests max range for hexstring symbol
    CMP R3, #70            //Compares R3 to ascii value F
    BGT error1             //If greater than F, send to error
    SUB R3, R3, #55        //Find numeric value for A=10, B=11, etc...
    B calc                 //Jump to calc
error1:                    //Occurs when symbol in hexstring is out of range
    MOV R0, #-1            //Place -1 in R0 to indicate that an error has occured
loopEnd1:                  //The program has worked successfully and needs to exit
    POP {R4}               //Restores R4 to original condition
    BX LR                  //Returns to C 



