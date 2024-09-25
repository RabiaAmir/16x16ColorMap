name "16x16 color map"

org 100h


; set video mode:
; text mode. 80x25. 16 colors. 8 pages.
mov ax, 3
int 10h ;Executes this change.

; These commands set up the computer to turn off blinking text,
; so all 16 colors can be used without any of them blinking.
mov ax, 1003h
mov bx, 0 ; disable blinking.
int 10h ; Executes this change.

    
;Initialize Starting Position and Color
mov dl, 0 ; current column.
mov dh, 0 ; current row.

mov bl, 0 ; current attributes(color).

jmp next_char
        
;Main Loop to Print Characters        
next_row:
inc dh ; move to  next row
cmp dh, 16 ; Check if we've reached row 16. 
je stop_print ; If yes, stop printing.
mov dl, 0

next_char:

; set cursor position at (dl,dh):
mov ah, 02h ; Move the cursor to the current column and row.
int 10h

mov al, 'r' ;set character
mov bh, 0   ;set page num
mov cx, 1   ;set char count to 1
mov ah, 09h ;Prepare to write the character with color
int 10h     ;print char r in current color

inc bl ; Change Color for Next Character.

inc dl       ;next column
cmp dl, 16   ;compare current column by 16
je next_row  ;If it is 16, jump to next_row
jmp next_char;Jump back to next_char

stop_print:

; set cursor position at (dl,dh):
mov dl, 10 ; column.
mov dh, 5 ; row.
mov ah, 02h
int 10h

; test of teletype output,
; it uses color attributes
; at current cursor position:
mov al, 'x'
mov ah, 0eh
int 10h


; wait for any key press:
mov ah, 0
int 16h


ret




