#Name: Ivan Li/ Gabe Alonso
#Section: 1
#Description: Reversing the bit representation of an integer

# Java Code
#public static void reverse(int num){
#        int mask = 0x80000000;
#        int bitCheck = 1;
#        int result = 0;
#        for (int i = 0; i < 32; i++ ){
#            if ((bitCheck & num) > 0){
#                result += mask;
#            }
#            bitCheck = bitCheck << 1;
#            mask = mask >>> 1;
#        }
#        System.out.println(Integer.toBinaryString(result));
#    }


# declare global so programmer can see actual addresses.
.globl welcome
.globl prompt
.globl sumText

#  Data Area (this area contains strings to be displayed during the program)
.data

welcome:
	.asciiz " This program adds reverses the bit representation of an integer \n\n"

prompt:
	.asciiz " Enter an integer: "

sumText: 
	.asciiz " \n Reversed = "

#Text Area (i.e. instructions)
.text

main:

	# Display the welcome message (load 4 into $v0 to display)
	ori     $v0, $0, 4			

	# This generates the starting address for the welcome message.
	# (assumes the register first contains 0).
	lui     $a0, 0x1001
	syscall

	# Display prompt
	ori     $v0, $0, 4			
	
	# This is the starting address of the prompt (notice the
	# different address from the welcome message)
	lui     $a0, 0x1001
	ori     $a0, $a0,0x44
	syscall

	# Read 1st integer from the user (5 is loaded into $v0, then a syscall)
	ori     $v0, $0, 5
	syscall

	# Clear $s0 for the sum
	ori     $s0, $0, 0	

	# Add 1st integer to sum 
	# (could have put 1st integer into $s0 and skipped clearing it above)
	addu    $s0, $v0, $s0

	# Zero result register
	ori     $s1, $0, 0

	# Create counter for loop
	addi     $t0, $0, 32
	# Create bit mask to check each bit
	addi     $t1, $0, 1
	lui $t3, 0x8000

loop:
	and $t2, $s0, $t1
	beq $t2, $0, bitAbs

	# If bit not found to be 0, do operations
	# Else, jump past operations
	add $s1, $s1, $t3

bitAbs:
	
	sll $t1, $t1, 1
	srl $t3, $t3, 1
	addi $t0, $t0, -1
	beq $t0, $0, conclude
	j loop


conclude:
	# Display the sum text
	ori     $v0, $0, 4			
	lui     $a0, 0x1001
	ori     $a0, $a0,0x58
	syscall
	
	# Display the sum
	# load 1 into $v0 to display an integer
	ori     $v0, $0, 1			
	add 	$a0, $s1, $0
	syscall
	
	# Exit (load 10 into $v0)
	ori     $v0, $0, 10
	syscall