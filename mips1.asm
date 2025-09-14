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
	# print(jumlah_hari_msg)
	li $v0, 4
	la $a0, jumlah_hari_msg
	syscall 
	
	# Input jumlah hari, disimpan ke register $t1
	li $v0, 5
	add $t1, $zero, $v0
	syscall
	
	# Inisialisasi loop, i = 1 dimana i = $t0
	addi $t0, $zero, 1
	
while:
	beq $t0, $t1, summary # if $t0 == $t1
	j menu
	
	#bne $t0, $t1, menu
	#j summary
	
menu:
	# print(new_line)
	li $v0, 4
	la $a0, new_line
	syscall

	# print(divider)
	li $v0, 4
	la $a0, divider
	syscall

	# "Hari "
	li $v0, 4
	la $a0, hari_x_msg
	syscall
	
	# Iterasi ke berapa
	li $v0, 1
	add $a0, $zero, $t0
	syscall
	
	# print(new_line)
	li $v0, 4
	la $a0, new_line
	syscall
	
	# print menu pertama
	li $v0, 4
	la $a0, jumlah_minuman_msg
	syscall
	
	# input menu pertama
	li $v0, 5
	syscall 
	add $t2, $zero, $v0 # input menu pertama disimpan ke dalam register $t2
	
	# print menu kedua
	li $v0, 4
	la $a0, harga_beli_bahan_msg
	syscall
	
	# input menu kedua
	li $v0, 5
	syscall
	add $t3, $zero, $v0 # input menu kedua disimpan ke dalam register $t3
	
	# print menu ketiga
	li $v0, 4
	la $a0, harga_jual_msg
	syscall
	
	# input menu ketiga
	li $v0, 5
	syscall
	add $t4, $zero, $v0 # input menu kedua disimpan ke dalam register $t4
	
	addi $t0, $t0, 1 # increment i++
	 
	j while
	
summary:
	# print(new_line)
	li $v0, 4
	la $a0, new_line
	syscall

	# print(total_pengeluaran_msg)
	li $v0, 4
	la $a0, total_pengeluaran_msg
	syscall
	
	# print(new_line)
	li $v0, 4
	la $a0, new_line
	syscall
	
	# print(total_pendapatan_msg)
	li $v0, 4
	la $a0, total_pendapatan_msg
	syscall

	# print(new_line)
	li $v0, 4
	la $a0, new_line
	syscall
	
	# print(total_laba_msg)
	li $v0, 4
	la $a0, total_laba_msg
	syscall
	
	# print(new_line)
	li $v0, 4
	la $a0, new_line
	syscall
	
	j exit
	
exit:
	li $v0, 10
	syscall