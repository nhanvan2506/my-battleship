.data
text1:.asciiz"input the row bow of player1: "
text2:.asciiz"input the col bow of player1: "
text3:.asciiz"input the row stern of player1: "
text4:.asciiz"input the col stern of player1: \n"
text5:.asciiz"again \n"
text6:.asciiz"overlap \n"
text7:.asciiz"input the row bow of player2: "
text8:.asciiz"input the col bow of player2: "
text10:.asciiz"input the row stern of player2: "
text11:.asciiz"input the col stern of player2: \n"
text12:.asciiz"input the attack row to attack player1: "
text13:.asciiz"input the attack col to attack player1: "
text14:.asciiz"HIT \n"
text15:.asciiz"player1 win"
text16:.asciiz"player2 win"
text17:.asciiz"input the attack row to attack player2: "
text18:.asciiz"input the attack col to attack player2: "
text19:.asciiz"MISS \n"
text9:.asciiz" "
text25:.asciiz"\n"
rowbow:.word 0
colbow:.word 0
rowstern:.word 0
colstern:.word 0
rowbow2:.word 0
colbow2:.word 0
rowstern2:.word 0
colstern2:.word 0
rowattack1:.word 0
colattack1:.word 0
rowattack2:.word 0
colattack2:.word 0
grid1:.byte 100
grid2:.byte 100
.text
la $t0,grid1
li $t1,0
li $s1,3
li $s2,2
li $s3,1
li $s7,6
set0:
beq $t1,49,input1
li $s0,0
sb $s0,0($t0)
addi $t0,$t0,4
addi $t1,$t1,1
j set0

input1:
li $v0,4
la $a0,text1
syscall
li $v0,5
syscall
sb $v0,rowbow
lb $t1,rowbow
bgt $t1,6,input1
blt $t1,0,input1

li $v0,4
la $a0,text2
syscall
li $v0,5
syscall
sb $v0,colbow
lb $t2,colbow
bgt $t2,6,input1
blt $t2,0,input1

li $v0,4
la $a0,text3
syscall
li $v0,5
syscall
sb $v0,rowstern
lb $t3,rowstern
bgt $t3,6,input1
blt $t3,0,input1

li $v0,4
la $a0,text4
syscall
li $v0,5
syscall
sb $v0,colstern
lb $t4,colstern
bgt $t4,6,input1
blt $t4,0,input1

bne $t1,$t3,checkcot
bne $t2,$t4,checkhang

checkcot:
beq $t2,$t4,checksizeHang
li $v0,4
la $a0,text5
syscall
j input1

checkhang:
beq $t1,$t3,checksizeCot
li $v0,4
la $a0,text5
syscall
j input1

checksizeHang:
sub $t5,$t3,$t1
abs $t5,$t5
beq $t5,1,con2x1
beq $t5,2,con3x1
beq $t5,3,con4x1
li $v0,4
la $a0,text5
syscall
j input1

checksizeCot:
sub $t5,$t4,$t2
abs $t5,$t5
beq $t5,1,con2x1
beq $t5,2,con3x1
beq $t5,3,con4x1
li $v0,4
la $a0,text5
syscall
j input1

con4x1:
bne $s3,0,truonghop
li $v0,4
la $a0,text5
syscall
j input1

con3x1:
bne $s2,0,truonghop
li $v0,4
la $a0,text5
syscall
j input1

con2x1:
bne $s1,0,truonghop
li $v0,4
la $a0,text5
syscall
j input1

overlap:
li $v0,4
la $a0,text6
syscall
li $v0,4
la $a0,text5
syscall
j input1

truonghop:
beq $t1,$t3,ngang
beq $t2,$t4,doc

ngang:
lb $t1,rowbow
lb $t2,colbow
lb $t3,rowstern
lb $t4,colstern
la $t0,grid1
mul $t5,$t1,7
add $t5,$t5,$t2
li $t9, 0
Transverse:
	beq $t9, $t5, exitTransverse
	addi $t0, $t0, 4
	addi $t9, $t9, 1
	j Transverse
exitTransverse:
	move $s6,$t0
	lb $s6,0($t0)
	beq $s6,1,overlap
	sub $t6,$t4,$t2
	blt $t6,0,begin_add2row
	bgt $t6,0,begin_Add1row
begin_Add1row:
move $t9,$t2
addi $t4,$t4,1
j Add1row
begin_add2row:
move $t9,$t2
add $t4,$t4,-1
j add2row
Add1row:
	beq $t9, $t4, con
	addi $s6,$s6,4
	lb $s6,0($t0)
	beq $s6,1,overlap
	li $t8, 1
	sb $t8, 0($t0)
	addi $s6,$s6,4
	addi $t0, $t0, 4
	addi $t9, $t9, 1
	j Add1row
add2row:
	beq $t9, $t4, con
	addi $s6,$s6,4
	lb $s6,0($t0)
	beq $s6,1,overlap
	li $t8, 1
	sb $t8, 0($t0)
	addi $t0, $t0, -4
	addi $t9, $t9, -1
	j add2row
doc:
lb $t1,rowbow
lb $t2,colbow
lb $t3,rowstern
lb $t4,colstern
la $t0,grid1
mul $t5,$t1,7
add $t5,$t5,$t2
li $t9,0
vodoc:
	beq $t9, $t5, exitVodoc
	addi $t0, $t0, 4
	addi $t9, $t9, 1
	j vodoc
exitVodoc:
	move $s6,$t0
	lb $s6,0($t0)
	beq $s6,1,overlap
	sub $t6,$t3,$t1
	blt $t6,0,begin_add2col
	bgt $t6,0,begin_Add1col

begin_Add1col:
move $t9,$t1
addi $t3,$t3,1
j Add1col
begin_add2col:
move $t9,$t1
add $t3,$t3,-1
j add2col

Add1col:
beq $t9, $t3, con
addi $s6,$s6,28
lb $s6,0($t0)
beq $s6,1,overlap
li $t8, 1
sb $t8, 0($t0)
addi $t0, $t0,28
addi $t9, $t9, 1
j Add1col

add2col:
beq $t9, $t3, con
addi $s6,$s6,-28
lb $s6,0($t0)
beq $s6,1,overlap
li $t8, 1
sb $t8, 0($t0)
addi $t0, $t0, -28
addi $t9, $t9, -1
j add2col
	
con:   #so thuyen con lai
addi $s7,$s7,-1
beq $t6,3,thuyen4x1
beq $t6,2,thuyen3x1
beq $t6,1,thuyen2x1

thuyen4x1:
addi $s3,$s3,-1
beq $s7,0,print
j input1

thuyen3x1:
addi $s2,$s2,-1
beq $s7,0,print
j input1

thuyen2x1:
addi $s1,$s1,-1
beq $s7,0,print
j input1

print:
	la $t0, grid1
	li $t1, 0
	li $t2, 0
	
Loop:
	beq $t2, 7, ready2
	li $t1, 0
	
Loop2:
	beq $t1, 7, NextLoop
	lb $t3, ($t0)
	li $v0, 1
	move $a0, $t3
	syscall
	
	li $v0, 4
	la $a0, text9
	syscall
	
	addi $t1, $t1, 1
	addi $t0, $t0, 4
	j Loop2
	
NextLoop:
	li $v0, 4
	la $a0, text25
	syscall
	
	addi $t2, $t2, 1
	j Loop
ready2:
la $a3,grid2
li $t1,0
li $s1,3
li $s2,2
li $s3,1
li $s7,6
set02:
beq $t1,49,input2
li $s0,0
sb $s0,0($t0)
addi $t0,$t0,4
addi $t1,$t1,1
j set02
input2:
li $v0,4
la $a0,text7
syscall
li $v0,5
syscall
sb $v0,rowbow2
lb $t1,rowbow2
bgt $t1,6,input2
blt $t1,0,input2

li $v0,4
la $a0,text8
syscall
li $v0,5
syscall
sb $v0,colbow2
lb $t2,colbow2
bgt $t2,6,input2
blt $t2,0,input2

li $v0,4
la $a0,text10
syscall
li $v0,5
syscall
sb $v0,rowstern2
lb $t3,rowstern2
bgt $t3,6,input2
blt $t3,0,input2

li $v0,4
la $a0,text11
syscall
li $v0,5
syscall
sb $v0,colstern2
lb $t4,colstern2
bgt $t4,6,input2
blt $t4,0,input2

bne $t1,$t3,checkcot2
bne $t2,$t4,checkhang2

checkcot2:
beq $t2,$t4,checksizeHang2
li $v0,4
la $a0,text5
syscall
j input2

checkhang2:
beq $t1,$t3,checksizeCot2
li $v0,4
la $a0,text5
syscall
j input2

checksizeHang2:
sub $t5,$t3,$t1
abs $t5,$t5
beq $t5,1,con2x1_2
beq $t5,2,con3x1_2
beq $t5,3,con4x1_2
li $v0,4
la $a0,text5
syscall
j input2

checksizeCot2:
sub $t5,$t4,$t2
abs $t5,$t5
beq $t5,1,con2x1_2
beq $t5,2,con3x1_2
beq $t5,3,con4x1_2
li $v0,4
la $a0,text5
syscall
j input2

con4x1_2:
bne $s3,0,truonghop2
li $v0,4
la $a0,text5
syscall
j input2

con3x1_2:
bne $s2,0,truonghop2
li $v0,4
la $a0,text5
syscall
j input2

con2x1_2:
bne $s1,0,truonghop2
li $v0,4
la $a0,text5
syscall
j input2

overlap_2:
li $v0,4
la $a0,text6
syscall
li $v0,4
la $a0,text5
syscall
j input2

truonghop2:
beq $t1,$t3,ngang2
beq $t2,$t4,doc2

ngang2:
lb $t1,rowbow2
lb $t2,colbow2
lb $t3,rowstern2
lb $t4,colstern2
la $a3,grid2
mul $t5,$t1,7
add $t5,$t5,$t2
li $t9, 0
Transverse2:
	beq $t9, $t5, exitTransverse2
	addi $a3, $a3, 4
	addi $t9, $t9, 1
	j Transverse2
exitTransverse2:
	move $s6,$a3
	lb $s6,0($a3)
	beq $s6,1,overlap_2
	sub $t6,$t4,$t2
	blt $t6,0,begin_add2row2
	bgt $t6,0,begin_Add1row2
begin_Add1row2:
move $t9,$t2
addi $t4,$t4,1
j Add1row2
begin_add2row2:
move $t9,$t2
add $t4,$t4,-1
j add2row2
Add1row2:
	beq $t9, $t4, con2
	addi $s6,$s6,4
	lb $s6,0($a3)
	beq $s6,1,overlap_2
	li $t8, 1
	sb $t8, 0($a3)
	addi $s6,$s6,4
	addi $a3, $a3, 4
	addi $t9, $t9, 1
	j Add1row2
add2row2:
	beq $t9, $t4, con2
	addi $s6,$s6,4
	lb $s6,0($a3)
	beq $s6,1,overlap_2
	li $t8, 1
	sb $t8, 0($a3)
	addi $a3, $a3, -4
	addi $t9, $t9, -1
	j add2row2
doc2:
lb $t1,rowbow2
lb $t2,colbow2
lb $t3,rowstern2
lb $t4,colstern2
la $a3,grid2
mul $t5,$t1,7
add $t5,$t5,$t2
li $t9,0
vodoc2:
	beq $t9, $t5, exitVodoc2
	addi $a3, $a3, 4
	addi $t9, $t9, 1
	j vodoc2
exitVodoc2:
	move $s6,$a3
	lb $s6,0($a3)
	beq $s6,1,overlap_2
	sub $t6,$t3,$t1
	blt $t6,0,begin_add2col_2
	bgt $t6,0,begin_Add1col_2

begin_Add1col_2:
move $t9,$t1
addi $t3,$t3,1
j Add1col_2
begin_add2col_2:
move $t9,$t1
add $t3,$t3,-1
j add2col_2

Add1col_2:
beq $t9, $t3, con2
addi $s6,$s6,28
lb $s6,0($a3)
beq $s6,1,overlap_2
li $t8, 1
sb $t8, 0($a3)
addi $a3, $a3,28
addi $t9, $t9, 1
j Add1col_2

add2col_2:
beq $t9, $t3, con2
addi $s6,$s6,-28
lb $s6,0($a3)
beq $s6,1,overlap_2
li $t8, 1
sb $t8, 0($a3)
addi $a3, $a3, -28
addi $t9, $t9, -1
j add2col_2
	
con2:   #so thuyen con lai
addi $s7,$s7,-1
beq $t6,3,thuyen4x1_2
beq $t6,2,thuyen3x1_2
beq $t6,1,thuyen2x1_2

thuyen4x1_2:
addi $s3,$s3,-1
beq $s7,0,print2
j input2

thuyen3x1_2:
addi $s2,$s2,-1
beq $s7,0,print2
j input2

thuyen2x1_2:
addi $s1,$s1,-1
beq $s7,0,print2
j input2

print2:
	la $a3, grid2
	li $t1, 0
	li $t2, 0
	
Loop3:
	beq $t2, 7, ready_attack1
	li $t1, 0
	
Loop4:
	beq $t1, 7, NextLoop2
	lb $t3, ($a3)
	li $v0, 1
	move $a0, $t3
	syscall
	
	li $v0, 4
	la $a0, text9
	syscall
	
	addi $t1, $t1, 1
	addi $a3, $a3, 4
	j Loop4
	
NextLoop2:
	li $v0, 4
	la $a0, text25
	syscall
	
	addi $t2, $t2, 1
	j Loop3
ready_attack1:
li $v0,4
la $a0,text12
syscall
li $v0,5
syscall
sb $v0,rowattack1
lb $t1,rowattack1
bgt $t1,6,ready_attack1
blt $t1,0,ready_attack1

li $v0,4
la $a0,text13
syscall
li $v0,5
syscall
sb $v0,colattack1
lb $t2,colattack1
bgt $t2,6,ready_attack1
blt $t2,0,ready_attack1

attack1:
la $t0,grid1
mul $t5,$t1,7
add $t5,$t5,$t2
li $t9,0
loop_attack1:
beq $t9,$t5,finish1
addi $t0,$t0,4
addi $t9,$t9,1
j loop_attack1
finish1:
lb $s6,0($t0)
beq $s6,1,hit1
beq $s6,0,miss1

miss1:
li $v0,4
la $a0,text19
syscall
j ready_attack2

hit1:
li $v0,4
la $a0,text14
syscall
lb $s6,0($t0)
li $s6,0
sb $s6,0($t0)
j check01

check01:
la $t0,grid1
li $t9,0
loop_check01:
beq $t9,49,done1
addi $t0,$t0,4
addi $t9,$t9,1
lb $s6,0($t0)
beq $s6,1,ready_attack2
j loop_check01

done1:
li $v0,4
la $a0,text16
syscall
j exit

ready_attack2:
li $v0,4
la $a0,text17
syscall
li $v0,5
syscall
sb $v0,rowattack2
lb $t1,rowattack2
bgt $t1,6,ready_attack2
blt $t1,0,ready_attack2

li $v0,4
la $a0,text18
syscall
li $v0,5
syscall
sb $v0,colattack2
lb $t2,colattack2
bgt $t2,6,ready_attack2
blt $t2,0,ready_attack2

attack2:
la $a3,grid2
mul $t5,$t1,7
add $t5,$t5,$t2
li $t9,0
loop_attack2:
beq $t9,$t5,finish2
addi $a3,$a3,4
addi $t9,$t9,1
j loop_attack2
finish2:
lb $s6,0($a3)
beq $s6,1,hit2
beq $s6,0,miss2

miss2:
li $v0,4
la $a0,text19
syscall
j ready_attack1
hit2:
li $v0,4
la $a0,text14
syscall
li $s6,0
sb $s6,0($a3)
j check02

check02:
la $a3,grid2
li $t9,0
loop_check02:
beq $t9,49,done2
addi $a3,$a3,4
addi $t9,$t9,1
lb $s6,0($a3)
beq $s6,1,ready_attack1
j loop_check02

done2:
li $v0,4
la $a0,text15
syscall
j exit

exit:
li $v0, 10
syscall
