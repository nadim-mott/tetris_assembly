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
i_bit_map: .byte '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '0', '1'
s_bit_map: .byte '0', '0', '0', '0', '0', '1', '1', '0', '1', '1', '0', '0', '0', '0', '0', '0'
z_bit_map: .byte '0', '0', '0', '0', '0', '0', '1', '1', '0', '0', '1', '1', '0', '0', '0', '0'
l_bit_map: .byte '0', '0', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '0', '1', '1', '0'
j_bit_map: .byte '0', '0', '0', '0', '0', '0', '1', '0', '0', '0', '1', '0', '0', '1', '1', '0'
t_bit_map: .byte '0', '0', '0', '0', '0', '1', '1', '1', '0', '0', '1', '0', '0', '0', '0', '0'

##############################################################################
# Code
##############################################################################
	.text
	.globl main

	# Run the Tetris game.
main:

    draw_grid:
        # Initialize the game
        lw $t0, ADDR_DSPL  # $t0 = base address for display
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
    # 1b. Check which key has been pressed
    # 2a. Check for collisions
	# 2b. Update locations (paddle, ball)
	# 3. Draw the screen
	# 4. Sleep

    #5. Go back to 1
    li $v0, 32
    li $a0, 1000
    syscall
    b game_loop


j function_end
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
        
    draw_new_block:
    # - $t0 display address
    # - $a0 code for the block that will be drawn
    # - $a1 x_coordinate
    # - $a2 y_coordinate
    # - $a3 rotation
    # - $t2 color of tetromino
        case_draw_i:
            la $1 i_bit_map
            lw $t2 c_teal
            j begin_drawing_block
        
        begin_drawing_block:
           sll $t3, $a2, 7
           
           
        
    
    
    
        
        
function_end:

