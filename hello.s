.global _start

_start:

# Making the Write() Linux Syscall through Assembly
li a0, 1
la a1, helloMsg
li a2, 37
li a7, 64
ecall

# Exiting
li a0, 0
li a7, 93
ecall

.data
helloMsg: .ascii "Hello, this is certainly an attempt.\n"
