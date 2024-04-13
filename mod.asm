#Name: Ivan Li/ Gabe Alonso
#Section: 1
#Description: Finding the remainder of integer division

# Java Code
#public static void mod(int num, int div){
#    int mask = 0xFFFFFFFF;
#    while (div != 0){
#        num = num & mask;
#        div = div & mask;
#        mask = mask >>> 1;
#    }
#    System.out.println(num);
#}





# declare global so programmer can see actual addresses.
.globl welcome
.globl prompt
.globl sumText

#  Data Area (this area contains strings to be displayed during the program)
.data

welcome:
	.asciiz " This program finds the remainder of int division \n\n"

prompt:
	.asciiz " Enter an integer: "

sumText: 
	.asciiz " \n Remainder = "

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
	ori     $a0, $a0,0x35
	syscall

	# Read 1st integer from the user (5 is loaded into $v0, then a syscall)
	ori     $v0, $0, 5
	syscall

	# Clear $s0 for the result
	ori     $s0, $0, 0	

	# Add 1st integer to result
	# (could have put 1st integer into $s0 and skipped clearing it above)
	addu    $s0, $v0, $s0
	
	# Display prompt (4 is loaded into $v0 to display)
	# 0x22 is hexidecimal for 34 decimal (the length of the previous welcome message)
	ori     $v0, $0, 4			
	lui     $a0, 0x1001
	ori     $a0, $a0,0x35
	syscall

	# Read 2nd integer (Divisor) 
	ori	$v0, $0, 5			
	syscall
	# $v0 now has the value of the second integer
	
	# Save divisor to t0
	ori     $t0, $0, 0
	addu    $t0, $v0, $t0 

	# Display the sum text
	ori     $v0, $0, 4			
	lui     $a0, 0x1001
	ori     $a0, $a0,0x49
	syscall
	
	# Calculate the remainder by ANDing divisor and given
	# integer with mask and then right shift the divisor until
	# all that is left is the remainder and the divisor is == 0
	li $t1, 0xFFFFFFFF
loop:	
	and $s0, $s0, $t1
	and $t0, $t0, $t1
	beq $t0, $0, conclude
	srl $t1, $t1, 1
	j loop
	
	# Display the sum
	# load 1 into $v0 to display an integer
conclude:
	ori     $v0, $0, 1			
	add 	$a0, $s0, $0
	syscall
	
	# Exit (load 10 into $v0)
	ori     $v0, $0, 10
	syscall