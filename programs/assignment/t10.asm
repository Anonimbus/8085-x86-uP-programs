.MODEL SMALL
.STACK 64

.DATA
    ; C DB 80 DUP('#'),'$'
    SPACE DB 6 DUP(' '), '$'
    COUNT DB 7D 
    VAL DB 32D
    ROW DB 6D

.CODE
MAIN PROC FAR
    MOV AX, @DATA
    MOV DS, AX

    XOR CX,CX
    MOV CL, 25D
    XOR BX, BX

    MOV AX, 0003H
    INT 10H 

    ; MOV AH, 09H
    ; MOV DX, OFFSET C 
    ; LP1:
    ; INT 21H
    ; LOOP LP1

    MOV AH, 07H
    MOV AL, 00H 
    MOV CH, 05D  
    MOV CL, 10D  
    MOV DH, 20D  
    MOV DL, 70D 
    MOV BH, 1FH
    INT 10H 

    MOV AH, 02H
    MOV BH, 00H 
    MOV DH, ROW 
    MOV DL, 10D 
    INT 10H

    XOR BL, BL
    LP2:
    MOV DL, VAL
    MOV AH, 02H
    INT 21H
    CMP BL, COUNT 
    JNE SKIP

    MOV BL, 0
    MOV AH, 02H
    MOV BH, 00H 
    MOV DH, ROW 
    MOV DL, 10D 
    INT 10H
    INC ROW

    SKIP:
    MOV AH, 09H
    MOV DX, OFFSET SPACE 
    INT 21H

    INC BL
    INC VAL
    CMP VAL, 127D
    JBE LP2
    


    MOV AX, 4C00H
    INT 21H

MAIN ENDP
END MAIN