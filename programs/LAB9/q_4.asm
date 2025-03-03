.MODEL SMALL
.STACK 100H
.DATA
	MSG DB "Enter a string (max 14 char) : $"
	STRING DB 14,0,14 DUP ("$")
	COLOR_ATTR DB 0CH ;RED COLOR

.CODE
START:
	MOV AX, @DATA
	MOV DS, AX
	MOV AH, 00H
	MOV AL, 03H
	INT 10H ;VIDEO MODE TO 80X25 TEXT MODE
	
	MOV AH, 09H ;DISPLAY INPUT PROMPT
	LEA DX, MSG
	INT 21H

	LEA DX, STRING ;GET USER INPUT
	MOV AH, 0AH
	INT 21H

	MOV AH, 06H ;SCROLL A 20X20 WINDOW
	MOV AL, 0
	MOV BH, 07H
	MOV CH, 2
	MOV CL, 30
	MOV DH, 21
	MOV DL, 50
	INT 10H

	LEA SI, STRING + 2
	MOV CL, [STRING + 1]
	MOV AH, 02H
	MOV BH, 0
	MOV DH, 11
	MOV DL, 40
	INT 10H

PRINT_LOOP:
	CMP CL, 0
	JE EXIT_DISPLAY
	MOV AL, [SI]
	CMP AL, '$'
	JE EXIT_DISPLAY

	MOV AH, 09H ;PRINT COLORED CHARACTER
	MOV BH, 0
	MOV BL, COLOR_ATTR
	MOV CX, 1
	INT 10H
	
	MOV AH, 03H
	MOV BH, 0
	INT 10H
	
	INC DL
	MOV AH, 02H
	INT 10H

	INC SI
	DEC CL
	JMP PRINT_LOOP

EXIT_DISPLAY:
	MOV AH, 4CH
	INT 21H
END START
