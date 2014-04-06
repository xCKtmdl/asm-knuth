; Attempt at Donald Knuth's primes printing program.
; Find first 500 primes the naive way.

format PE64 GUI
entry start

section '.text' code readable executable

start:
	sub	rsp,8*5
mov rax,[CurrNumber]
xor r11,r11
mov r11,[buffIdx]
xor rdx,rdx
xor r8,r8
mov rbx,0x02




DivAgain:
mov rax,[CurrNumber]
cmp rbx,rax
jz LoopedAllNumbers
xor rdx,rdx
div rbx
cmp rdx,0
jz NotPrime
add rbx,0x01
jmp DivAgain



LoopedAllNumbers:
cmp r8,0x00
jz Prime

Prime:
mov rax,[CurrNumber]


cmp rax,0x0a
jnc TwoDigits
add rax,0x30
mov [ListPrimes+(r11)+(0)],al
mov [ListPrimes+(r11)+(1)],0x2c
add r11,2
jmp PrepareForNext


TwoDigits:
mov rax,[CurrNumber]
cmp rax,0x64
jnc ThreeDigits
xor rdx,rdx
mov rbx,0x0a
div ebx

add rax,0x30
mov [ListPrimes+(r11)+(0)],al
add rdx,0x30
mov [ListPrimes+(r11)+(1)],dl
mov [ListPrimes+(r11)+(2)],0x2c
add r11,3
jmp PrepareForNext


ThreeDigits:
mov rax,[CurrNumber]
xor rdx,rdx
mov rbx,0x0a
div ebx

add rdx,0x30
mov [ListPrimes+(r11)+(2)],dl
mov [ListPrimes+(r11)+(3)],0x2c


xor rdx,rdx
div ebx

add rax,0x30
mov [ListPrimes+(r11)+(0)],al
add rdx,0x30
mov [ListPrimes+(r11)+(1)],dl
add r11,4
jmp PrepareForNext


NotPrime:
mov r8,0x01
jmp PrepareForNext


PrepareForNext:
mov rax,[CurrNumber]

cmp rax,0x258
jz End1

xor rdx,rdx
xor r8,r8
add rax,1
mov [CurrNumber],rax
mov rbx,0x02
jmp DivAgain


End1:
mov [ListPrimes+(r11)-1],0x00
jmp print
nop


print:

	mov	r9d,0
	lea	r8,[_caption]
	lea	rdx,[ListPrimes]
	mov	rcx,0
	call	[MessageBoxA]

	mov	ecx,eax
	call	[ExitProcess]

section '.data' data readable writeable

buffIdx dq 0x00

CurrNumber dq 0x0b

ListPrimes rb 1000h

  _caption db 'Aaron Gabriel, primes 11-599',0

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