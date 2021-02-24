ORG 0xc400

MOV AX,0
MOV SS,AX
MOV SP,0x7c00
MOV DS,AX
MOV ES,AX

console_m_set:
	MOV SI,msg

write_message:
	MOV AL,[SI]
	ADD SI,1
	CMP AL,0
	JE fin
	MOV AH,0x0e
	MOV BX,15
	INT 0x10
	JMP write_message
fin:
	MOV AL,""
	HLT
	mov ah, 0x1
    int 0x16

    CMP AL, "a"
    JZ console_m_set
	CMP AL,"b"
	JZ console_m_set

	JMP fin
msg:
	DB 0x0d,0x0a
	DB "admin@rihito-os>>"
	DB 0