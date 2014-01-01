#
# CPU32 instruction verification code
# (each assertion will make an infinite loop if fails)
#

	# add
	nop
	addi	$t0,$0,1
	addi	$t1,$0,-1
	add		$t2,$t0,$t1
assert_add:
	nop
	bne		$t2,$0,assert_add

	# addu
	nop
	addi	$t0,$0,1
	addi	$t1,$0,-1
	addu	$t2,$t0,$t1
assert_addu:
	nop
	bne		$t2,$0,assert_addu

	# divu
	nop
	addi	$t0,$0,3
	addi	$t1,$0,-2
	divu	$0,$t0,$t1
assert_divu_hi:
	nop
	mfhi	$t2
	addi	$t7,$0,3
	bne		$t2,$t7,assert_divu_hi
assert_divu_lo:
	nop
	mflo	$t2
	bne		$t2,$0,assert_divu_lo

	# div
	nop
	addi	$t0,$0,3
	addi	$t1,$0,-2
	div		$0,$t0,$t1
assert_div_hi:
	nop
	mfhi	$t2
	addi	$t7,$0,1
	bne		$t2,$t7,assert_div_hi
assert_div_lo:
	nop
	mflo	$t2
	addi	$t7,$0,-1
	bne		$t2,$t7,assert_div_lo

	# multu
	nop
	addi	$t0,$0,-1
	addi	$t1,$0,-1
	multu	$t0,$t1
assert_multu_hi: # hi should be fffffffe
	mfhi	$t2
	addi	$t2,$t2,2
	bne		$t2,$0,assert_multu_hi 
assert_multu_lo: # lo should be 1
	nop
	mflo	$t2
	addi	$t7,$0,1
	bne		$t2,$t7,assert_multu_lo

	# mult
	nop
	addi	$t0,$0,-1
	addi	$t1,$0,-1
	mult	$t0,$t1
assert_mult_hi:
	mfhi	$t2
	bne		$t2,$0,assert_mult_hi
assert_mult_lo:
	nop
	mflo	$t2
	addi	$t7,$0,1
	bne		$t2,$t7,assert_mult_lo

	# mtlo, mflo
	nop
	addi	$t0,$0,0x1
	mtlo	$t0
	mflo	$t1
assert_mtlo:
	addi	$t7,$0,0x1
	bne		$t1,$t7,assert_mtlo

	# mthi, mfhi
	nop
	addi	$t0,$0,0x1
	mthi	$t0
	mfhi	$t1
assert_mthi:
	addi	$t7,$0,0x1
	bne		$t1,$t7,assert_mthi
	
	# sll
	nop
	addi	$t0,$0,0x1
	sll		$t1,$t0,0x1
assert_sll:
	addi	$t7,$0,0x2
	bne		$t1,$t7,assert_sll

	# srl
	nop
	addi	$t0,$0,0x2
	srl		$t1,$t0,0x1
assert_srl:
	addi	$t7,$0,0x1
	bne		$t1,$t7,assert_srl

	# sra
	nop
	addi	$t0,$0,0x0
	addi	$t1,$0,0x1
	sub		$t0,$t0,$t1
	sra		$t2,$t0,0x1
assert_sra:
	bne		$t2,$t0,assert_sra

	# sllv
	nop
	addi	$t0,$0,0x1
	addi	$t1,$0,0x3
	sllv	$t2,$t0,$t1
assert_sllv:
	addi	$t7,$0,0x8
	bne		$t2,$t7,assert_sllv

	# srav
	nop
	addi	$t0,$0,0x0
	addi	$t1,$0,0x1
	sub		$t0,$t0,$t1
	addi	$t2,$0,0x3
	srav	$t2,$t0,$t2
assert_srav:
	bne		$t2,$t0,assert_srav

	# jr
	# jalr
	# syscall
	# break
