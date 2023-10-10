.global  sumS32
.global  dotpS32
.global  countAboveLimit
.global  findCityAligned
.global  findCityPacked

.text

sumS32:
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
dotpS32:

countAboveLimit:

findCityAligned:

findCityPacked:

