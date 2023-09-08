 .global LSR32
.text

// int LSL32(int x, int y)
// Input: x in R0, y in R1
// Output: Result in R0

LSR32:
    LSR R0, R1  // Left shift R0 by the number of bits specified in R1
    BX LR      // Return with the result in R0
    
