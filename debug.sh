#!/usr/bin/bash

mkdir -p build/

file_name=$1

riscv64-linux-gnu-as -g ${file_name} -o build/${file_name::-2}.o
riscv64-linux-gnu-ld build/${file_name::-2}.o -o build/${file_name::-2}

if command -v qemu-riscv64 >/dev/null 2>&1; then
    bash -c "qemu-riscv64 -g 1234 ./build/${file_name::-2}" &
    sleep 1
    riscv64-linux-gnu-gdb build/${file_name::-2} -ex "target remote localhost:1234"
    exit 1
  else
    echo "qemu-riscv64 not found..."
    echo "Trying qemu-riscv64-static"
    if command -v qemu-riscv64-static >/dev/null 2>&1; then
      qemu-riscv64-static ./build/${file_name::-2}
    else 
      echo "Qemu setup not supported"
    fi
fi
