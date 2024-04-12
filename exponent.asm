#Name: Ivan Li/ Alonso Gabe
#Section: 1
#Description: Creating Exponentiation using repeated addition
#
#----------------------------------------------------------------------------------
#Java Code
# 
#public static int exponent(int a, int b);
#
#int base= a;
#int inc= a;					<-repeated addition so it squares the base 
#
#for(int i = 1; i < b; i++){
#	for(int j = 1; j < a; j++){		<-basically squares the base by itself       
#		base += inc;
#	}
#	inc = base;				<-the rest is just adding square to itself 1 less time than power      
#}
#
#------------------------------------------------------------------------------
#MIPS Code for Exponentiation
#
# declare global so programmer can see actual addresses.
.globl welcome
.globl prompt
.globl sumText

#  Data Area (this area contains strings to be displayed during the program)
.data

welcome:
	.asciiz " This program does exponentiation \n\n"

prompt:
	.asciiz " Enter an integer: "

sumText: 
	.asciiz " \n Val = "

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
	ori     $a0, $a0,0x25
	syscall

	# Read 1st integer from the user (5 is loaded into $v0, then a syscall)
	ori     $v0, $0, 5
	syscall

	#setting t1 to be the base
	move	$t1,$v0
	
	# Display "Enter an integer:"
	ori     $v0, $0, 4			
	lui     $a0, 0x1001
	ori     $a0, $a0,0x25
	syscall

	# Read 2nd integer/ $v0 now has the value of the second integer
	ori	$v0, $0, 5			
	syscall

	#setting t2 as the power
	move $t2,$v0

	#to begin squaring the base by itself set t3 and t4 to the base
	move $t3,$t1
	move $t4,$t1
	
	#counters -> t5 is for power t6 is for base
	addi $t5,$0,1	
	addi $t6,$0,1
	addi $t7,$0,1

loop1:	
	#squaring base by itself
	beq $t1,$t6,loop2
	add $t3,$t3,$t4
	addi $t6,$t6,1
	j loop1
	
loop2:	
	addi $t5,$t5,1
	beq $t2,$t5,display 
	move $t4,$t3			#now we add the square to itself 
	move $t6,$t7			#reintialize the loop counter
	j loop1


display:
	# Display "Val = "
	ori     $v0, $0, 4			
	lui     $a0, 0x1001
	ori     $a0, $a0,0x3A
	syscall
	
	# Display the sum/ load 1 into $v0 to display an integer
	ori     $v0,$0,1			
	add 	$a0,$t3,$0		#i think this is where u display the value? t3 has the final answer
	syscall
	
	# Exit (load 10 into $v0)
	ori     $v0, $0, 10
	syscall
