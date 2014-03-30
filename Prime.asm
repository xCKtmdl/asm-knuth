; Attempt at Donald Knuth's primes printing program.
; Find first 500 primes the naive way.

format PE64 GUI
entry start

section '.text' code readable executable

start:
mov rax,[CurrNumber]
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
jmp End1

NotPrime:
mov r8,0x01


End1:
nop

section '.data' data readable writeable

CurrNumber dq 0x0b


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