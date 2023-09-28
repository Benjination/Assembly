

.global isStrEqual 
.global strConcatenate
.global leftString
.global decimalStringToInt16
.global hexStringToUint8

.text

isStrEqual:   //Determines if two strings are the same
//R0 = Address of Str1, R1 = Address of Str2, R2 = Character to Test, R3 = Counter
    MOV R3, #0
LOOP:
    LDRSB R1, [R2, R3]
    


strConcatenate:

leftString:

decimalStringToInt16:

hexStringToUint8:

