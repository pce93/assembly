include Irvine32.inc
.data


tries DWORD 0
welcome BYTE "Think of a number from 0 to 100! Type 'Too low' if my guess is too low, 'Too high' if it's too high, and 'Correct' when answer is found! Inputs are case sensitive!", 0
prompt BYTE "Is your number: ", 0
guess DWORD 50
max DWORD 100
min DWORD 0
tooLow BYTE "Too low", 0
tooHigh BYTE "Too high", 0
userInput BYTE 501 DUP (0)
success BYTE "Correct", 0
success2 BYTE "You got it! It took you ", 0
success3 BYTE " tries!", 0


.code
main proc

	

	mov edx, OFFSET welcome
	call WriteString
	call Crlf
	mov eax, guess

	TRY: 
	mov eax, guess
	mov edx, OFFSET prompt
	call WriteString
	call WriteInt
	inc tries
	call Crlf
	
	mov ecx, 80
	mov edx, OFFSET userInput
	call ReadString
	
	INVOKE Str_compare, 
	ADDR userInput, 
	ADDR tooLow
	je LOWLB

	INVOKE Str_compare,
	ADDR userInput, 
	ADDR tooHigh
	je HIGHLB

	INVOKE Str_compare, 
	ADDR userInput, 
	ADDR success
	je GOOD

	LOWLB: 
	mov eax, guess
	mov min, eax
	mov eax, max
	sub eax, guess
	mov edx, 0
	mov ebx, 2
	div ebx
	add guess, eax
	jmp TRY

	HIGHLB: 
	mov eax, guess
	mov max, eax
	sub eax, min
	mov edx, 0
	mov ebx, 2
	div ebx
	add eax, min
	mov guess, eax
	
	
	jmp TRY

	GOOD:
	mov edx, OFFSET success2
	call WriteString 
	mov eax, tries
	call WriteInt
	mov edx, OFFSET success3
	call WriteString
	
	call Crlf
	call Crlf

	
	invoke ExitProcess,0
main endp
end main