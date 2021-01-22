
; DISPLAY NUMBERS > 9
; case of negative number
; dynamic output

SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
STDIN equ 0
STDOUT equ 1

section	.text
   global _start         ;must be declared for using gcc
	
_start:                  ;tell linker entry point

   mov   bx, 2             ;for calculating factorial 3
   mov   ax, 1
   call  calc_fact
   add   ax, 30h
   mov   [fact], ax
    
  call displayFirstMessage
  ;call inputNumber
  ;call displayDigit

   mov   edx,1            ;message length
   mov	  ecx,fact       ;message to write
   mov	  ebx,1          ;file descriptor (stdout)
   mov	  eax,4          ;system call number (sys_write)
   int	  0x80           ;call kernel
    
   mov	  eax,1          ;system call number (sys_exit)
   int	  0x80           ;call kernel

displayFirstMessage:
   mov	  edx,len1       ;message length
   mov	  ecx,firstMsg   ;message to write
   mov	  ebx,STDOUT     ;file descriptor (stdout)
   mov	  eax,SYS_WRITE  ;system call number (sys_write)
   int	  0x80           ;call kernel

   ret

calc_fact:
   cmp   bl, 1
   je    end_factorial
   
   mul bl
   dec bl
   call  calc_fact

   ret 
	
end_factorial:
   ret

section	.data
firstMsg db 'Factorial of '
secondMsg db ' is: ' 
; Factorial 3 is:	
len1 equ $ - firstMsg
len2 equ $ - secondMsg			

section .bss
fact resb 1