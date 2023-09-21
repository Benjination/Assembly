.global LSL32
.global LSR32
.global ASR32
 
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
    
