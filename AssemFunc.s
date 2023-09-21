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
    
maxS16:
	CMP R0, R1
	MOVLT R0, R1
	BX LR
	
maxU32:
	CMP R0, R1
	MOVLS RO, R1
	BX LR
	
isGreaterThanU16:
	CMP R0, R1
	MOVLS R0, #0
	MOVHI R0, #1
	BX LR
