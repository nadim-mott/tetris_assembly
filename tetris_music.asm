##############################################################################
# Tetris Music
#
# This file demonstrates how to play the Tetris theme music in MIPS assembly.
##############################################################################

    .data
# Define note frequencies
note_C4: .word 261
note_D4: .word 293
note_E4: .word 329
note_F4: .word 349
note_G4: .word 392
note_A4: .word 440
note_B4: .word 493
note_C5: .word 523
note_E5: .word 659
note_G5: .word 784

# Define note durations (in milliseconds)
duration_quarter: .word 500
duration_eighth: .word 250

    .text
    .globl main

main:
    # Play Tetris theme music
    jal play_tetris_theme
    # End of program
    li $v0, 10
    syscall
    

# Function to play Tetris theme music
play_tetris_theme:
    # Play the first segment of the Tetris theme
    jal play_note_C4_eighth
    jal play_note_E4_eighth
    jal play_note_G4_eighth
    jal play_note_B4_quarter
    jal play_note_A4_eighth
    jal play_note_G4_eighth
    jal play_note_E4_quarter
    jal play_note_G4_eighth
    jal play_note_F4_eighth
    jal play_note_E4_quarter
    jal play_note_C4_eighth
    jal play_note_E4_eighth
    jal play_note_G4_eighth
    jal play_note_A4_quarter
    jal play_note_F4_eighth
    jal play_note_G4_eighth
    jal play_note_E4_quarter

    # Play the second segment of the Tetris theme
    jal play_note_C5_eighth
    jal play_note_G4_eighth
    jal play_note_F4_eighth
    jal play_note_E4_eighth
    jal play_note_D4_quarter
    jal play_note_E4_eighth
    jal play_note_C5_eighth
    jal play_note_A4_eighth
    jal play_note_G4_quarter
    jal play_note_F4_eighth
    jal play_note_E4_eighth
    jal play_note_C5_eighth
    jal play_note_E5_quarter

    jr $ra

# Function to play a note C4 (Middle C) with an eighth note duration
play_note_C4_eighth:
    lw $a0, note_C4
    lw $a1, duration_eighth
    jal play_note
    jr $ra

# Function to play a note D4 with an eighth note duration
play_note_D4_eighth:
    lw $a0, note_D4
    lw $a1, duration_eighth
    jal play_note
    jr $ra

# Function to play a note E4 with an eighth note duration
play_note_E4_eighth:
    lw $a0, note_E4
    lw $a1, duration_eighth
    jal play_note
    jr $ra

# Function to play a note F4 with an eighth note duration
play_note_F4_eighth:
    lw $a0, note_F4
    lw $a1, duration_eighth
    jal play_note
    jr $ra

# Function to play a note G4 with an eighth note duration
play_note_G4_eighth:
    lw $a0, note_G4
    lw $a1, duration_eighth
    jal play_note
    jr $ra

# Function to play a note A4 with an eighth note duration
play_note_A4_eighth:
    lw $a0, note_A4
    lw $a1, duration_eighth
    jal play_note
    jr $ra

# Function to play a note B4 with an eighth note duration
play_note_B4_eighth:
    lw $a0, note_B4
    lw $a1, duration_eighth
    jal play_note
    jr $ra

# Function to play a note C5 with an eighth note duration
play_note_C5_eighth:
    lw $a0, note_C5
    lw $a1, duration_eighth
    jal play_note
    jr $ra

# Function to play a note E5 with an eighth note duration
play_note_E5_eighth:
    lw $a0, note_E5
    lw $a1, duration_eighth
    jal play_note
    jr $ra

# Function to play a note G5 with an eighth note duration
play_note_G5_eighth:
    lw $a0, note_G5
    lw $a1, duration_eighth
    jal play_note
    jr $ra

# Function to play a note B4 with a quarter note duration
play_note_B4_quarter:
    lw $a0, note_B4
    lw $a1, duration_quarter
    jal play_note
    jr $ra

# Function to play a note E4 with a quarter note duration
play_note_E4_quarter:
    lw $a0, note_E4
    lw $a1, duration_quarter
    jal play_note
    jr $ra

# Function to play a note A4 with a quarter note duration
play_note_A4_quarter:
    lw $a0, note_A4
    lw $a1, duration_quarter
    jal play_note
    jr $ra

# Function to play a note D4 with a quarter note duration
play_note_D4_quarter:
    lw $a0, note_D4
    lw $a1, duration_quarter
    jal play_note
    jr $ra

# Function to play a note G4 with a quarter note duration
play_note_G4_quarter:
    lw $a0, note_G4
    lw $a1, duration_quarter
    jal play_note
    jr $ra

# Function to play a note E5 with a quarter note duration
play_note_E5_quarter:
    lw $a0, note_E5
    lw $a1, duration_quarter
    jal play_note
    jr $ra


# Function to play a note with a given frequency and duration
# Inputs:
# $a0 - note frequency
# $a1 - note duration (in milliseconds)
play_note:
    # Calculate number of cycles for the delay
    mul $t0, $a1, 10000   # Convert milliseconds to microseconds
    li $v0, 32            # Load system call code for delay
    syscall               # Execute delay

    # Play the note by generating a square wave
    li $v0, 32            # Load system call code for tone generation
    syscall               # Generate tone
    jr $ra                # Return
