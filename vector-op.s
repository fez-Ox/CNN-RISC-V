.global _start

_start:
# Setting up vector addition for 32-bit integer arrays
li a5, 8
vsetvli t0, a5, e32, m2, ta, ma

# Load vectors from memory
la a2, vec1
la a3, vec2
vle32.v v0, (a2)
vle32.v v8, (a3)

# Vector addition: v0 = v0 + v8
vadd.vv v0, v0, v8

# Store result back
la a4, result
vse32.v v0, (a4)

# Exit with return value 0
li a0, 1
li a7, 93
ecall

.section .data
vec1: .word 1, 2, 3, 4, 5, 6, 7, 8
vec2: .word 1, 2, 3, 4, 5, 6, 7, 8
result: .space 32
