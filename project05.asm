TITLE Sorting Random Integers     (project05.asm)

; Author: Sergio Ortega-Rojas
; Course / Project ID   CS271/Project 05  Date: 3/3/17
; Description: A program that is meant to generate a list of random numbers that displays the list,
; sorts it, and then displays in a decending order. Calculates the median per requirements.

INCLUDE Irvine32.inc

; (insert constant definitions here)
MINVAL equ 10
MAXVAL equ 200
LOINT equ 100
HIINT equ 999

.data

; (insert variable definitions here)
;Introduction Variables
intro_msg_01 BYTE "Sorting Random Integers                Programmed by Sergio Ortega-Rojas", 0
intro_msg_02 BYTE "This program is meant to generate a list of random numbers that displays", 0
intro_msg_03 BYTE "the list, sorts it, and then displays in a decending order.", 0
intro_msg_04 BYTE "Also calculates the median!", 0

;getUserRequest Variables
request_msg BYTE "How many numbers should be generated? [10 ... 200]: ", 0
out_of_range_msg BYTE "Out of range, invalid input", 0
userInput DWORD ?

;Fill Array Variables
rand_array DWORD 200 DUP(?)

;Display List Variables
title_01 BYTE "The Unsorted Random Numbers: ", 0
title_02 BYTE "The Sorted List:", 0
spacing BYTE "   ", 0
loopcount DWORD ?

;Median Variables
median_msg BYTE "The median is ", 0

.code
main PROC

call Randomize

;intro
call intro

;get data proc
push OFFSET userInput
call getUserRequest 

;Fill Array
push userInput
push OFFSET rand_array
call fillArray

;display (unsorted) list
push OFFSET title_01
push userInput
push OFFSET rand_array
call displayArray

;sort List
push userInput
push OFFSET rand_array
call sortList

;median
push UserInput
push OFFSET rand_array
call getMedian

;display (sorted) list
push OFFSET title_02
push userInput
push OFFSET rand_array
call displayArray

; (insert executable instructions here)

	exit	; exit to operating system
main ENDP



;Descriptions: Introduction to the program, nothing special other than writing the lines
;Receives: NA
;Returns: NA
;Preconditions: NA
;Registers Changed: EDX
intro PROC
mov edx, OFFSET intro_msg_01
call WriteString
call CrLf
mov edx, OFFSET intro_msg_02
call WriteString
call CrLf
mov edx, OFFSET intro_msg_03
call WriteString
call CrLf
mov edx, OFFSET intro_msg_04
call WriteString
call CrLf

ret
intro ENDP



;Descriptions: Validates user input between 10 ... 200, then if it is true places the value at the address of userInput. 
;Two conditional checks determine the validation, otherwise outputs an out of range msg.
;Receives: The address of userInput
;Returns: A value placed in userInput
;Preconditions: NA
;Registers Changed: EDX, EAX, EBX
getUserRequest PROC
push ebp
mov ebp, esp

__getRequest:
mov edx, OFFSET request_msg
call WriteString
call ReadInt

cmp eax, MINVAL
jl __outOFrange
cmp eax, MAXVAL
jg __outOFrange
jmp __isTrue

__outOFrange:
mov edx, OFFSET out_of_range_msg
call WriteString
call CrLf
jmp __getRequest

__isTrue:
mov ebx, [ebp+8]
mov [ebx], eax


pop ebp
ret 4
getUserRequest ENDP



;Descriptions: Fills the Static array up to 200 elements based on userInput. The randomInt label moves the upper limit of range to 999
;and then ensures that it doesn't go lower than 100(lower limit). Once it is within the range fills the current array element, uses ebx
;as a counter to avoid using loop. Once it reaches 0, exits the call. Pops elements off the stack.
;Receives: userInput and address of array
;Returns: filled array
;Preconditions: userInput has a number between or equal to 10 and 200
;Registers Changed: EBX, EAX, ESI
fillArray PROC
push ebp
mov ebp, esp

mov ebx, [ebp + 12] ;moves userInput(value) to ebx
mov esi, [ebp + 8] ;address of array to esi

__randomInt:
mov eax, HIINT
call RandomRange
cmp eax, LOINT
jge __isWithinRange
jmp __randomInt

__isWithinRange:
mov [esi], eax
add esi, 4
dec ebx
cmp ebx, 0
je __exit
jmp __randomInt



__exit:
pop ebp
ret 8
fillArray ENDP



;Descriptions: Displays the array by 
;Receives: Address of rand_array, OFFSET of title_01 or title_02, and userInput Value
;Returns: NA
;Preconditions: rand_array element = userInput value
;Registers Changed: ESI, EAX, EBX, ECX, EDX
displayArray PROC
push ebp
mov ebp, esp

;Preps the array and writes the title
mov esi, [ebp + 8]
call CrLf
mov edx, [ebp + 16]
call WriteString

;Creates two counters ebx(#rows) and loopcount(Elements in last row not equal to 10)
mov ebx, 10
mov eax, [ebp + 12]
cdq
div ebx
mov ebx, eax
mov loopcount, edx

;Checks counter ebx(#rows), to see if there are any complete rows of elements left to display
;If there are, then it decrements EBX, adds 10 to ECX, and jumps to displayloop2. Otherwise jumps to lastLoop
__displayLoop1:
cmp ebx, 0
je __lastLoop
dec ebx
mov ecx, 10
call CrLf
jmp __displayLoop2

;Writes the current array element selected and the spacing to the terminal. Adds 4 to esi to go to the next element and loops until ECX reaches 0
;then jumps to displayloop1 to check EBX.
__displayLoop2:
mov eax, [esi]
call WriteDec
mov edx, OFFSET spacing
call WriteString
add esi, 4
loop __displayLoop2
jmp __displayLoop1

;Checks to see if there are any elements in the last row between 0-10, if there aren't then it exits the call.
;Loads the remaining elements into ECX for one last loop Write
__lastLoop:
cmp loopcount, 0
je __exit
mov ecx, loopcount
call CrLf
jmp __displayLoop3

;Same as displayLoop2 but instead exits afterwards, rather than jumping to displayloop1
__displayLoop3:
mov eax, [esi]
call WriteDec
mov edx, OFFSET spacing
call WriteString
add esi, 4
loop __displayLoop3
jmp __exit

__exit:
call CrLf
pop ebp
ret 12
displayArray ENDP



;Descriptions: Sorts the array by comparing the current value and the next value. If the current element is greater than the next one
;the procedure switches the elements location, this also raises EDX to be 1 to verify the loop again until there are no elements 
;greater than the next. If the filled rand_array is less than the max capacity, it moves the 0 that it grabs from the next "empty" element
;to the end of the array again. If array size is 200 then just exits without making this switch, since the element after the last is outside
;the array. Exits the call once it ensures EDX is 0, and makes the last switch if necessary.
;Receives: rand_array(unsorted), Title, userInput(value)
;Returns: rand_array(sorted)
;Preconditions: rand_array is filled but no element location exceeds userInput
;Registers Changed: EAX, EBX, ECX, EDX, ESI
sortList PROC
push ebp
mov ebp, esp

;Resets array, EDX flag, and ECX counter.
__loopAgain:
mov edx, 0
mov esi, [ebp + 8]
mov ecx, [ebp + 12]

;Compares values. If current value greater than next, then it jumps to switchelements label.
;If EDX flag is still 0 then exits the loop to lastswitch
__sortLoop1:
mov ebx, [esi]
cmp ebx, [esi + 4]
jg __switchElements
add esi, 4
loop __sortLoop1

cmp edx, 0
je __lastSwitch

jmp __loopAgain

;Switches elements using EDX and EBX. Returns back to sorting loop again after EDX is set to 1.
__switchElements:
mov edx, [esi + 4]
mov [esi], edx
mov [esi + 4], ebx
mov edx, 1
jmp __sortLoop1

;If the initial element is something other than 0, then it exits(userInput must equal 200 for this to be true).
;Otherwise goes to the last loop to move the 0 element to the back of rand_array
__lastSwitch:
mov ecx, [ebp + 12]
mov esi, [ebp + 8]
mov ebx, [esi]
cmp ebx, 0
jg __exit

;Moves the 0 element to the back
__lastLoop:
mov ebx, [esi]
mov edx, [esi + 4]
mov [esi], edx
mov [esi + 4], ebx
add esi, 4
loop __lastLoop


__exit:
pop ebp
ret 8
sortList ENDP



;Descriptions: Calculates the median. If even adds the two middle elements, divides by 2, and adds the remainder
;(Will be either 1 or 0 rounding the median). If it is odd simply goes to the middle number. Writes the median after the calculations.
;Receives: rand_array(sorted), userInput
;Returns: NA
;Preconditions: rand_array must be sorted for this to accurately work
;Registers Changed: ESI, EAX, EBX, EDX
getMedian PROC
push ebp
mov ebp, esp
mov esi, [ebp + 8]

;Determines if it is even or odd by the remainder
mov ebx, 2
mov eax, [ebp + 12]
cdq
div ebx
cmp edx, 0
je __isEven

;multiples eax by 4 to move the correct element into ebx register.
__isOdd:
mov ebx, 4
mul ebx
mov ebx, [esi + eax]
mov eax, ebx
jmp __writeMedian

;Multiples EAX by 4 to get the second middle number, then sub 4 from ESI to get the first middle number
;Adds them together and divides by 2. Remainder is added to round the median as it will be either 1 or 0
__isEven:
mov ebx, 4
mul ebx
mov ebx, [esi + eax]
sub esi, 4
add ebx, [esi + eax]
mov eax, ebx
mov ebx, 2
cdq
div ebx
add eax, edx

;Writes the calculated median
__writeMedian:
call CrLf
mov edx, OFFSET median_msg
call WriteString
call WriteDec
call CrLf

pop ebp
ret 8
getMedian ENDP

; (insert additional procedures here)

END main
