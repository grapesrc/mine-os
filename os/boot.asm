ORG 0xc200

;screen clean
MOV AH,0x00
MOV AL,0x03
INT 0x10

MOV AX,0
MOV SS,AX
MOV SP,0x7c00
MOV DS,AX
MOV ES,AX

MOV SI,msg

putloop:
	MOV AL,[SI]
	ADD SI,1
	CMP AL,0
	JE jamp
	MOV AH,0x0e
	MOV BX,5
	INT 0x10
	JMP putloop
jamp:
	JMP 0xc400
msg:
	DB 0x0a
	DB "welcome"
	DB 0