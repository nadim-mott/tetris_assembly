.data
displayaddress: .word 0x10008000

# . . .
.text
# . . .

lw $t0, displayaddress  # $t0 = base address for display
li $t4, 0x00ff00        # $t4 = green
li $t8, 0xff0000        # $t8 = red
li $t9, 0x0000ff        # $t9 = blue
li $s1, 1               # $t7 = 0 iff we don't want checkers
# Bottom
addi $a0, $zero, 5      # set x coordinate of line to 2
addi $a1, $zero, 27      # set x coordinate of line to 2
addi $a2, $zero, 12      # set length of line to 8
addi $a3, $zero, 1      # set length of line to 8
jal draw_rectangle        # call the rectangle-drawing function

# Left line
addi $a0, $zero, 5      # set x coordinate of line to 2
addi $a1, $zero, 5      # set x coordinate of line to 2
addi $a2, $zero, 1      # set length of line to 8
addi $a3, $zero, 22      # set length of line to 8
jal draw_rectangle        # call the rectangle-drawing function

# Right
addi $a0, $zero, 16      # set x coordinate of line to 2
addi $a1, $zero, 5      # set x coordinate of line to 2
addi $a2, $zero, 1      # set length of line to 8
addi $a3, $zero, 22      # set length of line to 8
jal draw_rectangle        # call the rectangle-drawing function




# The code for drawing a horizontal line
# - $a0: the x coordinate of the starting point for this line.
# - $a1: the y coordinate of the starting point for this line.
# - $a2: the length of this line, measured in pixels
# - $a3: the height of this line, measured in pixels
# - $t0: the address of the first pixel (top left) in the bitmap
# - $t1: the horizontal offset of the first pixel in the line.
# - $t2: the vertical offset of the first pixel in the line.
# - #t3: the location in bitmap memory of the current pixel to draw 
# - $t4: the colour value to draw on the bitmap
# - $t5: the bitmap location for the end of the horizontal line.
# - $t7: stores whether the coordinate is odd or even
draw_rectangle:
sll $t2, $a1, 7         # convert vertical offset to pixels (by multiplying $a1 by 128)
sll $t6, $a3, 7         # convert height of rectangle from pixels to rows of bytes (by multiplying $a3 by 128)
add $t6, $t2, $t6       # calculate value of $t2 for the last line in the rectangle.
addi $t7, $zero, 0
outer_top:
sll $t1, $a0, 2         # convert horizontal offset to pixels (by multiplying $a0 by 4)
sll $t5, $a2, 2         # convert length of line from pixels to bytes (by multiplying $a2 by 4)
add $t5, $t1, $t5       # calculate value of $t1 for end of the horizontal line.

inner_top:
add $t3, $t1, $t2           # store the total offset of the starting pixel (relative to $t0)
add $t3, $t0, $t3           # calculate the location of the starting pixel ($t0 + offset)
bgtz $s1, checkers
notcheckers:
sw $t4, 0($t3)              # paint the current unit on the first row yellow
j colorsetcomplete
checkers:
sw $t8, 0($t3)              # paint the current unit on the first row yellow
j colorsetcomplete
beq $t7, $zero, caseblue
casered:
sw $t8, 0($t3)
addi $t7 $zero 0
j endcases
caseblue:
sw $t9, 0($t3)
addi $t7 $zero 1
endcases:

colorsetcomplete:
addi $t1, $t1, 4            # move horizontal offset to the right by one pixel
beq $t1, $t5, inner_end     # break out of the line-drawing loop
j inner_top                 # jump to the start of the inner loop
inner_end:

addi $t2, $t2, 128          # move vertical offset down by one line
beq $t2, $t6, outer_end     # on last line, break out of the outer loop
j outer_top                 # jump to the top of the outer loop
outer_end:

jr $ra                      # return to calling program