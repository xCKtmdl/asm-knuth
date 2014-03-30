
; My Solution for 1.2.10M from Donald Knuth book


; TODO: Compute length of list in program DONE

format PE64 GUI
entry start

section '.text' code readable executable

start:

;Compute length of L[]
mov rcx,0

beginn:
mov rax,[_list1+(8*rcx)]
cmp rax,[_term]
jz getLength
add rcx,1
jmp beginn

getLength:
nop

  ; n-1 into rdx
  mov rdx,rcx
  sub rdx,0x1
  
  ;L[3] into rax
  mov rax,[_list1+(8*rdx)]
  
loop1:
  cmp rdx,0
  jz end1
  mov r10,[_list1+(8*(rdx-1))]
  cmp r10,rax
  
  jnc setNewMax
  sub rdx,0x1
  jmp loop1
  
setNewMax:
  mov rax,r10
  sub rdx,0x1
  jmp loop1
  
end1:
nop


section '.data' data readable writeable

; This is my L

; _list1 dq 0x1,0x2,0x99,0x15,0x32,0x3f,0x7
; _term dq 0xffffffffffffffff

; _list1 dq 0x78,0xf,0x10101,0xf18bff,0xff27ff09f090fa12,0x18,0x5f,0x55,0xaf,0xafff73f,0x7a
; _term dq 0xffffffffffffffff


 _list1 dq 0x78,0xf,0x10101,0xf18bff,0xff27ff09f090fa12,0x18,0x5f,0x55,0xaf,0xafff73f,0x7a
 _term dq 0xffffffffffffffff



