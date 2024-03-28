################ CSC258H1F Winter 2024 Assembly Final Project ##################
# This file contains our implementation of Tetris.
#
# Student 1: Narges Movahedian Nezhad, 1009080600
# Student 2: Nadim Mottu, 1008933095
######################## Bitmap Display Configuration ########################
# - Unit width in pixels:       2
# - Unit height in pixels:      2
# - Display width in pixels:    64
# - Display height in pixels:   64
# - Base Address for Display:   0x10008000 ($gp)
##############################################################################

    .data
##############################################################################
# Immutable Data
##############################################################################
ADDR_DSPL: .word 0x10008000 # The address of the bitmap display. Don't forget to connect it!
ADDR_KBRD: .word 0xffff0000 # The address of the keyboard. Don't forget to connect it!


##############################################################################
# Mutable Data
##############################################################################
# Bitmap Constants:
display_width: .word 64
display_height: .word 64
unit_width: .word 2
unit_height: .word 2


# Grid Constants:
grid_x: .word 5
grid_y: .word 5
grid_width: .word 12
grid_height: .word 22
grid_address: .space 4096


# Color Constants:
c_white: .word 0xffffff
c_grey1: .word 0x161616
c_grey2: .word 0x010101
c_yellow: .word 0xffff00
c_teal: .word 0x00ffff
c_red: .word 0xff0000
c_green: .word 0x00ff00
c_orange: .word 0xff4000
c_pink: .word 0xff00ff
c_purple: .word 0x9100ff

# Tetromino_maps:
o_bit_map: .byte '0', '0', '0', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '0', '0', '0'
i_bit_map: .byte '0', '0', '1', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '0', '1', '0'
s_bit_map: .byte '0', '0', '0', '0', '0', '1', '1', '0', '1', '1', '0', '0', '0', '0', '0', '0'
z_bit_map: .byte '0', '0', '0', '0', '0', '1', '1', '0', '0', '0', '1', '1', '0', '0', '0', '0'
l_bit_map: .byte '0', '0', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '0', '1', '1', '0'
j_bit_map: .byte '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '1', '1', '0'
t_bit_map: .byte '0', '0', '0', '0', '0', '1', '1', '1', '0', '0', '1', '0', '0', '0', '0', '0'

# Player controls:
block_start_x: .word 8
block_start_y: .word 5
curr_block_x: .word 9
curr_block_y: .word 5
curr_block_type: .byte 0
curr_block_rotation: .byte 0


##############################################################################
# Code
##############################################################################
	.text
	.globl main

	# Run the Tetris game.
main:
    # Initialize the game
    la $t0, grid_address  # $t0 = base address for display
    lw $t4, c_white        # $t4 = white
    lw $t8, c_white        # $t8 = white  
    
    # Bottom
    lw $a0, grid_x  # set x coordinate
    lw $t1, grid_y # store grid_y in t1
    lw $t2, grid_height
    add $a1, $t1, $t2 # set y coordinate    
    lw $a2, grid_width      # set length of line
    li $a3, 1      # set height of line
    jal draw_rectangle        # call the rectangle-drawing function
    
    # Inside of grid:
    lw $t8, c_grey1        # $t8 = grey1
    lw $t4, c_grey2        # $t4 = grey2
    lw $a0, grid_x
    addi $a0, $a0, 1      # set x coordinate
    lw $a1, grid_y      # set y coordinate
    lw $a2, grid_width      # set width of line
    subi $a2, $a2, 1
    lw $a3, grid_height      # set height of line
    jal draw_rectangle        # call the rectangle-drawing function
    li $s1, 0
    
    lw $t4, c_white        # $t4 = white
    lw $t8, c_white        # $t8 = white  
    # Left line
    lw $a0, grid_x      # set x coordinate
    lw $a1, grid_y      # set y coordinate
    li $a2, 1      # set length of line to 8
    lw $a3, grid_height      # set height of line
    jal draw_rectangle        # call the rectangle-drawing function
    
    # Right
    
    lw $a0, grid_x      # set x coordinate
    lw $t1, grid_width
    add $a0, $a0, $t1
    subi $a0, $a0, 1
    lw $a1, grid_y      # set y coordinate
    li $a2, 1     # set length of line
    lw $a3, grid_height      # set height of line 
    jal draw_rectangle        # call the rectangle-drawing function   

game_loop:
	# 1a. Check if key has been pressed
	lw $t0, ADDR_KBRD               # $t0 = base address for keyboard
    lw $t8, 0($t0)                  # Load first word from keyboard
    bne $t8, 1, no_keyboard_input      # If first word 1, key is pressed
    # 1b. Check which key has been pressed
    jal respond_to_keyboard_input
    
    no_keyboard_input:
    
    # 2a. Check for collisions
	# 2b. Update locations (paddle, ball)
	# 3. Draw the screen
	lw $a0 ADDR_DSPL
	la $a1 grid_address
	jal draw_grid
	
	
	# Draw Block
	lw $t0 ADDR_DSPL
	lb $a0 curr_block_type
	lw $a1 curr_block_x
	lw $a2 curr_block_y
	lb $a3 curr_block_rotation
	jal draw_new_block
	
	# 4. Sleep
    li $v0, 32
    li $a0, 1
    syscall
    #5. Go back to 1
   
    j game_loop


j function_end
    respond_to_keyboard_input:
    # - $t0: address of keyboard
    # - $t1: key_pressed
        lw $t0, ADDR_KBRD               # $t0 = base address for keyboard
        lw $t1, 4($t0)                  # Load second word from keyboard
        beq $t1, 0x61, respond_to_A
        beq $t1, 0x77, respond_to_W
        beq $t1, 0x73, respond_to_S
        beq $t1, 0x64, respond_to_D
        j end_respond_to_keyboard
        
        respond_to_A:
            lw $t2, curr_block_x
            addi $t2, $t2, -1
            sw $t2, curr_block_x
            j end_respond_to_keyboard
        respond_to_W:
            lb $t2, curr_block_rotation
            addi $t2, $t2, 1
            bne $t2, 4, update_rotation
            li $t2, 0
            update_rotation:
            sb $t2, curr_block_rotation
            j end_respond_to_keyboard
        respond_to_D:
            lw $t2, curr_block_x
            addi $t2, $t2, 1
            sw $t2, curr_block_x
            j end_respond_to_keyboard
        respond_to_S:
            lw $t2, curr_block_y
            addi $t2, $t2, 1
            sw $t2, curr_block_y
            j end_respond_to_keyboard
    end_respond_to_keyboard:
    jr $ra
    
    
    draw_rectangle:
    # The code for drawing a rectangle
    # - $a0: the x coordinate of the starting point for this line.
    # - $a1: the y coordinate of the starting point for this line.
    # - $a2: the length of this line, measured in pixels
    # - $a3: the height of this line, measured in pixels
    # - $t0: the address of the first pixel (top left)
    # - $t1: the horizontal offset of the first pixel in the line.
    # - $t2: the vertical offset of the first pixel in the line.
    # - #t3: the location in bitmap memory of the current pixel to draw 
    # - $t4: the colour value to draw on the bitmap
    # - $t5: the bitmap location for the end of the horizontal line.
    # - $t7: stores whether the coordinate is odd or even
    # - $t8: colour value 2
    sll $t2, $a1, 7         # convert vertical offset to pixels (by multiplying $a1 by 128)
    sll $t6, $a3, 7         # convert height of rectangle from pixels to rows of bytes (by multiplying $a3 by 128)
    add $t6, $t2, $t6       # calculate value of $t2 for the last line in the rectangle.
    addi $t7, $zero, 0
        draw_rectangle_outer_top:
        sll $t1, $a0, 2         # convert horizontal offset to pixels (by multiplying $a0 by 4)
        sll $t5, $a2, 2         # convert length of line from pixels to bytes (by multiplying $a2 by 4)
        add $t5, $t1, $t5       # calculate value of $t1 for end of the horizontal line.
            draw_rectangle_inner_top:
            add $t3, $t1, $t2           # store the total offset of the starting pixel (relative to $t0)
            add $t3, $t0, $t3           # calculate the location of the starting pixel ($t0 + offset)
            beq $t7, $zero, caseblue
            casered:
            sw $t8, 0($t3)
            addi $t7 $zero 0
            j draw_rectangle_endcases
            caseblue:
            sw $t4, 0($t3)
            addi $t7 $zero 1
            draw_rectangle_endcases:
            j colorsetcomplete
            colorsetcomplete:
            addi $t1, $t1, 4            # move horizontal offset to the right by one pixel
            beq $t1, $t5, draw_rectangle_inner_end     # break out of the line-drawing loop
            j draw_rectangle_inner_top                 # jump to the start of the inner loop
            draw_rectangle_inner_end:
        addi $t2, $t2, 128          # move vertical offset down by one line
        beq $t2, $t6, draw_rectangle_outer_end     # on last line, break out of the outer loop
        j draw_rectangle_outer_top                 # jump to the top of the outer loop
        draw_rectangle_outer_end:
        jr $ra
    
    draw_grid:
    # - $a0 starting display address
    # - $a1 starting memory address
    # - $t0 current display address
    # - $t1 current address in memory
    # - $t2 current value in memory
    # - $t3 final location in memory
    
    add $t0, $zero, $a0
    add $t1, $zero, $a1
    addi $t3, $a1, 4096
        draw_grid_loop_top:
            lw $t2, 0($t1)
            sw $t2, 0($t0)
            beq $t1, $t3, draw_grid_end_loop
            addi $t0, $t0, 4
            addi $t1, $t1, 4
            j draw_grid_loop_top
        draw_grid_end_loop:
    jr $ra
    
    
    
    
    draw_new_block:
    # - $t0 display address
    # - $a0 code for the block that will be drawn
    # - $a1 x_coordinate
    # - $a2 y_coordinate
    # - $a3 rotation
    # - $t1 current position in block array
    # - $t2 color of tetromino
    # - $t3 current position in bitmap
    # - $t5 range from 1 to 16
    # - $t6 row complete change
    # - $t7 column complete change
        beq $a0 0 case_draw_o
        beq $a0 1 case_draw_i
        beq $a0 2 case_draw_s
        beq $a0 3 case_draw_z
        beq $a0 4 case_draw_l
        beq $a0 5 case_draw_j
        beq $a0 6 case_draw_t
        
        case_draw_o:
            la $t1 o_bit_map
            lw $t2 c_yellow
            j decide_rotation_case
        case_draw_i:
            la $t1 i_bit_map
            lw $t2 c_teal
            j decide_rotation_case
        case_draw_s:
            la $t1 s_bit_map
            lw $t2 c_red
            j decide_rotation_case 
        case_draw_z:
            la $t1 z_bit_map
            lw $t2 c_green
            j decide_rotation_case 
        case_draw_l:
            la $t1 l_bit_map
            lw $t2 c_orange
            j decide_rotation_case 
        case_draw_j:
            la $t1 j_bit_map
            lw $t2 c_pink
            j decide_rotation_case
        case_draw_t:
            la $t1 t_bit_map
            lw $t2 c_purple
            j decide_rotation_case 
        
        decide_rotation_case:
            beq $a3 0 case_rotation_0
            beq $a3 1 case_rotation_1
            beq $a3 2 case_rotation_2
            beq $a3 3 case_rotation_3
        case_rotation_0:
            li $t6 1
            li $t7 0
            j begin_drawing_block
        case_rotation_1:
            addi $t1, $t1, 3
            li $t6 4
            li $t7 -17
            j begin_drawing_block
        case_rotation_2:
            addi $t1, $t1, 15
            li $t6 -1
            li $t7 0
            j begin_drawing_block
        case_rotation_3:
            addi $t1, $t1, 12
            li $t6 -4
            li $t7 17
            j begin_drawing_block
        
        
        begin_drawing_block:
            lw $t0, ADDR_DSPL
            li $t5 0
            sll $t3, $a2, 7
            sll $t4, $a1, 2
            add $t3, $t4, $t3
            add $t3, $t0, $t3
            # t4 is free
            draw_block_outer_loop:
                draw_block_draw_row:
                lb $t4, 0($t1)
                li $t8, '0'
                beq $t4, $t8, draw_block_draw_row_update_vals
                sw $t2, 0($t3)
                draw_block_draw_row_update_vals:
                add $t1, $t1, $t6
                addi $t3, $t3, 4
                addi $t5, $t5 1
                
                # Check if $t5 is divisible by 4
                li $t8, 4
                div $t4, $t5, $t8
                mfhi $t4
                bne $t4, $zero draw_block_outer_loop
            addi $t3, $t3, 112
            add $t1, $t1, $t7
            li $t4, 16
            bne $t5, $t4, draw_block_outer_loop
        jr $ra
        
        
    place_meeting:
    # - $a0 x coordinate
    # - $a1 y coordinate
    # - $t0 minimum x
    # - $t1 maximum x
    # - $t2 maximum y
    lw $t0, grid_x
    addi $t0, $t0, 1
    lw $t1, grid_width
    add $t1, $t1, $t0
    lw $t2, grid_y
    lw $t3, grid_height
    add $t2, $t2, $t3
    sub $t0, $t0, $a0
    sub $t1, $t1, $a0
    sub $t2, $t2, $a1
    subi $t1, $t1, 2
    blez $t0, place_meeting_condition1
    li $v0 1
    jr $ra 
    place_meeting_condition1:
    bgtz $t1, place_meeting_condition2
    li $v0 1
    jr $ra 
    place_meeting_condition2:
    bgtz $t2, place_meeting_condition3
    li $v0 1
    jr $ra 
    place_meeting_condition3:
    li $v0 0
    jr $ra  
        
    
    
    
        
        
function_end:

