TITLE Simple Arithmetic    (program01.asm)

; Author: Sergio Ortega
; Course / Project ID  CS271/Project01     Date: 1/19/17
; Description:

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data
intro BYTE "Welcome to the Simple Arithmetic Program.",0
nameintro BYTE "My name is Sergio Ortega", 0
outro BYTE "Excellent work! Until next time", 0
numvar1 DWORD ?
numvar2 DWORD ?
numvar3 DWORD ?

; (insert variable definitions here)

.code
main PROC

mov edx, OFFSET intro
call writestring
call CrLf
mov edx, OFFSET nameintro
call writestring
call CrLf

; (insert executable instructions here)
mov edx, OFFSET outro
call writestring
call CrLf
	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
