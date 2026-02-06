.global _start

_start:
li a0, 1
la a1, toPrint
li a2, 23
li a7, 64
ecall

li a0, 0
li a7, 93
ecall

.data
toPrint: .ascii "Hello, this is a start\n"
