#!/usr/bin/bash

mkdir -p build/

file_name=$1

riscv32-elf-as -march=rv32gc_zbb ${file_name} -o build/${file_name::-2}.o
riscv32-elf-ld build/${file_name::-2}.o -o build/${file_name::-2}

if command -v qemu-riscv32 >/dev/null 2>&1; then
    qemu-riscv32 ./build/${file_name::-2}
    exit 1
  else
    echo "qemu-riscv32 not found..."
    echo "Trying qemu-riscv32-static"
    if command -v qemu-riscv32-static >/dev/null 2>&1; then
      qemu-riscv32-static ./build/${file_name::-2}
    else 
      echo "Qemu setup not supported"
    fi
fi
