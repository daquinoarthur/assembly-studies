; Hello World program
section .data
    msg db 'Hello, x86 Assembly!', 0xa ; String with newline (0xa)
    len equ $ - msg ; Length of the string
section .text
    global _start ; Entry point for the linker
_start:
    ; Write the message to stdout
    mov eax, 4 ; sys_write system call number
    mov ebx, 1 ; File descriptor 1 (stdout)
    mov ecx, msg ; Pointer to message
    mov edx, len ; Message length
    int 0x80 ; Make system call

    ; Exit program
    mov eax, 1 ; sys_exit system call number
    mov ebx, 0 ; Exit status 0
    int 0x80 ; Make system call
