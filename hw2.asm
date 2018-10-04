TITLE	HW2 字串反轉和大小寫互換
STACK	  SEGMENT	PARA	STACK	'Stack'
	DB	64 DUP(0)
STACK	  ENDS
;---------------------------------------------------
DATASEG   SEGMENT	PARA	'Data'
HEADNG1	  DB	  'Computer Science 36'
HEADNG2	  DB	  19 DUP ('a'), '$'
DATASEG	  ENDS
;---------------------------------------------------
CODESEG	  SEGMENT	PARA	'Code'
MAIN	PROC 	  FAR
	MOV	  AX, DATASEG	;取出 .data 的segment，存入 AX
	MOV	  DS,AX		;
	
	
	MOV	  CX,19		;CX 為19 個 chars
	LEA	  SI,HEADNG1	;SI=HEADNG1的offset 
	LEA	  DI,HEADNG2	;DI=HEADNG2的offset
A10:
	MOV	  AL,[SI]	;AL 取得 [SI](HEADNG1)的char，讓AL存要轉換的char
	MOV	  [DI+18],AL	;反轉字串 讓[DI+18](最後一位) 為Computer Science 36第一個C
	INC	  SI		;INC意思:SI++，下一個，SI=Computer Science 36的o
	DEC	  DI		;DEC意思:DI--，讓他變成[DI-1+18](倒數第二位)
	DEC	  CX		;DEC意思:CX--，CX=19-1=18(剩18個字元要轉換)	
	JNZ	  A10		;JNZ意思:若count不等於0則跳到 A10，重複程式
	MOV	  CX,19	
	
A20:			
	MOV	  AH,[SI]	;抓SI(HEADNG2)的第一個字元
	CMP	  AH,41H	;判斷字元是否為英文字母 大寫:41H~5AH  小寫:61H~7AH
	JB 	  A40		;若AH<41H則跳到A40
	CMP	  AH,7AH	;
	JA	  A40		;若AH>7AH則跳到A40
	CMP	  AH,5AH	;
	JBE 	  A30		;若AH<=5AH則跳到A30(大寫轉小寫)
	CMP	  AH,61H	;
	JA	  A30		;若AH>=61H則跳到A30(小寫轉大寫)
	
	CMP	  AH,5AH	;
	JA 	  A40		;若AH>5AH則跳到A40(大寫小寫間的字元不做改變)

A30:
	XOR	  AH,00100000B  ;執行大小寫互換(byte第三位0變1，1變0)
	MOV	  [SI],AH	;將換完的字母存回SI(HEADNG2)

A40:
	INC	  SI		;BX(HEADNG2)++ 繼續做下一個字元
	LOOP	  A20		;迴圈，總共會執行CX(19)次 

	MOV	  AH,09H	;輸出字串到螢幕，但要顯示的字串必須以「$」結束
	LEA	  DX,HEADNG2	;從HEADNG2開始顯示字串
	INT	  21H		;INT意思:呼叫中斷副程式

	MOV	  AX,4C00H	;結束程式
	INT	  21H 		;INT意思:呼叫中斷副程式
MAIN	ENDP
CODESEG	ENDS
	END	  MAIN
