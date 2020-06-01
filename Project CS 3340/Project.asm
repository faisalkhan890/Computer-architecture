# MOHAMMAD FAISAL KHAN (mxk177030)
# 3340 Computer Architecture 
# Class Project
# This Program is a Multitool which has different features and tools which you can utilize
 
	
	.data
	
	# Main Multitool
	Choice:			.word 0
	MenuMessage:		.asciiz	"\n\nPlease enter the digit for the index of the tool you want to use\n1. Calculator\n2. Sum and Average Calculator\n3. Integer to binary converter\n4. String Reversal\n5. Palindrome Checker\n0. End the Program\n "
	EndOfProgramMessage: 	.asciiz " \nThank you for using the Multitool.\n"
	InvalidToolChoice: 	.asciiz " \nWrong coice entererd enter it again.\n"
	
	#calculator
	operand_1: 		.asciiz "\nPlease enter your first operand:\n"
	operand_2: 		.asciiz "Please enter your second operand: \n"
	OperatorMessage: 	.asciiz "\nPlease enter your operation: \n1. +\n2. -\n3. * \n4. / \n0. Exit Calculator\n"
	WrongInputMessage: 	.asciiz "You have entered an invalid choice \n"
	additionResult: 	.asciiz "\nThe addition result is: "
	subtractionResult: 	.asciiz "\nThe subtraction result is: "
	divisionResult: 	.asciiz "\nThe division result is: "
	multiplicationResult: 	.asciiz "\nThe multiplication result is: "
	
	#Average
	sizeVariable:      	.word       0
	to_store:   		.word       0
	sumVariable:        	.word       0
	averageVariable:        .word       0

	Num_elements:    	.asciiz "Enter number of elements you want Sum and Average : "
	Element_enter:   	.asciiz "Enter an element: "
	space_char:      	.asciiz " "
	AverageOutputMsg:	.asciiz "\nThe Average is: "
	SumOutputMsg:   	.asciiz "\nThe Sum is: "
	
	#BinaryConverter
	IntegerInput: 		.asciiz "Input a number in integer form to convert to binary: "
	
	# string reversal
	UserNameInputMessage: 	.asciiz "Please enter your name: "
	NameVariable: 		.space 200
	
	# Palindrome
	reverse: 		.word 0
	PalindromeMessage2: 	.asciiz "This palindrome checker only deals with positive integer numbers.\n"
	PalindromeMessage3: 	.asciiz "Enter a number to check if it is a palindrome or not. \n"
	PalindromeMessage4: 	.asciiz " is a Palindrome Number.\n"
	PalindromeMessage5: 	.asciiz " is not a Palindrome Number.\n"
		
	.text
	
MultiTool: 
		#get 1st operand
		li $v0, 4				#system call for print str
		la $a0,MenuMessage			#addr of string to print
		syscall

		li $v0, 5 				#read 1st operand
		syscall
		
		sw $v0, Choice	
		lw $t0, Choice
		
		beq $t0, 0, End_of_Program
		beq $t0, 1, Calculator
		beq $t0, 2, SumAndAverage_Calculator
		beq $t0, 3, Binary_Converter
		beq $t0, 4, String_reversal
		beq $t0, 5, Palindrome_check
		
		j WrongMultiToolChoice
		
################################################################################################################################################################
################################################################################################################################################################

Calculator:
	
		#get operator
		li $v0, 4			#system call for print str
		la $a0,OperatorMessage			#addr of string to print
		syscall

		li $v0, 5 			#read operator
		syscall
		
		#store what the user inputted into t3
  		move $t3, $v0
		#clearing the v0 register for future use.
		move $v0, $zero 
	
		#checking if the user wants to exit calculator
		beq $t3, 0, ExitCalc
		beq $t3, 1, UserInput
		beq $t3, 2, UserInput
		beq $t3, 3, UserInput
		beq $t3, 4, UserInput
		j WrongCalculatorInput
	
UserInput:
		#Prompt user to enter first number
		li $v0, 4 		#printing a string
		la $a0, operand_1
		syscall
	
		#get the first number
		li $v0, 5		 #getting an integer from user
		syscall
	
		#store what the user inputted into t0
		move $t0, $v0
		#clearing the v0 register for future use.
		move $v0, $zero 
	
		#Prompt user to enter second number
		li $v0, 4
		la $a0, operand_2
		syscall
	
		#get the second number
		li $v0, 5		 #getting the second integer from user
		syscall
	
		#store what the user inputted as the second number into t1
		move $t1, $v0
		#clearing the v0 register for future use.
		move $v0, $zero 
	
		beq $t3, 1, ADDITION
		beq $t3, 2, SUBTRACTION
		beq $t3, 3, MULTIPLICATION
		beq $t3, 4, DIVISION
		
ADDITION:
	
		add $s0, $t0, $t1 	# t2 = t0 + t1
	
		#Display the addition message to the user
		li $v0, 4
		la $a0, additionResult
		syscall
	
		# Cleariing the values
		move $v0, $zero 
		move $a0, $zero
		li $v0, 1
		move $a0, $s0 		#This is our addition result.
		syscall
	
		j Calculator
	
SUBTRACTION:
	
		sub $s1, $t0, $t1 	#t3 = t0 - t1
	
		#Display the subtraction message to the user
		li $v0, 4
		la $a0, subtractionResult
		syscall
	
		#clearing the values
		move $v0, $zero 
		move $a0, $zero 
		li $v0, 1
		move $a0, $s1 #This is our subtraction result.
		syscall
	
		j Calculator
	
MULTIPLICATION:
	
		mul $s2, $t0, $t1 	#t4 = t0 * t1
	
		# outputting the multiplication message to the user
		li $v0, 4
		la $a0, multiplicationResult
		syscall
	
		# clearing the values
		move $v0, $zero 	#clear the values
		move $a0, $zero 	#clear the values	
		li $v0, 1
		move $a0, $s2 		#This is our multiplication result.
		syscall
	
		j Calculator
	
DIVISION:
	
		div $s3, $t0, $t1 	#t5 = t0/t1
	
		#Display the division message to the user
		li $v0, 4
		la $a0, divisionResult
		syscall
	
		move $v0, $zero 	#clear the values
		move $a0, $zero 	#clear the values	
		li $v0, 1
		move $a0, $s3 		#This is our divisions result.
		syscall
	
		j Calculator
	
		WrongCalculatorInput:
		li $v0, 4
		la $a0, WrongInputMessage
		syscall
	
		j Calculator
	
		ExitCalc:
	
		j MultiTool

################################################################################################################################################################
################################################################################################################################################################

SumAndAverage_Calculator:

 # Prints message to get length of array
    la      $a0,Num_elements
    addi    $v0,$0,4
    syscall

    # Gets input from user
    addi    $v0,$0,5
    syscall
    
    sw      $v0,sizeVariable

    addi    $t0,$0,0                # counter is declared to 0

    # Creates the array
    lw      $s0,sizeVariable        # get array count
    addi    $t1,$0,4                # get 4
    mult    $s0,$t1                 # get count * 4
    mflo    $t2                     # get offset
    add     $a0,$t1,$t2
    addi    $v0,$0,9
    syscall

Array:
    beq     $t0,$s0, SumTotal       # inputting numbers until array size is reached

    # prompt user for list element
    la      $a0,Element_enter
    addi    $v0,$0,4
    syscall

    # read in element value
    addi    $v0,$0,5
    syscall
    sw      $v0,to_store
    lw      $t5,to_store

    # push element to Array
    addi    $sp,$sp,-4
    sw      $t5,0($sp)

    addi    $t0,$t0,1           # advance array index
    j       Array

    # get sum of array elements
SumTotal:
    beq     $s0,0,average       # if reached the end of an array, go to average calculation
    lw      $t6,sumVariable     # get previous sum
    lw      $t7,0($sp)          # get next array element value
    addi    $sp,$sp,4           # advance array pointer
    add     $t6,$t7,$t6         # adding to the prvious sum 
    sw      $t6,sumVariable     # store it
    addi    $s0,$s0,-1          # decrease the counter by 1
    j       SumTotal


    # Average Calculation    
average:
    lw      $t0,sumVariable             # getting the sum 

    # outputting the sum to thr user
    la      $a0,SumOutputMsg
    addi    $v0,$0,4
    syscall
    
    li      $v0,1
    move    $a0,$t0
    syscall

    # restoring the counter value 
    lw      $s0,sizeVariable

    div     $t0,$s0             		# divide by counter value 
    mflo    $t0
    sw      $t0,averageVariable             	# storing the calculated average 

    li      $v0,4
    la      $a0,space_char
    syscall

    # outputting the average to the user
    la      $a0,AverageOutputMsg
    addi    $v0,$0,4
    syscall
    
    lw      $a0,averageVariable
    addi    $v0,$0,1
    syscall
    
    j MultiTool

################################################################################################################################################################
################################################################################################################################################################

Binary_Converter:
li $t9,2		#base 2 divisor
	li $t8,1		#counter for 32-n operation
	li $s7,4		#for moving pointer multiplied by 4
	li $s6,1		#counter for outputloop operation which would eventually equal s8
	li $s5,32		#used for 32-n operation
	li $s3,1

	la $a0,IntegerInput	#print prompt for integer output
	li $v0,4
	syscall

	li $v0,5
	syscall

	add $a0,$v0,$0

	jal BinaryCalc #jumping to calculation of binary numbers

#calculating remaining zeros in the binary
CalcRemainingZeros: 
			sub $s4,$s5,$t8

			j RemainingZeros

RemainingZeros:	
			add $a0,$0,0	
			
			li $v0,1	
			syscall
			
			sub $s4,$s4,1
			beq $s4,$0, Output
			
			j RemainingZeros

Output:  #printing the binary number 
		lw $a0,0($sp)		#load binary value from stack
		addi $sp,$sp,4		#increment stack pointer
		
		li $v0,1
		syscall			#printinf binary value
					
		addi $s6,$s6,1		#increase counter

		beq $s6,$t8,MultiTool	#repeat for t8 times
		
		j Output

BinaryCalc:   
		add $s0,$a0,$0			# take from a and work with input num, 
						# go back to main, pop out remainder
						
		addi $t8,$t8,1			#increment counter for 32-n operation

		div $s0,$t9			#perform division on userinput (s0, s9 = 2 for base 2)

		mflo $s2			#store dividend into s2
		mfhi $t2			#store remainder into t2
	
		sub $sp,$sp,4			#decrement stack pointer by 4
		sw $t2,0($sp)			#store remainder into stack
		
		add $a0,$s2,$0			#store s2 into a0 dividend into argument
	
		beq $a0,$0,JumpBack		#if dividend is 0 then base change complete, jump to ra
	
		j BinaryCalc			#if divident is not 0 then sub1 will loop

JumpBack: 
		jr $ra					#ra returns to main

################################################################################################################################################################
################################################################################################################################################################

String_reversal:


	li $v0, 4 # Asking the user for their name or string to be reverse
	la $a0, UserNameInputMessage
	syscall

	li $v0, 8  # Read string 
	la $a0, NameVariable
	li $a1, 50
	syscall


	la $t0 NameVariable	# Load test_string address
	
Lenght_loop: # Loop to find length of input string
		lb $t1 0($t0) # Load the character of the string
		beq $t1 $zero end_size_loop # checking if the charachter is null or not and exiting loop if it is 
		addi $t0 $t0 1	# increasining the couner for length of string
		j Lenght_loop	# looping back to count the remaing charachters in the string
		
		
end_size_loop:
	
	la $t6 NameVariable	# Load test_string address for base addressing
	sub $t7 $t0 $t6 # length of the user input string
	li $t0 0 # the index of the while loop is declared to zero
	li $t3 0 # Offset for retreiving test_string characters
	li $t4 0 # charachter counter for the reverse loop variable
	
while: # Loop over all the characters in input
	
		bgt $t0, $t7, endWhile	# if end of string is reached then end the while loop
		
		add $t3, $t0, $t6 # find out the address of the character
		lb $t3, 0($t3)	# Loading character value to $t3
		
		bne $t3, 32, No_space	# If the loaded value in $t3 is not a space, GOTO else
		li $t5, 0	# Else make $t5 a loop counter
		
		
reverseLoop: # printing charachters in reverse order
		
			beq $t5 $t4 end_reverse	# If we reached the end of the string, then end the reverse loop
			lw $a0 ($sp) # Pop off character stack
			addi $sp $sp 4 # changing the stack pointer accordingly
			li $v0 11	# Load print character 
			syscall 	
			
			addi $t5 $t5 1 # Incrementing the reverse loop counter
			j reverseLoop	# looping back until the string is reversed
			
end_reverse:
		li $a0 32 # Load a space to $a0
		li $v0 11 # Load print character
		syscall 

		addi $t0, $t0, 1	# Increment while_loop counter
		li $t4 0 # set word character counter back to zero
		j while	
		
No_space: # If character was not a space
		
		sub $sp $sp 4 # Adjust the stack pointer
		sb $t3 ($sp) # Push the character onto the stack

		addi $t4, $t4, 1	# Incremenet word character counter
		addi $t0, $t0, 1	# Increment while_loop counter
		j while
	
endWhile:
	
		li $t5 0	 # Make $t5 a loop counter
		
LastReverse: # reversing from the last space to the last character
			beq $t5 $t4 MultiTool	# If the end of the string is reached, End the program
			
			lw $a0 ($sp) # Pop off character stack
			addi $sp $sp 4 # Adjust stack pointer
			
			li $v0 11	# Load print character
			syscall
			
			addi $t5 $t5 1 # Incremenet loop counter
			j LastReverse #loop back to the loop
			

################################################################################################################################################################
################################################################################################################################################################

Palindrome_check:

# PALINDROME CHECK
# A number that remains the same when its digits are reversed. Like 16461
	
	lw $s0, reverse 	# reverse = 0 is loaded in $s0 (reverse = s0)

	li $v0, 4 		# asking the user to enter a number to check for palindrome
	la $a0, PalindromeMessage3
	syscall

	li $v0, 5 		# reading the input from the user
	syscall
	
	move $s1, $v0 		# store read number in $s1  (temp = s1)
	add $s2, $zero, $s1 	# make copy of number ( num = s2)

	
	
Palindrome_calc_loop:
	beq $s1, $zero, Check_Palindrome_Loop # if temp equals 0 then branch to endloop
	li $t2, 10		# loading 10 in $t2
	
	mult $s0, $t2 		# reverse = reverse * 10
	mflo $s0
	
	div $s1, $t2 		# temp / 10 remainder in HI
	mfhi $t0 		# temp % 10 stored in $t0 from HI
	add $s0, $t0, $s0 	# reverse = temp%10 + reverse

	div $s1, $t2 
	mflo $s1 		# temp = temp/10 from LO
	j Palindrome_calc_loop 	# Go to start of loop

Check_Palindrome_Loop:
	beq $s2, $s0, Is_Palindrome # if calculted number is equal to the inputted number, go to isPalindrome
	li $v0, 1 		# else, it is not a palindrome
	move $a0, $s2 		# print number
	syscall
	
	li $v0, 4 		# print message where it is not a palindrome
	la $a0, PalindromeMessage5
	syscall
	j End_of_Program 			# move to the end of program and end the program

Is_Palindrome:
	li $v0, 1 		# it is a palindrome
	move $a0, $s2 		# print the number
	syscall
	
	li $v0, 4 		# print the message saying that it is a palindrome
	la $a0, PalindromeMessage4
	syscall
	
	j MultiTool
	
################################################################################################################################################################	
################################################################################################################################################################

WrongMultiToolChoice:
	li $v0, 4
	la $a0, InvalidToolChoice
	syscall
	
	j MultiTool

End_of_Program:

	li $v0, 4 		# print end of program message
	la $a0, EndOfProgramMessage
	syscall
	
	li $v0, 10 		# End the program
	syscall
	
	





		
		
		
		
		