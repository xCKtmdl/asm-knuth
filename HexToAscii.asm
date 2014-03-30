; Purpose of program:
; Need code to convert 3 decimal numbers represented as hex to ascii
; Aaron Gabriel
; fasm HexToAscii.asm

format PE64 GUI
entry start

section '.text' code readable executable

start:
	sub	rsp,8*5

mov rax,[_convertMe]
cmp rax,0x0a
jnc TwoDigits
add rax,0x30
mov [_buff+(0)],al
mov [_buff+(1)],0x00
jmp print
	
TwoDigits:
mov rax,[_convertMe]
cmp rax,0x64
jnc ThreeDigits
xor rdx,rdx
mov rbx,0x0a
div ebx

add rax,0x30
mov [_buff+(0)],al
add rdx,0x30
mov [_buff+(1)],dl
mov [_buff+(2)],0x00
jmp print



ThreeDigits:
mov rax,[_convertMe]
xor rdx,rdx
mov rbx,0x0a
div ebx

add rdx,0x30
mov [_buff+(2)],dl
mov [_buff+(3)],0x00


xor rdx,rdx
div ebx

add rax,0x30
mov [_buff+(0)],al
add rdx,0x30
mov [_buff+(1)],dl





print:

	mov	r9d,0
	lea	r8,[_caption]
	lea	rdx,[_buff]
	mov	rcx,0
	call	[MessageBoxA]

	mov	ecx,eax
	call	[ExitProcess]
	
	
	
	
	
	
	
	
	
	
	



section '.data' data readable writeable

; I want to convert this to "11"
; that is 0x31 0x31 0x00
_convertMe dq 0x3d2
_buff rb 5h


  _caption db 'Win64 assembly program',0



; Example of DIV instruction

;mov edx,0x00000000
;mov eax,0x0000000a
;mov rbx,0x03
;div ebx



; Example of working with the buffer

;mov [_primes+(8*0)],0x04
;mov rbx,[_primes+(8*0)]

;mov [_primes+(8*1)],0x3f
;mov rbx,[_primes+(8*1)]







section '.idata' import data readable writeable

  dd 0,0,0,RVA kernel_name,RVA kernel_table
  dd 0,0,0,RVA user_name,RVA user_table
  dd 0,0,0,0,0

  kernel_table:
    ExitProcess dq RVA _ExitProcess
    dq 0
  user_table:
    MessageBoxA dq RVA _MessageBoxA
    dq 0

  kernel_name db 'KERNEL32.DLL',0
  user_name db 'USER32.DLL',0

  _ExitProcess dw 0
    db 'ExitProcess',0
  _MessageBoxA dw 0
    db 'MessageBoxA',0
