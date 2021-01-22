
; DISPLAY NUMBERS > 9
; case of negative number
; dynamic output

SYS_EXIT equ 1
SYS_READ equ 3
SYS_WRITE equ 4
STDIN equ 0
STDOUT equ 1


section .data
   requestInputMsg db 'your number = '
   lenQ equ $ - requestInputMsg

   firstMsg db 'Factorial of '
   len1 equ $ - firstMsg
   
   secondMsg db ' is: ' 
   len2 equ $ - secondMsg			
   
section .bss
   myNumber resb 2
   fact resb 1

section	.text
   global _start         ;must be declared for using gcc
	
_start:                  ;tell linker entry point
    
  call displayRequestInput
  call inputNumber
  call displayFirstMessage
  call displayNumber
  call displaySecondMessage
 
   ; mov   ecx, 2      ;for calculating factorial 3
   ; sub   ecx, '0'
   mov   bx, 2
   mov   ax, 1
   call  calc_fact
   add   ax, 30h
   mov   [fact], ax

   call displayFact
    
   mov	  eax,1          ;system call number (sys_exit)
   int	  0x80           ;call kernel

calc_fact:
   cmp   bl, 1
   je    end_factorial
   
   mul bl
   dec bl
   call  calc_fact

   ret 

displayRequestInput:
   mov	  edx,lenQ       ;message length
   mov	  ecx,requestInputMsg   ;message to write
   mov	  ebx,STDOUT     ;file descriptor (stdout)
   mov	  eax,SYS_WRITE  ;system call number (sys_write)
   int	  0x80           ;call kernel

   ret

displayFirstMessage:
   mov	  edx,len1       ;message length
   mov	  ecx,firstMsg   ;message to write
   mov	  ebx,STDOUT     ;file descriptor (stdout)
   mov	  eax,SYS_WRITE  ;system call number (sys_write)
   int	  0x80           ;call kernel

   ret

inputNumber:
    mov ecx, myNumber
    mov edx, 1
    mov ebx, STDIN
    mov eax, SYS_READ
    int 0x80

    ret

displayNumber:
   mov	  edx,1          ;message length
   mov	  ecx,myNumber   ;message to write
   mov	  ebx,STDOUT     ;file descriptor (stdout)
   mov	  eax,SYS_WRITE  ;system call number (sys_write)
   int	  0x80           ;call kernel

   ret

displaySecondMessage:
   mov edx, len2
   mov ecx, secondMsg
   mov ebx, STDOUT
   mov eax, SYS_WRITE
   int 0x80           

   ret


end_factorial:
   ret

displayFact:
   mov     edx,1          ;message length
   mov	  ecx,fact       ;message to write
   mov	  ebx,STDOUT     ;file descriptor (stdout)
   mov	  eax,SYS_WRITE  ;system call number (sys_write)
   int	  0x80           ;call kernel

   ret
