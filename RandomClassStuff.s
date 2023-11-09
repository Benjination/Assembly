.global isNegAndOdd
.text

//(Discussed in class, not part of HW, also, I don't think it's actually working)
isNegAndOdd:              //Checks if a number is odd and negative
    MOV R2, #0            //Sets R2 to 0
    CMP R0, #0            //Compares number to zero
    MOVMI R1, #1          //If R0 is less than 0, Move 1 into R1
    AND R0, R0, R2        //If R0 is odd, moves 1 into R0, else moves 0 into R0
    BX LR                 //Returns to C

    