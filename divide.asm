#Name: Ivan Li/ Alonso Gabe
#Section: 1
#Description: Dividing a 64 bit number by splitting it into 2 32 bit numbers
#
#----------------------------------------------------------------------------------
#Java Code
#
#public static int divide(int high, int low, int div){
#	while(div != 1){				<-loop until div hits 1
#		low = low >>> 1;			
#		if((high & 0x1) == 1){
#			low = low | 0x80000000		<-if the high lsb is 1 then or the low with a 1 in msb
#		}
#		high = high >>> 1;			<-divide high and div by 2
#		div = div >>> 1;
#	}
#
#------------------------------------------------------------------------------
#MIPS Code for Division
#
# declare global so programmer can see actual addresses.
.globl welcome
.globl prompt
.globl sumText

#  Data Area (this area contains strings to be displayed during the program)
.data

welcome:
	.asciiz " This program divs two numbers \n\n"

prompt:
	.asciiz " Enter an integer: "

highText: 
	.asciiz " \n High = "

lowText: 
	.asciiz " \n Low = "

#Text Area (i.e. instructions)
.text

main:

	# Display "This program adds two numbers"
	ori     $v0, $0, 4			

	# This generates the starting address for the welcome message.
	# (assumes the register first contains 0).
	lui     $a0, 0x1001
	syscall

	# Display "Enter an integer:"
	ori     $v0, $0, 4			
	
	# This is the starting address of the prompt (notice the
	# different address from the welcome message)
	lui     $a0, 0x1001
	ori     $a0, $a0,0x22
	syscall

	# Read 1st integer from the user (5 is loaded into $v0, then a syscall)
	ori     $v0, $0, 5
	syscall

	#setting t0 to be the high end
	move	$t0,$v0
	
	# Display "Enter an integer:"/ 0x22 is hexidecimal for 34 decimal (the length of the previous welcome message)
	ori     $v0, $0, 4			
	lui     $a0, 0x1001
	ori     $a0, $a0,0x22
	syscall

	# Read 2nd integer/ $v0 now has the value of the second integer
	ori	$v0, $0, 5			
	syscall

	#setting t1 as the low end
	move $t1,$v0

	# Display "Enter an integer:"/ 0x22 is hexidecimal for 34 decimal (the length of the previous welcome message)
	ori     $v0, $0, 4			
	lui     $a0, 0x1001
	ori     $a0, $a0,0x22
	syscall

	# Read 3rd integer/ $v0 now has the value of the 3rd integer
	ori	$v0, $0, 5			
	syscall

	#setting t2 as the divisor and t3 has counter
	move $t2,$v0
	lui $t3,0
	addi $t4,$0,1

division:
	beq $t2,$t4,display
	srl $t2,$t2,1
	srl $t1,$t1,1		#always shifting low end
	andi $t5,$t0,1		#checking if lsb of high end is 1
	srl $t0,$t0,1		#after checking then shift
	addi $t3,$t3,-1		#decrement counter
	beq $t5,$t4,shift_one
	j division

shift_one:
	lui $t6,0x8000		#making the msb 1
	or $t1,$t1,$t6		#shifting in the one from the high end to the low end using or
	move $t5,$0		#reset t5 to 0 so that we can check the lsb 
	j division

display:
	# Display "High end = "
	ori     $v0, $0, 4			
	lui     $a0, 0x1001
	ori     $a0, $a0,0x36
	syscall
	
	# Display the sum/ load 1 into $v0 to display an integer
	ori     $v0,$0,1			
	add 	$a0,$t0,$0		
	syscall

	# Display "Low end = "
	ori     $v0, $0, 4			
	lui     $a0, 0x1001
	ori     $a0, $a0,0x42
	syscall
	
	# Display the sum/ load 1 into $v0 to display an integer
	ori     $v0,$0,1			
	add 	$a0,$t1,$0		
	syscall

	# Exit (load 10 into $v0)
	ori     $v0, $0, 10
	syscall
