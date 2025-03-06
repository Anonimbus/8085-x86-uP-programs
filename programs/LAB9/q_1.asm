.MODEL SMALL
.STACK 100H

.DATA
    MSG DB "Programming in Assembly Language is Fun$" ; String to display
    REVERSE_ATTR DB F0h ; Reverse video color attribute (white text, black background )

.CODE
START:
    ; Set up the data segment
    MOV AX, @DATA
    MOV DS, AX

    ; Set video mode to 80x25 text mode (standard mode)
    MOV AH, 00H
    MOV AL, 03H
    INT 10H

    ; Scroll the window with reverse video attribute
    MOV AH, 06H          ; Scroll window function
    MOV AL, 0            ; Scroll up (0 = scroll up, 1 = scroll down)
    MOV BH, REVERSE_ATTR ; Reverse video color attribute
    MOV CH, 5            ; Top row (row 5)
    MOV CL, 20           ; Left column (column 20)
    MOV DH, 20           ; Bottom row (row 20)
    MOV DL, 60           ; Right column (column 60)
    INT 10H

    ; Move cursor to row 12, column 30
    MOV AH, 02H  ; Set cursor position function
    MOV BH, 0    ; Page number (0)
    MOV DH, 12   ; Row 12
    MOV DL, 30   ; Column 30
    INT 10H

    ; Display the string "Programming in Assembly Language is Fun"
    MOV AH, 09H  ; DOS function to display a string
    LEA DX, MSG  ; Load address of the string into DX
    INT 21H

    ; Exit the program
    MOV AH, 4Ch  ; DOS function to terminate the program
    INT 21H

END START
