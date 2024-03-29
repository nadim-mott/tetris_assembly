##############################################################################
# Example: Tetris Music
#
# This file demonstrates how to play the Tetris theme music in MIPS assembly.
##############################################################################
.data
counter: .word 10  # Counter initialized to 10

.text
main:
    # Load counter into $t0
    lw $t0, counter
    
    # Call the loop function
    jal loop
    
end_program:
    # Exit the program
    li $v0, 10         # Load immediate value 10 into register $v0 (syscall code for exit)
    syscall            # Perform the exit syscall
    
loop:
    # Play Tetris theme music
    jal play_note_C4_eighth
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_D4_quarter
    jal play_note_E4_eighth
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_F4_eighth
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_E4_eighth
    jal play_note_D4_quarter
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_G4_eighth
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_G4_quarter
    jal play_note_E4_quarter
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_C4_eighth
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_F4_eighth
    jal play_note_G4_quarter
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_D4_eighth
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_D4_quarter
    jal play_note_E4_quarter
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_F4_eighth
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_A4_eighth
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_F4_eighth 
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_A4_eighth
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_E4_eighth
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_B4_eighth
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_C5_eighth
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_B4_eighth
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_C5_eighth
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_E5_eighth
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_C4_eighth
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_A4_eighth
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_E4_eighth
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_B4_eighth
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_C5_eighth
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    jal play_note_B4_quarter
    jal play_note_A4_quarter
    jal play_note_G4_quarter
    jal play_note_F4_quarter
    jal pause_quarter  # Pause
    jal pause_quarter
    jal pause_quarter
    
    # Decrement counter
    addi $t0, $t0, -1

    # Check if counter is not zero
    bnez $t0, loop
    
    
# 21 IS LOWEST FREQUENCY, 86 IS HIGHEST FREQUENCY

# Function to play a note C4 (Middle C) with an eighth note duration
play_note_C4_eighth:
    li  $v0, 33                     # Load immediate value 33 into register $v0 (syscall code for playing sound)
    addi $a0, $zero, 23           # Add immediate: set $a0 to the frequency of the sound
    addi $a1, $zero, 100            # Add immediate: set $a1 to the volume of the sound (100)
    addi $a2, $zero, 121            # Add immediate: set $a2 to the wave type of the sound (121)
    addi $a3, $zero, 250            # sound duration--duration eighth
    syscall                         # Perform the system call to play the sound
    jr $ra                          # Jump back to the calling routine (likely the end of a function)

# Function to play a note D4 with an eighth note duration
play_note_D4_eighth:
    li  $v0, 33                     # Load immediate value 33 into register $v0 (syscall code for playing sound)
    addi $a0, $zero, 26           # Add immediate:
    addi $a1, $zero, 100
    addi $a2, $zero, 121 
    addi $a3, $zero, 250            # sound duration--duration eighth
    syscall                         # Perform the system call to play the sound
    jr $ra  

# Function to play a note E4 with an eighth note duration
play_note_E4_eighth:
    li  $v0, 33                     # Load immediate value 33 into register $v0 (syscall code for playing sound)
    addi $a0, $zero, 50           # Add immediate:
    addi $a1, $zero, 100
    addi $a2, $zero, 121 
    addi $a3, $zero, 250            # sound duration--duration eighth
    syscall                         # Perform the system call to play the sound
    jr $ra 

# Function to play a note F4 with an quarter note duration
play_note_F4_quarter:
    li  $v0, 33                     # Load immediate value 33 into register $v0 (syscall code for playing sound)
    addi $a0, $zero, 36            # Change
    addi $a1, $zero, 100
    addi $a2, $zero, 121 
    addi $a3, $zero, 500            # sound duration--duration eighth
    syscall                         # Perform the system call to play the sound
    jr $ra 

# Function to play a note F4 with an eighth note duration
play_note_F4_eighth:
    li  $v0, 33                     # Load immediate value 33 into register $v0 (syscall code for playing sound)
    addi $a0, $zero, 36            # Change
    addi $a1, $zero, 100
    addi $a2, $zero, 121 
    addi $a3, $zero, 250            # sound duration--duration eighth
    syscall                         # Perform the system call to play the sound
    jr $ra 

# Function to play a note G4 with an eighth note duration
play_note_G4_eighth:
    li  $v0, 33                     # Load immediate value 33 into register $v0 (syscall code for playing sound)
    addi $a0, $zero, 42            # Change
    addi $a1, $zero, 100
    addi $a2, $zero, 121 
    addi $a3, $zero, 250            # sound duration--duration eighth
    syscall                         # Perform the system call to play the sound
    jr $ra 

# Function to play a note A4 with an eighth note duration
play_note_A4_eighth:
    li  $v0, 33                     # Load immediate value 33 into register $v0 (syscall code for playing sound)
    addi $a0, $zero, 50            # Change
    addi $a1, $zero, 100
    addi $a2, $zero, 121 
    addi $a3, $zero, 250            # sound duration--duration eighth
    syscall                         # Perform the system call to play the sound
    jr $ra 

# Function to play a note B4 with an eighth note duration
play_note_B4_eighth:
    li  $v0, 33                     # Load immediate value 33 into register $v0 (syscall code for playing sound)
    addi $a0, $zero, 58            # Change
    addi $a1, $zero, 100
    addi $a2, $zero, 121 
    addi $a3, $zero, 250            # sound duration--duration eighth
    syscall                         # Perform the system call to play the sound
    jr $ra 

# Function to play a note C5 with an eighth note duration
play_note_C5_eighth:
    li  $v0, 33                     # Load immediate value 33 into register $v0 (syscall code for playing sound)
    addi $a0, $zero, 63            # Change
    addi $a1, $zero, 100
    addi $a2, $zero, 121 
    addi $a3, $zero, 250            # sound duration--duration eighth
    syscall                         # Perform the system call to play the sound
    jr $ra 

# Function to play a note E5 with an eighth note duration
play_note_E5_eighth:
    li  $v0, 33                     # Load immediate value 33 into register $v0 (syscall code for playing sound)
    addi $a0, $zero, 85            # Change
    addi $a1, $zero, 100
    addi $a2, $zero, 121 
    addi $a3, $zero, 250            # sound duration--duration eighth
    syscall                         # Perform the system call to play the sound
    jr $ra 

# Function to play a note G5 with an eighth note duration
play_note_G5_eighth:
    li  $v0, 33                     # Load immediate value 33 into register $v0 (syscall code for playing sound)
    addi $a0, $zero, 66            # Change
    addi $a1, $zero, 100
    addi $a2, $zero, 121 
    addi $a3, $zero, 250            # sound duration--duration eighth
    syscall                         # Perform the system call to play the sound
    jr $ra 

# Function to play a note B4 with a quarter note duration
play_note_B4_quarter:
    li  $v0, 33                     # Load immediate value 33 into register $v0 (syscall code for playing sound)
    addi $a0, $zero, 58           # Change
    addi $a1, $zero, 100
    addi $a2, $zero, 121 
    addi $a3, $zero, 500            # sound duration--duration eighth
    syscall                         # Perform the system call to play the sound
    jr $ra 

# Function to play a note E4 with a quarter note duration
play_note_E4_quarter:
    li  $v0, 33                     # Load immediate value 33 into register $v0 (syscall code for playing sound)
    addi $a0, $zero, 50           # Change
    addi $a1, $zero, 100
    addi $a2, $zero, 121 
    addi $a3, $zero, 500            # sound duration--duration eighth
    syscall                         # Perform the system call to play the sound
    jr $ra 

# Function to play a note A4 with a quarter note duration
play_note_A4_quarter:
    li  $v0, 33                     # Load immediate value 33 into register $v0 (syscall code for playing sound)
    addi $a0, $zero, 50           # Change
    addi $a1, $zero, 100
    addi $a2, $zero, 121 
    addi $a3, $zero, 500            # sound duration--duration eighth
    syscall                         # Perform the system call to play the sound
    jr $ra 

# Function to play a note D4 with a quarter note duration
play_note_D4_quarter:
    li  $v0, 33                     # Load immediate value 33 into register $v0 (syscall code for playing sound)
    addi $a0, $zero, 26          # Change
    addi $a1, $zero, 100
    addi $a2, $zero, 121 
    addi $a3, $zero, 500            # sound duration--duration eighth
    syscall                         # Perform the system call to play the sound
    jr $ra 

# Function to play a note G4 with a quarter note duration
play_note_G4_quarter:
    li  $v0, 33                     # Load immediate value 33 into register $v0 (syscall code for playing sound)
    addi $a0, $zero, 42          # Change
    addi $a1, $zero, 100
    addi $a2, $zero, 121 
    addi $a3, $zero, 500            # sound duration--duration eighth
    syscall                         # Perform the system call to play the sound
    jr $ra 

# Function to play a note E5 with a quarter note duration
play_note_E5_quarter:
    li  $v0, 33                     # Load immediate value 33 into register $v0 (syscall code for playing sound)
    addi $a0, $zero, 85          # Change
    addi $a1, $zero, 100
    addi $a2, $zero, 121 
    addi $a3, $zero, 500            # sound duration--duration eighth
    syscall                         # Perform the system call to play the sound
    jr $ra 



# Function to pause for an eighth note duration
pause_eighth:
    li  $v0, 33         # Load immediate value 33 into register $v0 (syscall code for playing sound)
    addi $a0, $zero, 0  # Set $a0 to 0 (no sound)
    addi $a1, $zero, 0  # Set $a1 to 0 (volume)
    addi $a2, $zero, 0  # Set $a2 to 0 (wave type)
    addi $a3, $zero, 250  # Set $a3 to the duration of an eighth note
    syscall             # Perform the system call to pause
    jr $ra              # Jump back to the calling routine (likely the end of a function)

# Function to pause for a quarter note duration
pause_quarter:
    li  $v0, 33         # Load immediate value 33 into register $v0 (syscall code for playing sound)
    addi $a0, $zero, 0  # Set $a0 to 0 (no sound)
    addi $a1, $zero, 0  # Set $a1 to 0 (volume)
    addi $a2, $zero, 0  # Set $a2 to 0 (wave type)
    addi $a3, $zero, 500  # Set $a3 to the duration of a quarter note
    syscall             # Perform the system call to pause
    jr $ra              # Jump back to the calling routine (likely the end of a function)