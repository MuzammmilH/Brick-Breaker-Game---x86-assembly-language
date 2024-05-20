.model small
.stack 100h
.data

welcome_var1              db "WELCOME TO",'$'
    welcome_var2              db "BRICK BREAKER", '$'
    welcome_var3              db "GAME", '$'

    welcome_var4              db 0ah, 0dh,"                  ==========================="
                              db 0ah, 0dh,"                  ==========================="
                              db 0ah, 0dh, '$'

    mun_menu_count_var        dw 6   ; number of items in menu.
    mun_selected_var          dw 0     ; currenlty selected menu item.

    mun_selector_var_cursor   db '                  ==== ->  $'
    empty_selector_var_cursor db '                  ====     $'


    menu_screen_display_1     db 'Start Game      ====', 0ah, 0dh,'$'
    menu_screen_display_2     db 'Done By         ====', 0ah, 0dh,'$'
    menu_screen_display_3     db 'ABOUT           ====', 0ah, 0dh,'$'
    menu_screen_display_4     db 'Score_History   ====', 0ah, 0dh,'$'
    menu_screen_display_5     db 'Instructions    ====', 0ah, 0dh,'$'
    menu_screen_display_6     db 'Quit            ====', 0ah, 0dh,'$' 
    menu_screen_display_7     db "                  ==========================="
                              db 0ah, 0dh,"         ===========================$"
    

    mun_item_adder_ptr        dw  menu_screen_display_1, menu_screen_display_2, menu_screen_display_3, menu_screen_display_4, menu_screen_display_5, menu_screen_display_6, menu_screen_display_7

    menu_cursor_up_var        equ 48h
    menu_cursor_down_var      equ 50h
    menu_score_count_var      dw  0
    menu_score_message_var    db "Score is : $"

    game_ball_1_var           dw 0
    game_ball_2_var           dw 0
    game_ball_loose_var       dw 0



    menu_display_1            db  0ah, 0dh, "-------------------------------------------------------------------|"
                              db  0ah, 0dh, "|                                                                  |"
                              db  0ah, 0dh, "|         Presenters :                                             |"
                              db  0ah, 0dh, "|                                                                  |"
                              db  0ah, 0dh, "|                                                                  |"
                              db  0ah, 0dh, "|                         Munam Mustafa, i21-0460                  |"  
                              db  0ah, 0dh, "|                                                                  |"
                              db  0ah, 0dh, "|                         Muzammil Hassan, i21-0631                |"
                              db  0ah, 0dh, "|                                                                  |"
                              db  0ah, 0dh, "-------------------------------------------------------------------|$"




    menu_display_2            db  0ah, 0dh, "--------------------------------------------------------------------"
                              db  0ah, 0dh, "|                                                                  |"
                              db  0ah, 0dh, "|  IT IS A SINGLE PLAYER GAME. IF LIVES ARE LOST THEN GAME OVER    |"
                              db  0ah, 0dh, "--------------------------------------------------------------------$"



    menu_display_3            db  0ah, 0dh, "--------------------------------------------------------------------"
                              db  0ah, 0dh, "|                           CONTROLS                                |"
                              db  0ah, 0dh, "|   USE THE LEFT AND RIGHT ARROW KEYS TO MOVE THE BAR               |"
                              db  0ah, 0dh, "--------------------------------------------------------------------$"


    menu_display_4            db  0ah, 0dh, "-----------------------------------------------"
                              db  0ah, 0dh, "|                                             |"
                              db  0ah, 0dh, "|                   THANK YOU                 |"
                              db  0ah, 0dh, "|                      FOR                    |"
                              db  0ah, 0dh, "|               PLAYING THE GAME              |"
                              db  0ah, 0dh, "|                                             |"
                              db  0ah, 0dh, "-----------------------------------------------$"

;--BALL VARIABLES--
waisehi db 0
ball_x dw 160
ball_y dw 200 
ball_speed_x dw 07h
ball_speed_y dw 07h
ball_reset_x dw 160
ball_reset_y dw 200
ball_size dw 08h
;---------------

;--PADDLE VARIABLES--
paddle_x dw 280
paddle_y dw 410
paddle_left_speed dw 07h
paddle_right_speed dw 07h
paddle_w dw 70
paddle_h dw 10
;------------------

;--BLOCK VARIABLES--
block_x_1 dw 40
block_y_1 dw 40

block_x_2 dw 130
block_y_2 dw 40

block_x_3 dw 220
block_y_3 dw 40
 
block_x_4 dw 310
block_y_4 dw 40

block_x_5 dw 400
block_y_5 dw 40

block_x_6 dw 490
block_y_6 dw 40

block_x_7 dw 40
block_y_7 dw 90

block_x_8 dw 130
block_y_8 dw 90

block_x_9 dw 220
block_y_9 dw 90

block_x_10 dw 310
block_y_10 dw 90

block_x_11 dw 400
block_y_11 dw 90

block_x_12 dw 490
block_y_12 dw 90

block_width dw 70
block_height dw 15
;------------------

screen_height dw 1E0H
screen_width dw 280H
time db 0
lives db 3

text_player_lives db 51,'$'
player_points db 48,'$'
;str3 "Lives:",'$'

str1 db "Press N for next level",'$'
str2 db "Press N for next level",'$'
next_level_check db 0
next_level_check_2 db 1

collision1 db 0
collision2 db 0
collision3 db 0
collision4 db 0
collision5 db 0    ;collisions for level2
collision6 db 0
collision7 db 0
collision8 db 0
collision9 db 0
collision10 db 0
collision11 db 0
collision12 db 0

collision1_1 db 0
collision21 db 0
collision31 db 0
collision41 db 0
collision51 db 0
collision61 db 0       ;for collisions for level3
collision71 db 0
collision81 db 0
collision91 db 0
collision101 db 0
collision111 db 0
collision121 db 0
.code

;------------------------
main PROC 
    mov ax,@data
    mov ds, ax
    ; video mode (graphic)
    mov ah, 0h
    mov al, 12h    ;640x480
    int 10h

    call Print_Menu
	mov ah,0
	int 16h

	cmp al, 10
	je jump

    jump:
    
    call Clear_screen
    call MENU_1
    call Block1
    call Block2
    call Block3
    call Block4
    call Block5
    call Block6
    call Block7
    call Block8
    call Block9
    call Block10
    call Block11
    call Block12

    call delay
    mov ah,4ch 
    int 21h
    
main ENDP

;------------------PRINT MENU--------------------------------
Print_Menu Proc

    ;video mode (graphic) 
    mov ah, 0
    mov al, 13h    ;320x200
    int 10h

    ;---------------square
    ;-----------------------start
    mov cx, 50    ;(column)
    mov dx, 50    ;(row)

    loop1:
    cmp cx, 220
    je skip
    MOV AL, 1110b  ;yellow color
    MOV AH, 0CH 
    INT 10H

    inc cx
    jmp loop1

    skip:
    ;------------------------end
    ;-----------------------start
    mov cx, 50    ;(column)
    mov dx, 150    ;(row)

    loop2:
    cmp cx, 220
    je skip2
    MOV AL, 1110b  ;yellow color
    MOV AH, 0CH 
    INT 10H

    inc cx
    jmp loop2

    skip2:
    ;------------------------end
    ;-----------------------start
    mov cx, 50    ;(column)
    mov dx, 50    ;(row)

    loop3:
    cmp dx, 150
    je skip3
    MOV AL, 1110b  ;yellow color
    MOV AH, 0CH 
    INT 10H

    inc dx
    jmp loop3

    skip3:
    ;------------------------end
    ;-----------------------start
    mov cx, 220    ;(column)
    mov dx, 50    ;(row)

    loop4:
    cmp dx, 150
    je skip4
    MOV AL, 1110b  ;yellow color
    MOV AH, 0CH 
    INT 10H

    inc dx
    jmp loop4

    skip4:
    ;------------------------end
    mov ah,02h
    mov bx, 0
    mov dh ,8
    mov dl ,12
    int 10h

    mov ah,9h
    lea dx,welcome_var1

    int 21h

    mov ah,02h
    mov bx, 0
    mov dh ,12
    mov dl ,10
    int 10h

    mov ah,9h
    lea dx,welcome_var2

    
    int 21h
    
    mov ah,02h
    mov bx, 0
    mov dh ,16
    mov dl ,15
    int 10h

    mov ah,9h
    lea dx,welcome_var3

    int 21h

    ret

Print_Menu ENDP
;----------------------------------------START MENU-----------------------------
MENU_1 PROC     
    push ax
    push bx
    push cx
    push dx
   

menu_screen:
    menu:
    
        call Clear_screen
        mov ah,9
        lea dx, welcome_var4
        int 21h
        
        mov bx, 0
        mov cx, mun_menu_count_var

        print_selected_item:

            mov ax, bx
            shr ax, 1   ; DIVIDE BY 2.
            cmp ax, mun_selected_var
            jne not_selected_item
            
            lea dx, mun_selector_var_cursor
            mov ah, 09H
            int 21h
                
            JMP control
        not_selected_item:
            lea dx, empty_selector_var_cursor
            MOV ah, 09h
            int 21h
        control:   
            mov dx, mun_item_adder_ptr[BX]
            MOV ah, 09h
            int 21h
            
            add bx, 2  ; NEXT ITEM.
        LOOP print_selected_item
        
        
        
        mov ah,9
        lea dx, menu_screen_display_7
        int 21h
            
        
        pressed_key_check:
            mov ah, 01h
            int 16H
            jz no_key_pressed
        
            mov ah, 00h
            int 16h
        
            cmp al, 1bh    ; ESC - KEY?
            je not_pressed_enter  ;
        
            cmp ah, menu_cursor_up_var
            jne not_upper_key_pressed

            sub mun_selected_var, 1
        
        
        not_upper_key_pressed:
        
            cmp ah, menu_cursor_down_var
            jne not_down_key_pressed

            add mun_selected_var, 1
        
        not_down_key_pressed:

            ; enter pressed?      
            cmp ah, 1ch
            jne not_pressed_enter

            cmp mun_selected_var, 0
            jne not_menu_screen_display_1

            call Clear_screen
            jmp start_game

        not_menu_screen_display_1:

            cmp mun_selected_var, 1
            jne not_menu_screen_display_2
            call Clear_screen

            lea dx, menu_display_1
            mov ah, 9
            int 21h     

            mov ah, 1
            int 21h

            jmp menu_screen
            
        not_menu_screen_display_2:

            cmp mun_selected_var, 2
            jne not_menu_screen_display_3

            call Clear_screen
            lea dx, menu_display_2
            mov ah, 9
            int 21h

            mov ah, 1
            int 21h
            jmp menu_screen

        not_menu_screen_display_3:

            cmp mun_selected_var,3
            jne not_menu_screen_display_4

            call Clear_screen
            call display_score          

            mov ah, 1
            int 21h
            jmp menu_screen

        not_menu_screen_display_4:

            cmp mun_selected_var, 4
            jne not_menu_screen_display_5
            call Clear_screen

            lea dx, menu_display_3
            mov ah, 9
            int 21h  
            
            mov ah, 1
            int 21h   
            jmp menu_screen

        not_menu_screen_display_5:
            cmp mun_selected_var,5
            jne not_menu_screen_display_6
            call Clear_screen

            lea dx, menu_display_4
            mov ah, 9
            int 21h

            mov ah,1
            int 21h   
            jmp stop

        not_menu_screen_display_6:
            ; WAIT FOR KEY:
            mov ah, 00
            int 16h   

        not_pressed_enter:

            ; CHECK IF OUT OF MENU BOUNDS:
            cmp mun_selected_var, -1
            jnle OK1
            mov mun_selected_var, 0

        OK1:
            
            mov ax, mun_menu_count_var
            cmp mun_selected_var, ax
            jnge OK2
            dec ax
            mov mun_selected_var, ax
        
        OK2:
            jmp MENU
        
        no_key_pressed:
            jmp pressed_key_check
    
    
    
    stop:
        
        mov ah,4ch
        int 21h

start_game:       
    mov game_ball_1_var,0
    mov game_ball_2_var,0
    mov game_ball_loose_var, 0
pop dx
pop cx      
pop bx        
pop ax
ret     
MENU_1 ENDP


display_score PROC
push ax
push bx
push cx
push dx

    call Clear_screen
                            
    mov ah, 9
    lea dx, menu_score_message_var
    int 21h
    
    mov ax, menu_score_count_var
    mov bx, 10d
    xor cx, cx

    SAV_DEC:
        xor dx, dx

        div bx    
        inc cx

        push dx

        or ax, ax
        jnz SAV_DEC
        
        mov ah, 2 
        
    OUT_DEC:
        pop dx
        add dx,30H
        int 21h
        loop OUT_DEC
       mov ah,1
       int 21h
    pop dx
    pop cx      
    pop bx        
    pop ax
    
    ret
display_score ENDP


;------DRAW BALL FUNCTION-----

DrawBall PROC

    mov ax,ball_speed_x
    sub ball_x,ax

    mov ax,ball_speed_y
    sub ball_y,ax

    MOV CX, ball_x    ;(row)
    MOV DX, ball_y    ;(col)

Draw_black_ball:
    mov al,0h
    mov ah,0CH
    int 10h

    inc CX
    mov ax,cx
    sub ax,ball_x
    cmp ax, ball_size
    jng Draw_black_ball

    mov cx,ball_x
    inc DX
    mov AX,DX
    sub AX,ball_y
    cmp AX,ball_size
    jng Draw_black_ball


    mov ax,ball_speed_x
    add ball_x,ax
    mov ax,ball_speed_y
    add ball_y,ax

    MOV CX, ball_x    ;(row)
    MOV DX, ball_y ;(col)

Draw_ball_1:
    mov al,01h
    mov ah,0CH
    int 10h

    inc CX
    mov ax,cx
    sub ax,ball_x
    cmp ax, ball_size
    jng Draw_ball_1

    mov cx,ball_x
    inc DX
    mov AX,DX
    sub AX,ball_y
    cmp AX,ball_size
    jng Draw_ball_1

ret
DrawBall endP   
;------------------------------------

;----DRAW PADDLE FUNCTION----
DrawPaddle PROC    

MOV CX,paddle_x    ;(row)
MOV DX,paddle_y    ;(col)

Draw_paddle_1:
    mov ah,0ch
    mov al,03h
    int 10h

    inc CX
    mov ax,cx
    sub ax,paddle_x
    cmp ax,paddle_w
    jng Draw_paddle_1

    mov cx,paddle_x
    inc DX
    mov AX,DX
    sub AX,paddle_y
    cmp AX,paddle_h
    jng Draw_paddle_1

ret
DrawPaddle ENDP  
;------------------------

;------------DRAWING BLOCKS------------------------------------------
Block1 PROC    

MOV CX,block_x_1  ;(row)
MOV DX,block_y_1  ;(col)

Draw_block_1:
    mov ah,0ch
    mov al,09h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_1
    cmp ax,block_width
    jng Draw_block_1

    mov cx,block_x_1
    inc DX
    mov AX,DX
    sub AX,block_y_1
    cmp AX,block_height
    jng Draw_block_1

ret 
Block1 ENDP  


Block2 PROC    

MOV CX,block_x_2  ;(row)
MOV DX,block_y_2  ;(col)

Draw_block_2:
    mov ah,0ch
    mov al,02h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_2
    cmp ax,block_width
    jng Draw_block_2

    mov cx,block_x_2
    inc DX
    mov AX,DX
    sub AX,block_y_2
    cmp AX,block_height
    jng Draw_block_2

ret 
Block2 ENDP  

Block3 PROC    

MOV CX,block_x_3  ;(row)
MOV DX,block_y_3  ;(col)

Draw_block_3:
    mov ah,0ch
    mov al,09h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_3
    cmp ax,block_width
    jng Draw_block_3

    mov cx,block_x_3
    inc DX
    mov AX,DX
    sub AX,block_y_3
    cmp AX,block_height
    jng Draw_block_3

ret 
Block3 ENDP  

Block4 PROC    

MOV CX,block_x_4  ;(row)
MOV DX,block_y_4  ;(col)

Draw_block_4:
    mov ah,0ch
    mov al,02h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_4
    cmp ax,block_width
    jng Draw_block_4

    mov cx,block_x_4
    inc DX
    mov AX,DX
    sub AX,block_y_4
    cmp AX,block_height
    jng Draw_block_4

ret 
Block4 ENDP 

Block5 PROC    

MOV CX,block_x_5  ;(row)
MOV DX,block_y_5  ;(col)

Draw_block_5:
    mov ah,0ch
    mov al,09h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_5
    cmp ax,block_width
    jng Draw_block_5

    mov cx,block_x_5
    inc DX
    mov AX,DX
    sub AX,block_y_5
    cmp AX,block_height
    jng Draw_block_5

ret 
Block5 ENDP 

Block6 PROC    

MOV CX,block_x_6  ;(row)
MOV DX,block_y_6  ;(col)

Draw_block_6:
    mov ah,0ch
    mov al,02h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_6
    cmp ax,block_width
    jng Draw_block_6

    mov cx,block_x_6
    inc DX
    mov AX,DX
    sub AX,block_y_6
    cmp AX,block_height
    jng Draw_block_6

ret 
Block6 ENDP 

Block7 PROC    

MOV CX,block_x_7  ;(row)
MOV DX,block_y_7  ;(col)

Draw_block_7:
    mov ah,0ch
    mov al,02h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_7
    cmp ax,block_width
    jng Draw_block_7

    mov cx,block_x_6
    inc DX
    mov AX,DX
    sub AX,block_y_7
    cmp AX,block_height
    jng Draw_block_7

ret 
Block7 ENDP 

Block8 PROC    

MOV CX,block_x_8  ;(row)
MOV DX,block_y_8  ;(col)

Draw_block_8:
    mov ah,0ch
    mov al,09h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_8
    cmp ax,block_width
    jng Draw_block_8

    mov cx,block_x_8
    inc DX
    mov AX,DX
    sub AX,block_y_8
    cmp AX,block_height
    jng Draw_block_8

ret 
Block8 ENDP 

Block9 PROC    

MOV CX,block_x_9  ;(row)
MOV DX,block_y_9  ;(col)

Draw_block_9:
    mov ah,0ch
    mov al,02h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_9
    cmp ax,block_width
    jng Draw_block_9

    mov cx,block_x_9
    inc DX
    mov AX,DX
    sub AX,block_y_9
    cmp AX,block_height
    jng Draw_block_9

ret 
Block9 ENDP 

Block10 PROC    

MOV CX,block_x_10  ;(row)
MOV DX,block_y_10  ;(col)

Draw_block_10:
    mov ah,0ch
    mov al,09h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_10
    cmp ax,block_width
    jng Draw_block_10

    mov cx,block_x_10
    inc DX
    mov AX,DX
    sub AX,block_y_10
    cmp AX,block_height
    jng Draw_block_10

ret 
Block10 ENDP 

Block11 PROC    

MOV CX,block_x_11  ;(row)
MOV DX,block_y_11  ;(col)

Draw_block_11:
    mov ah,0ch
    mov al,02h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_11
    cmp ax,block_width
    jng Draw_block_11

    mov cx,block_x_11
    inc DX
    mov AX,DX
    sub AX,block_y_11
    cmp AX,block_height
    jng Draw_block_11

ret 
Block11 ENDP 


Block12 PROC    

MOV CX,block_x_12  ;(row)
MOV DX,block_y_12  ;(col)

Draw_block_12:
    mov ah,0ch
    mov al,09h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_12
    cmp ax,block_width
    jng Draw_block_12

    mov cx,block_x_12
    inc DX
    mov AX,DX
    sub AX,block_y_12
    cmp AX,block_height
    jng Draw_block_12

ret 
Block12 ENDP 
;--------------------------------------------------------------

;----MOVE BALL FUNCTION----
MoveBall PROC    

mov ax,ball_speed_x
add ball_x,ax

cmp ball_x,00h   
jle neg_velocity_x

mov ax,screen_width   ;for not going out of the screen
sub ax,ball_size
sub ax,06h
cmp ball_x,ax
jge neg_velocity_x

mov ax,ball_speed_y
add ball_y,ax

cmp ball_y,00h
jle reset_position

mov ax,screen_height
sub ax,ball_size
sub ax,06h
cmp ball_y,ax
jge reset_position

mov ax,ball_x     ;for paddle collision x-axis
add ax,ball_size
cmp ax,paddle_x
jng check_b1

mov ax,paddle_x
add ax ,paddle_w
cmp ball_x,ax
jnl check_b1

mov ax,ball_y     ;for paddle collision y-axis
add ax,ball_size
cmp ax,paddle_y
jng check_b1

mov ax,paddle_y
add ax,paddle_h
cmp ball_y,ax
jnl check_b1

jmp neg_velocity_y
;-------------------block1 collision---------
check_b1:
mov ax,ball_x     ;for collision x-axis
add ax,ball_size
cmp ax,block_x_1
jng check_b2

mov ax,block_x_1
add ax ,block_width
cmp ball_x,ax
jnl check_b2

mov ax,ball_y     ;for collision y-axis
add ax,ball_size
cmp ax,block_y_1
jng check_b2

mov ax,block_y_1
add ax,block_height
cmp ball_y,ax
jnl check_b2

cmp next_level_check,1
je Collision_1
jne black1

cmp next_level_check_2,2
je Collision_1_1
jne black1

Collision_1:
inc collision1
cmp collision1,2
jge black1
jmp neg_velocity_1

Collision_1_1:
inc collision1_1
cmp collision1_1,3  
jge black1
jmp neg_velocity_1

black1:
MOV CX,block_x_1 ;(row)
MOV DX,block_y_1  ;(col)        ;to draw black block of collide

Draw_block_b1:
inc player_points
    mov ah,0ch
    mov al,0h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_1
    cmp ax,block_width
    jng Draw_block_b1

    mov cx,block_x_1
    inc DX
    mov AX,DX
    sub AX,block_y_1
    cmp AX,block_height
    jng Draw_block_b1

;NEG ball_speed_x
neg_velocity_1:
jmp neg_velocity_y
;---------------------------------------------


;-------------------block2 collision---------


check_b2:
mov ax,ball_x     ;for collision x-axis
add ax,ball_size
cmp ax,block_x_2
jng check_b3

mov ax,block_x_2
add ax ,block_width
cmp ball_x,ax
jnl check_b3

mov ax,ball_y     ;for collision y-axis
add ax,ball_size
cmp ax,block_y_2
jng check_b3

mov ax,block_y_2
add ax,block_height
cmp ball_y,ax
jnl check_b3

cmp next_level_check,1
je Collision_2
jne black2

cmp next_level_check_2,2
je Collision_21
jne black2

Collision_2:
inc collision2
cmp collision2,2
jge black2
jmp neg_velocity_2

Collision_21:
inc collision21
cmp collision21,3  
jge black2
jmp neg_velocity_2

black2:
MOV CX,block_x_2 ;(row)      ;to draw black block of collide
MOV DX,block_y_2  ;(col)

Draw_block_b2:
inc player_points
    mov ah,0ch
    mov al,0h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_2
    cmp ax,block_width
    jng Draw_block_b2

    mov cx,block_x_2
    inc DX
    mov AX,DX
    sub AX,block_y_2
    cmp AX,block_height
    jng Draw_block_b2

;NEG ball_speed_x
neg_velocity_2:
jmp neg_velocity_y
;---------------------------------------------

;-------------------block3 collision---------
check_b3:
mov ax,ball_x    ;for collision x-axis
add ax,ball_size
cmp ax,block_x_3
jng check_b4

mov ax,block_x_3
add ax ,block_width
cmp ball_x,ax
jnl check_b4

mov ax,ball_y     ;for collision y-axis
add ax,ball_size
cmp ax,block_y_3
jng check_b4

mov ax,block_y_3
add ax,block_height
cmp ball_y,ax
jnl check_b4

cmp next_level_check,1
je Collision_3
jne black3

cmp next_level_check_2,2
je Collision_31
jne black3

Collision_3:
inc collision3
cmp collision3,2
jge black3
jmp neg_velocity_3

Collision_31:
inc collision31
cmp collision31,3  
jge black3
jmp neg_velocity_3

black3:
MOV CX,block_x_3  ;(row)
MOV DX,block_y_3  ;(col)     ;to draw black block of collide

Draw_block_b3:
inc player_points
    mov ah,0ch
    mov al,0h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_3
    cmp ax,block_width
    jng Draw_block_b3

    mov cx,block_x_3
    inc DX
    mov AX,DX
    sub AX,block_y_3
    cmp AX,block_height
    jng Draw_block_b3

;NEG ball_speed_x
neg_velocity_3:
jmp neg_velocity_y
;---------------------------------------------

;-------------------block4 collision---------
check_b4:
mov ax,ball_x     ;for collision x-axis
add ax,ball_size
cmp ax,block_x_4
jng check_b5

mov ax,block_x_4
add ax ,block_width
cmp ball_x,ax
jnl check_b5

mov ax,ball_y     ;for collision y-axis
add ax,ball_size
cmp ax,block_y_4
jng check_b5

mov ax,block_y_4
add ax,block_height
cmp ball_y,ax
jnl check_b5

cmp next_level_check,1
je Collision_4
jne black4

cmp next_level_check_2,2
je Collision_41
jne black4

Collision_4:
inc collision4
cmp collision4,2
jge black4
jmp neg_velocity_4

Collision_41:
inc collision41
cmp collision41,3  
jge black4
jmp neg_velocity_4


black4:
MOV CX,block_x_4  ;(row)
MOV DX,block_y_4  ;(col)    ;to draw black block of collide

Draw_block_b4:
inc player_points
    mov ah,0ch
    mov al,0h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_4
    cmp ax,block_width
    jng Draw_block_b4

    mov cx,block_x_4
    inc DX
    mov AX,DX
    sub AX,block_y_4
    cmp AX,block_height
    jng Draw_block_b4

;NEG ball_speed_x
neg_velocity_4:
jmp neg_velocity_y
;---------------------------------------------

;-------------------block5 collision---------
check_b5:
mov ax,ball_x     ;for collision x-axis
add ax,ball_size
cmp ax,block_x_5
jng check_b6

mov ax,block_x_5
add ax ,block_width
cmp ball_x,ax
jnl check_b6

mov ax,ball_y     ;for collision y-axis
add ax,ball_size
cmp ax,block_y_5
jng check_b6

mov ax,block_y_5
add ax,block_height
cmp ball_y,ax
jnl check_b6

cmp next_level_check,1
je Collision_5
jne black5

cmp next_level_check_2,2
je Collision_51
jne black5

Collision_5:
inc collision5
cmp collision5,2
jge black5
jmp neg_velocity_5

Collision_51:
inc collision51
cmp collision51,3  
jge black5
jmp neg_velocity_5

black5:
MOV CX,block_x_5  ;(row)    ;to draw black block of collide
MOV DX,block_y_5  ;(col)

Draw_block_b5:
inc player_points
    mov ah,0ch
    mov al,0h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_5
    cmp ax,block_width
    jng Draw_block_b5

    mov cx,block_x_5
    inc DX
    mov AX,DX
    sub AX,block_y_5
    cmp AX,block_height
    jng Draw_block_b5

;NEG ball_speed_x
neg_velocity_5:
jmp neg_velocity_y
;---------------------------------------------

;-------------------block6 collision---------
check_b6:
mov ax,ball_x     ;for collision x-axis
add ax,ball_size
cmp ax,block_x_6
jng check_b7

mov ax,block_x_6
add ax ,block_width
cmp ball_x,ax
jnl check_b7

mov ax,ball_y     ;for collision y-axis
add ax,ball_size
cmp ax,block_y_6
jng check_b7

mov ax,block_y_6
add ax,block_height
cmp ball_y,ax
jnl check_b7

cmp next_level_check,1
je Collision_6
jne black6

cmp next_level_check_2,2
je Collision_61
jne black6

Collision_6:
inc collision6
cmp collision6,2
jge black6
jmp neg_velocity_6

Collision_61:
inc collision61
cmp collision61,3  
jge black6
jmp neg_velocity_6

black6:
MOV CX,block_x_6  ;(row)     ;to draw black block of collide
MOV DX,block_y_6  ;(col)
Draw_block_b6:
inc player_points
    mov ah,0ch
    mov al,0h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_6
    cmp ax,block_width
    jng Draw_block_b6

    mov cx,block_x_6
    inc DX
    mov AX,DX
    sub AX,block_y_6
    cmp AX,block_height
    jng Draw_block_b6

;jmp neg_velocity_x
neg_velocity_6:
jmp neg_velocity_y
;---------------------------------------------

;-------------------block7 collision---------
check_b7:
mov ax,ball_x     ;for collision x-axis
add ax,ball_size
cmp ax,block_x_7
jng check_b8

mov ax,block_x_7
add ax ,block_width
cmp ball_x,ax
jnl check_b8

mov ax,ball_y     ;for collision y-axis
add ax,ball_size
cmp ax,block_y_7
jng check_b8

mov ax,block_y_7
add ax,block_height
cmp ball_y,ax
jnl check_b8

cmp next_level_check,1
je Collision_7
jne black7

cmp next_level_check_2,2
je Collision_71
jne black7

Collision_7:
inc collision7
cmp collision7,2
jge black7
jmp neg_velocity_7

Collision_71:
inc collision71
cmp collision71,3  
jge black7
jmp neg_velocity_7

black7:
MOV CX,block_x_7 ;(row)
MOV DX,block_y_7  ;(col)     ;to draw black block of collide
Draw_block_b7:
inc player_points
    mov ah,0ch
    mov al,0h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_7
    cmp ax,block_width
    jng Draw_block_b7

    mov cx,block_x_7
    inc DX
    mov AX,DX
    sub AX,block_y_7
    cmp AX,block_height
    jng Draw_block_b7

;jmp neg_velocity_x
neg_velocity_7:
jmp neg_velocity_y
;---------------------------------------------

;-------------------block8 collision---------
check_b8:
mov ax,ball_x     ;for collision x-axis
add ax,ball_size
cmp ax,block_x_8
jng check_b9

mov ax,block_x_8
add ax ,block_width
cmp ball_x,ax
jnl check_b9

mov ax,ball_y     ;for collision y-axis
add ax,ball_size
cmp ax,block_y_8
jng check_b9

mov ax,block_y_8
add ax,block_height
cmp ball_y,ax
jnl check_b9

cmp next_level_check,1
je Collision_8
jne black8

cmp next_level_check_2,2
je Collision_81
jne black8

Collision_8:
inc collision8
cmp collision8,2
jge black8
jmp  neg_velocity_8

Collision_81:
inc collision81
cmp collision81,3  
jge black8
jmp neg_velocity_8

black8:
MOV CX,block_x_8 ;(row)    ;to draw black block of collide
MOV DX,block_y_8  ;(col)
Draw_block_b8:
inc player_points
    mov ah,0ch
    mov al,0h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_8
    cmp ax,block_width
    jng Draw_block_b8

    mov cx,block_x_8
    inc DX
    mov AX,DX
    sub AX,block_y_8
    cmp AX,block_height
    jng Draw_block_b8

;NEG ball_speed_x
neg_velocity_8:
jmp neg_velocity_y
;---------------------------------------------

;-------------------block9 collision---------
check_b9:
mov ax,ball_x     ;for collision x-axis
add ax,ball_size
cmp ax,block_x_9
jng check_b10

mov ax,block_x_9
add ax ,block_width
cmp ball_x,ax
jnl check_b10

mov ax,ball_y     ;for collision y-axis
add ax,ball_size
cmp ax,block_y_9
jng check_b10

mov ax,block_y_9
add ax,block_height
cmp ball_y,ax
jnl check_b10

cmp next_level_check,1
je Collision_9
jne black9

cmp next_level_check_2,2
je Collision_91
jne black9

Collision_9:
inc collision9
cmp collision9,2
jge black9
jmp neg_velocity_9

Collision_91:
inc collision91
cmp collision91,3  
jge black9
jmp neg_velocity_9

black9:
MOV CX,block_x_9  ;(row)
MOV DX,block_y_9  ;(col)     ;to draw black block of collide
Draw_block_b9:
inc player_points
    mov ah,0ch
    mov al,0h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_9
    cmp ax,block_width
    jng Draw_block_b9

    mov cx,block_x_9
    inc DX
    mov AX,DX
    sub AX,block_y_9
    cmp AX,block_height
    jng Draw_block_b9

;NEG ball_speed_x
neg_velocity_9:
jmp neg_velocity_y
;---------------------------------------------

;-------------------block10 collision---------
check_b10:
mov ax,ball_x     ;for collision x-axis
add ax,ball_size
cmp ax,block_x_10
jng check_b11

mov ax,block_x_10
add ax ,block_width
cmp ball_x,ax
jnl check_b11

mov ax,ball_y     ;for collision y-axis
add ax,ball_size
cmp ax,block_y_10
jng check_b11

mov ax,block_y_10
add ax,block_height
cmp ball_y,ax
jnl check_b11

cmp next_level_check,1
je Collision_10
jne black10
cmp next_level_check_2,2
je Collision_101
jne black10

Collision_10:
inc collision10
cmp collision10,2
jge black10
jmp neg_velocity_10

Collision_101:
inc collision101
cmp collision101,3  
jge black10
jmp neg_velocity_10

black10:
MOV CX,block_x_10  ;(row)
MOV DX,block_y_10 ;(col) ;to draw black block of collide
Draw_block_b10:
inc player_points
    mov ah,0ch
    mov al,0h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_10
    cmp ax,block_width
    jng Draw_block_b10

    mov cx,block_x_10
    inc DX
    mov AX,DX
    sub AX,block_y_10
    cmp AX,block_height
    jng Draw_block_b10

;NEG ball_speed_x
neg_velocity_10:
jmp neg_velocity_y
;---------------------------------------------

;-------------------block11 collision---------
check_b11:
mov ax,ball_x     ;for collision x-axis
add ax,ball_size
cmp ax,block_x_11
jng check_b12

mov ax,block_x_11
add ax ,block_width
cmp ball_x,ax
jnl check_b12

mov ax,ball_y     ;for collision y-axis
add ax,ball_size
cmp ax,block_y_11
jng check_b12

mov ax,block_y_11
add ax,block_height
cmp ball_y,ax
jnl check_b12


cmp next_level_check,1
je Collision_11
jne black11
cmp next_level_check_2,2
je Collision_111
jne black11

Collision_11:
inc collision11
cmp collision11,2
jge black11
jmp neg_velocity_11

Collision_111:
inc collision111
cmp collision111,3  
jge black11
jmp neg_velocity_11

black11:
MOV CX,block_x_11  ;(row)
MOV DX,block_y_11  ;(col)       ;to draw black block of collide
Draw_block_b11:
inc player_points
    mov ah,0ch
    mov al,0h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_11
    cmp ax,block_width
    jng Draw_block_b11

    mov cx,block_x_11
    inc DX
    mov AX,DX
    sub AX,block_y_11
    cmp AX,block_height
    jng Draw_block_b11

;NEG ball_speed_x
neg_velocity_11:
jmp neg_velocity_y
;---------------------------------------------

;-------------------block12 collision---------
check_b12:
mov ax,ball_x     ;for collision x-axis
add ax,ball_size
cmp ax,block_x_12
jng check_collision

mov ax,block_x_12
add ax ,block_width
cmp ball_x,ax
jnl check_collision

mov ax,ball_y     ;for collision y-axis
add ax,ball_size
cmp ax,block_y_12
jng check_collision

mov ax,block_y_12
add ax,block_height
cmp ball_y,ax
jnl check_collision

cmp next_level_check,1 
je Collision_12
jne black12
cmp next_level_check_2,2
je Collision_121
jne black12

Collision_12:
inc collision12
cmp collision12,2
jge black12
jmp neg_velocity_12

Collision_121:
inc collision121
cmp collision121,3  
jge black12
jmp neg_velocity_12

neg_velocity_12:
jmp neg_velocity_y

black12:
MOV CX,block_x_12  ;(row)    ;to draw black block of collide
MOV DX,block_y_12  ;(col)
Draw_block_b12:
inc player_points
    mov ah,0ch
    mov al,0h
    int 10h

    inc CX
    mov ax,cx
    sub ax,block_x_12
    cmp ax,block_width
    jng Draw_block_b12

    mov cx,block_x_12
    inc DX
    mov AX,DX
    sub AX,block_y_12
    cmp AX,block_height
    jng Draw_block_b12


;---------------------------------------------

check_collision:
ret
neg_velocity_x:
neg ball_speed_x
ret

neg_velocity_y:
neg ball_speed_y
ret

reset_position:
call Reset_Position
ret


ret
MoveBall endP     
;--------------------------

;-----MOVE PADDLE FUNCTION--
MovePaddle PROC   

mov ah,01h
int 16h
jz check_movement

mov ah,0
int 16h
cmp ah,4Bh
je move_left

mov ah,0
int 16h
cmp ah,4Dh
je move_right

move_left:
mov ax,paddle_w
add paddle_x,ax

MOV CX,paddle_x    ;(row)
MOV DX,paddle_y    ;(col)

Draw_black_paddle_1:
    mov ah,0ch
    mov al,0h
    int 10h

    inc CX
    mov ax,cx
    sub ax,paddle_x
    cmp ax,paddle_w
    jng Draw_black_paddle_1
                                   ;for drawing
                                   ;black paddle on 
    mov cx,paddle_x                ;right side if move left
    mov cx,paddle_x                
    inc DX
    mov AX,DX
    sub AX,paddle_y
    cmp AX,paddle_h
    jng Draw_black_paddle_1


mov ax,paddle_w
sub paddle_x,ax

mov ax,paddle_left_speed
sub paddle_x,ax                   ;for shifting paddle
jmp check_movement
;cmp paddle_x,06h
;jl 

move_right:
mov ax,paddle_w
sub paddle_x,ax


MOV CX,paddle_x    ;(row)
MOV DX,paddle_y;(col)

Draw_black_paddle_2:
mov ah,0ch
mov al,0h
int 10h                             ;for drawing
                                    ;black paddle
inc cx                              ;on left side if move right
mov ax,cx
sub ax,paddle_x
cmp ax,paddle_w
jng Draw_black_paddle_2

mov cx,paddle_x
inc DX
mov AX,DX
sub AX,paddle_y
cmp AX,paddle_h
jng Draw_black_paddle_2


mov ax,paddle_w
add paddle_x,ax

mov ax,paddle_right_speed
add paddle_x,ax                   ;for shifting paddle
jmp check_movement
;cmp paddle_x,06h


check_movement:
ret

ret
MovePaddle ENDP
;-----------------------------

Clear_screen PROC
mov ah, 0h
mov al, 12h    ;640x480
int 10h
mov ah, 0bh
mov bh, 00h
mov bl, 00h
int 10h

ret
Clear_screen endP

Reset_Position PROC

mov ax,ball_reset_x
mov ball_x,ax

mov ax,ball_reset_y
mov ball_y,ax

dec text_player_lives

ret
Reset_Position ENDP

Display_text1 PROC

mov ah,02h
mov bh,00h
mov dh,01h
mov dl,09h
int 10h
lea dx,text_player_lives
mov ah,09h
int 21h

ret
Display_text1 ENDP

Display_text2 PROC

mov ah,02h
mov bh,00h
mov dh,01h
mov dl,45h
int 10h
lea dx,player_points
mov ah,09h
int 21h

ret
Display_text2 ENDP

SecondLevel PROC

lea dx,str1
mov ah,09h
int 21h

mov ah,0
int 16h
cmp al,'n'
je next_level
jne return1


next_level:
call Block1
call Block2
call Block3
call Block4
call Block5
call Block6
call Block7
call Block8
call Block9
call Block10
call Block11
call Block12
call Delay2

return1:
ret
SecondLevel ENDP

ThirdLevel PROC
lea dx,str2
mov ah,09h
int 21h

mov ah,0
int 16h
cmp al,'n'
je next_level
jne return2


next_level:
call Block1
call Block2
call Block3
call Block4
call Block5
call Block6
call Block7
call Block8
call Block9
call Block10
call Block11
call Block12
call Delay3

return2:
ret
ThirdLevel ENDP

Delay PROC 
    checktime:

    mov ah,2ch 
    int 21h

    cmp dl,time
    je checktime

    mov time,dl
    ;call Clear_screen
    call DrawBall
    call MoveBall
    call DrawPaddle
    call MovePaddle
    call Display_text1
    call Display_text2
    ;call Display_text3

    inc waisehi
    cmp waisehi,200
    je clear 

    jmp checktime

clear:
call Clear_screen
call SecondLevel

return:
ret

Delay endP

Delay2 PROC 

sub paddle_w,5
add ball_speed_x,1
add ball_speed_y,1
inc next_level_check
    checktime:
    mov ah,2ch 
    int 21h

    cmp dl,time
    je checktime

    mov time,dl
    ;call Clear_screen
    call DrawBall
    call MoveBall
    call DrawPaddle
    call MovePaddle

     inc waisehi
     cmp waisehi,200
     je clear 

    jmp checktime

clear:
call Clear_screen
call ThirdLevel 

return:
ret

Delay2 endP

Delay3 PROC 

sub paddle_w,7
add ball_speed_x,2
add ball_speed_y,2
inc next_level_check_2

    checktime:
    mov ah,2ch 
    int 21h

    cmp dl,time
    je checktime

    mov time,dl
    ;call Clear_screen
    call DrawBall
    call MoveBall
    call DrawPaddle
    call MovePaddle

    ; inc waisehi
    ; cmp waisehi,200
    ; je clear 

    jmp checktime

clear:
call Clear_screen

return:
ret

Delay3 endP
end