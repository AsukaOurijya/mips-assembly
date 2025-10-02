.data
	jumlah_hari_msg: .asciiz "Masukkan jumlah hari: "
	hari_x_msg: .asciiz "Hari "
	jumlah_minuman_msg: .asciiz "Masukkan jumlah minuman terjual: "
	harga_beli_bahan_msg: .asciiz "Masukkan harga beli bahan per minuman: "
	harga_jual_msg: .asciiz "Masukkan harga jual per minuman: "
	
	total_pengeluaran_msg: .asciiz "Total pengeluaran untuk semua hari adalah Rp"
	total_pendapatan_msg: .asciiz "Total pendapatan untuk semua hari adalah Rp"
	total_laba_msg: .asciiz "Total laba untuk semua hari adalah Rp"
	
	colon: .asciiz ":"
	new_line: .asciiz "\n"
	divider: .asciiz "----------------------------"

.text
.globl main

main:
	# Print prompt jumlah hari
	li $v0, 4
	la $a0, jumlah_hari_msg
	syscall

	# Read jumlah hari -> $t1
	li $v0, 5
	syscall
	add $t1, $v0, $zero    # $t1 = N

	# Inisialisasi counter dan akumulator
	addi $t0, $zero, 1     # i = 1 (loop counter)
	addi $s0, $zero, 0     # $s0 = total_pengeluaran
	addi $s1, $zero, 0     # $s1 = total_pendapatan

loop_check:
	# jika i > N -> selesai
	bgt $t0, $t1, summary

	# Print newline
	li $v0, 4
	la $a0, new_line
	syscall

	# Print divider
	li $v0, 4
	la $a0, divider
	syscall

	# Print "Hari "
	li $v0, 4
	la $a0, hari_x_msg
	syscall

	# Print nilai i (hari ke-...)
	li $v0, 1
	add $a0, $t0, $zero
	syscall

	# Print colon and newline
	li $v0, 4
	la $a0, colon
	syscall

	li $v0, 4
	la $a0, new_line
	syscall

	# ========== Input jumlah minuman ==========
	li $v0, 4
	la $a0, jumlah_minuman_msg
	syscall

	li $v0, 5
	syscall
	add $t2, $v0, $zero    # $t2 = jumlah minuman terjual

	# ========== Input harga beli per minuman ==========
	li $v0, 4
	la $a0, harga_beli_bahan_msg
	syscall

	li $v0, 5
	syscall
	add $t3, $v0, $zero    # $t3 = harga beli

	# ========== Input harga jual per minuman ==========
	li $v0, 4
	la $a0, harga_jual_msg
	syscall

	li $v0, 5
	syscall
	add $t4, $v0, $zero    # $t4 = harga jual

	# ========== Hitung pengeluaran hari: t2 * t3 ==========
	# gunakan mult + mflo (tidak memakai instruksi 'mul' yang dilarang)
	mult $t2, $t3
	mflo $t5               # $t5 = pengeluaran_hari

	# total_pengeluaran += pengeluaran_hari
	add $s0, $s0, $t5

	# ========== Hitung pendapatan hari: t2 * t4 ==========
	mult $t2, $t4
	mflo $t6               # $t6 = pendapatan_hari

	# total_pendapatan += pendapatan_hari
	add $s1, $s1, $t6

	# Next day: i++
	addi $t0, $t0, 1

	j loop_check

summary:
	# Print newline
	li $v0, 4
	la $a0, new_line
	syscall

	# Print total_pengeluaran_msg then value
	li $v0, 4
	la $a0, total_pengeluaran_msg
	syscall

	li $v0, 1
	add $a0, $s0, $zero
	syscall

	# newline
	li $v0, 4
	la $a0, new_line
	syscall

	# Print total_pendapatan_msg then value
	li $v0, 4
	la $a0, total_pendapatan_msg
	syscall

	li $v0, 1
	add $a0, $s1, $zero
	syscall

	# newline
	li $v0, 4
	la $a0, new_line
	syscall

	# Hitung laba = pendapatan - pengeluaran -> $s2
	sub $s2, $s1, $s0

	# Print total_laba_msg then value
	li $v0, 4
	la $a0, total_laba_msg
	syscall

	li $v0, 1
	add $a0, $s2, $zero
	syscall

	# newline
	li $v0, 4
	la $a0, new_line
	syscall

	# exit
	li $v0, 10
	syscall
