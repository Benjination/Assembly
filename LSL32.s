 .global LSL32
.text

// int add32(int x, int y)
// Input: x in R0, y in R1
// Output: Result in R0

LSL32:
    LSL R0, R1  // Right shift R0 by the number of bits specified in R1
    BX LR      // Return with the result in R0
    
