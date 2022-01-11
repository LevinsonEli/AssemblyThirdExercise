
; Eliyahu Levinson
; This program calculates sum of two arrays prints the result
; And prints sum of wich array is bigger
; The arrays are stored in ex3_q1_data.inc and named: Arr_1, Arr_2. Arrays are WORD size.
; The appropriate messages for output are stored in ex3_q1_data.inc.
; 

INCLUDE Irvine32.inc
INCLUDE ex3_q1_data.inc

.data
	header BYTE "Eliyahu Levinson: Ex3-Q1", 13, 10, 0
	arrsEqual BYTE "Sum of Arr_1 is Equal to sum of Arr_2", 10, 13, 0
	newLine BYTE 13, 10, 0
.code
main PROC
	mov edx, OFFSET header
	call writeString

	mov edx, OFFSET msg1
	call writeString

	push LENGTHOF Arr_1			; The arguments for function
	push OFFSET Arr_1

	call ArrSum
	call writeInt				; Printing first array's sum
	mov edx, OFFSET newLine
	call writeString
	mov ebx, eax				; Saving the first array's sum in $ebx
	
	mov edx, OFFSET msg2
	call writeString
	
	push LENGTHOF Arr_2			; The arguments for function
	push OFFSET Arr_2

	call ArrSum
	call writeInt				; Printing second array's sum
	mov edx, OFFSET newLine
	call writeString

	cmp ebx, eax				; compare the sums
	jg arr1Bigger
	jl arr2Bigger
								; Printing the output
	mov edx, OFFSET arrsEqual
	call writeString
	mov edx, OFFSET newLine
	call writeString
	jmp exitProc

	arr2Bigger:
	mov edx, OFFSET arr2_bigger
	call writeString
	mov edx, OFFSET newLine
	call writeString
	jmp exitProc

	arr1Bigger:
	mov edx, OFFSET arr1_bigger
	call writeString
	mov edx, OFFSET newLine
	call writeString

exitProc:
	exit
main ENDP

;-------------------------------------------------
; The function calculates sum of WORD array
; arguments: (that pushed into stack in the order)
;            1. size of array	 (DWORD)
; 	         2. array's address
; returns: sum of array's elements in $EAX
;-------------------------------------------------

ArrSum PROC
	push ebp
	mov ebp, esp		; Standard prologue

	push ecx			; uses $ecx, $esi, $ebx
	push esi
	push ebx

	mov ecx, [esp + 24]
	mov esi, [esp + 20]

	mov eax, 0
	sumLoop:
		movsx ebx, WORD PTR [esi]		; every element is WORD
		add eax, ebx					; the sum is DWORD
		add esi, 2
		loop sumLoop
	
	pop ebx
	pop esi
	pop ecx

	mov esp, ebp		; Standard Epilogue
	pop ebp

	ret 8				; Two DWORD parameters was pushed
arrSum ENDP

END main