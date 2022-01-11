
; Eliyahu Levinson
; This program prints a triangle of symbols

INCLUDE Irvine32.inc
INCLUDE ex3_q3_data.inc

.data
	header BYTE "Eliyahu Levinson: Ex3-Q3", 13, 10, 0
.code
main PROC
	mov edx, OFFSET header
	call writeString
	
	push SSIZE
	push CHAR
	push SSIZE
	call write_triangle_rec
	
	exit
main ENDP

;-------------------------------------------------
; The function prints a triangle of symbols
; arguments: (that pushed into stack in the odred)
;			 1. size of triangle	 	  (DWORD)
; 	         2. symbol		 		  	  (DWORD)
; 			 3. the same size of triangle (DWORD)
; returns: ---
;-------------------------------------------------

write_triangle_rec PROC
	push ebp
	mov ebp, esp		; Standard prologue

	mov eax, [ebp + 8]
	cmp eax, 0
	je exitFunc

	mov ecx, [ebp + 16]
	sub ecx, eax
	cmp ecx, 0			; check if j < org_size - size
	jng next

	mov al, ' '
	printWhiteSpaces:
		call writeChar
		loop printWhiteSpaces
	
	next:
	mov ecx, [ebp + 8]
	add ecx, [ebp + 8]
	mov eax, [ebp + 12]
	printSymbols:
		call writeChar
		loop printSymbols
	call CRLF

	push SSIZE
	push CHAR
	mov eax, [ebp + 8]
	dec eax
	push eax
	call write_triangle_rec
	
	exitFunc:
	mov esp, ebp		; Standard Epilogue
	pop ebp

	ret 12
write_triangle_rec ENDP
END main