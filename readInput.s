.data
buff: .space 8
fileName: .string "train-images.idx3-ubyte"

.text
.globl _start

_start:

  la a0, fileName
  li a1, 0
  li a7, -1
  ecall

  la a1, buff
  li a2, 8
  li a7, 63
  ecall

  addi t0, zero, 8
  la t1, buff
  convertToAscii:
    beqz t0, endLoop
    lb s0, 0(t1)
    addi s0, s0, 48
    sb s0, 0(t1)
    addi t1, t1, 1
    addi t0, t0, -1

  endLoop:

  li a0, 1
  la a1, buff
  la a2, 8
  li a7, 64
  ecall

exit:
  li a0, 0
  li a7, 93
  ecall
