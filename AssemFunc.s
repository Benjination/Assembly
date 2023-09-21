.global LSL32
.global LSR32
.global ASR32
.global maxS16
.global maxU32
.global isGreaterThanU16
.global isGreaterThanS16
.global shiftU16
.global isBitSetU32
.global isMultof4U32
.global isEqualU16
 
.text

LSL32:
    LSL R0, R1  // Right shift R0 by the number of bits specified in R1
    BX LR      // Return with the result in R0
    
LSR32:
    LSR R0, R1  // Left shift R0 by the number of bits specified in R1
    BX LR      // Return with the result in R0

ASR32:
    ASR R0, R1  // Right shift R0 by the number of bits specified in R1
    BX LR      // Return with the result in R0
    
maxS16:           //Returns Maximum of x and y
	CMP R0, R1    //Compares two elements
	MOVLT R0, R1  //If RO Less than R1, Moves R1 into R0
	BX LR         //Returns R0
	
maxU32:            //Returns maximum of x and y
	CMP R0, R1     //Compares the two elements
	MOVLS RO, R1   //If R0 is Less than R1, Moves R1 into R0
	BX LR          //Returns R0
	
isGreaterThanU16:  //Is x greater than y
	CMP R0, R1     //Compares two elements
	MOVLS R0, #0   //If R0 is less than R1, move 0 (False) into R0
	MOVHI R0, #1   //If R0 is greater than R1, move 1 (True) into R0
	BX LR          //Returns R0

isGreaterThanS16:   //Is x greater than y
    CMP R0, R1      //Compares the two elements
    MOVGT R0, #1    //If R0 is greater than R1, Move 1 into R0
    MOVLE R0, #0    //If R0 is Less or Equal to R1, Move 0 into R0
    BX LR           //Returns R0

shiftU16                  //Return x*2^y
    CMP R1, #0            //Compare R1 with #0
    NEGLT R1, R1          //------------------------------Not sure
    MOVLT R0, R0, LSR R1  //If R1 is less than 0, Shift R0 left by #R1 spaces
    MOVGE R0, R0, LSL R1  //If R1 is greater than 0, Shift R0 right by #R1 spaces
    BX LR                 //Returns R0

sBitSetU32:              //Checks if bit is one or zero
    MOV R3, #1           //Moves the number 1 into R3
    MOV R1, R3, LSL R1   //-------------------------------Not Sure
    ANDS R0, R0, R1      //-------------------------------Not Sure
    MOVNE R0, #1         //-------------------------------Not Sure
    BX LR                //Returns R0

isMultof4U32:            //Checks if x is a multiple of 4
    ANDS R0, R0, #3      //And operation on R0 and #3 (Third Bit), placed into R0
    MOVEQ R0, #1         //If Equal Move #1 into R0
    MOVNE R0, #0         //If not Equal, Move #0 into R0
    BX LR                //Return R0

isEqualU16:
    CMP R0, R1           //Compares x and y
    MOVEQ R0, #1         //If Equal, Move #1 into R0
    MOVNE R0, #0         //If not Equal, Move #0 into R0
    BX LR                //Return R0

