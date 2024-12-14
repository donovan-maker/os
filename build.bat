@echo off

nasm bootloader\stage0\stage0.asm -o bin\stage0.bin
nasm bootloader\stage1\stage1.asm -o bin\stage1.bin
nasm kernel\main.asm -o bin\kernel.bin
copy /b bin\stage0.bin + bin\stage1.bin + bin\kernel.bin build\bootloader.img
qemu-system-x86_64 build\bootloader.img