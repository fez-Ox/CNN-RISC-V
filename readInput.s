.section .rodata
trainSetFile: .string "train-images.idx3-ubyte"
trainLabelFile: .string "train-labels.idx1-ubyte"
testSetFile: .string "t10k-images.idx3-ubyte"
testLabelFile: .string "t10k-labels.idx1-ubyte"

.section .bss
dim: .space 16

.align 12
.globl trainImages
trainImages: .space 47040000

.align 12
.globl testImages
testImages: .space 7840000

.align 12
.globl trainLabels
trainImages: .space 60000

.align 12
.globl testLabels
trainImages: .space 10000

.section .text
.globl _start
_start:

#------------ Reading Training Set ------------

  # Opening the Train-Set
  li a0, -100
  la a1, trainSetFile
  li a2, 0
  li a3, 0
  li a7, 56     # 56 = openat()
  ecall

  mv s0, a0     # S0 = fd

  # Reading Train-Set Dimensions
  la a1, dim
  li a2, 16
  li a7, 63     # 63 = read()
  ecall

  # Loading, Saving Train-Set Dimensions
  la t0, dim
  lw s1, 4(t0)    # S1 = numPictures
  rev8 s1, s1
  lw s2, 8(t0)    # S2 = Width
  rev8 s2, s2
  lw s3, 12(t0)   # S3 = Height
  rev8 s3, s3

  # Calculating Number of Bytes to be Read
  mul s4, s1, s2
  mul s4, s4, s3  # S4 = NumBytesToBeRead

  # Reading the Pixel Values into a single
  # Contiguous Array
  mv a0, s0
  la a1, trainImages
  mv a2, s4
  li a7, 63
  ecall

  # For Checking if Valid Read
  la t0, trainImages
  lw t1, 152(t0)  # Should be 0312 1212
  rev8 t1, t1

  # Closing the File
  mv a0, s0
  li a7, 57     # 57 = close()
  ecall

#------------ Reading Test Set ------------

  # Opening the Test-Set
  li a0, -100
  la a1, testSetFile
  li a2, 0
  li a3, 0
  li a7, 56     # 56 = openat()
  ecall

  mv s0, a0     # S0 = fd

  # Reading Test-Set Dimensions
  la a1, dim
  li a2, 16
  li a7, 63     # 63 = read()
  ecall

  # Loading, Saving Test-Set Dimensions
  la t0, dim
  lw s1, 4(t0)    # S1 = numPictures
  rev8 s1, s1
  lw s2, 8(t0)    # S2 = Width
  rev8 s2, s2
  lw s3, 12(t0)   # S3 = Height
  rev8 s3, s3

  # Calculating Number of Bytes to be Read
  mul s4, s1, s2
  mul s4, s4, s3  # S4 = NumBytesToBeRead

  # Reading the Pixel Values into a single
  # Contiguous Array
  mv a0, s0
  la a1, testImages
  mv a2, s4
  li a7, 63
  ecall

  # Closing the File
  mv a0, s0
  li a7, 57     # 57 = close()
  ecall

#------------ Reading Train Labels ------------

  # Opening the Train-Labels
  li a0, -100
  la a1, trainLabelFile
  li a2, 0
  li a3, 0
  li a7, 56     # 56 = openat()
  ecall

  mv s0, a0     # S0 = fd

  # Reading Train-Labels Dimensions
  la a1, dim
  li a2, 8
  li a7, 63     # 63 = read()
  ecall

  # Loading, Saving Train-Labels Dimensions
  la t0, dim
  lw s1, 4(t0)    # S1 = numLabels
  rev8 s1, s1

  # Reading the Pixel Values into a single
  # Contiguous Array
  mv a0, s0
  la a1, trainLabels
  mv a2, s1
  li a7, 63
  ecall

  # Closing the File
  mv a0, s0
  li a7, 57     # 57 = close()
  ecall

#------------ Reading Test Labels ------------

  # Opening the Test-Labels
  li a0, -100
  la a1, testLabelFile
  li a2, 0
  li a3, 0
  li a7, 56     # 56 = openat()
  ecall

  mv s0, a0     # S0 = fd

  # Reading Test-Labels Dimensions
  la a1, dim
  li a2, 8
  li a7, 63     # 63 = read()
  ecall

  # Loading, Saving Test-Labels Dimensions
  la t0, dim
  lw s1, 4(t0)    # S1 = numLabels
  rev8 s1, s1

  # Reading the Pixel Values into a single
  # Contiguous Array
  mv a0, s0
  la a1, testLabels
  mv a2, s1
  li a7, 63
  ecall

  # Closing the File
  mv a0, s0
  li a7, 57     # 57 = close()
  ecall

exit:
  li a0, 0
  li a7, 93     # 93 = exit()
  ecall
