.data
	jumlah_hari_msg: .asciiz "Masukkan jumlah hari: "
	hari_x_msg: .asciiz "Hari "
	jumlah_minuman_msg: .asciiz "Masukkan jumlah minuman terjual: "
	harga_beli_bahan_msg: .asciiz "Masukkan harga beli bahan per minuman: "
	harga_jual_msg: .asciiz "Masukkan harga jual per minuman: "

	total_pengeluaran_msg: .asciiz "Total pengeluaran untuk semua hari adalah Rp"
	total_pendapatan_msg: .asciiz "Total pendapatan untuk semua hari adalah Rp"

	untung_msg: .asciiz "Kedai kopi untung! Total keuntungan adalah Rp"
	rugi_msg: .asciiz "Kedai kopi rugi! Total kerugian adalah Rp"

	new_line: .asciiz "\n"
	divider: .asciiz "----------------------------"
	finished_msg: .asciiz "-- program is finished running --"

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
	# gunakan slt untuk cek (t7 = 1 jika N < i)
	slt $t7, $t1, $t0
	bne $t7, $zero, summary

	# Print newline
	li $v0, 4
	la $a0, new_line
	syscall

	# Print divider
	li $v0, 4
	la $a0, divider
	syscall

	# Print newline after divider
	li $v0, 4
	la $a0, new_line
	syscall

	# Print "Hari "
	li $v0, 4
	la $a0, hari_x_msg
	syscall

	# Print nilai i (hari ke-...)
	li $v0, 1
	add $a0, $t0, $zero
	syscall

	# Print newline (no colon as in contoh)
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
	# gunakan mult + mflo (bukan instruksi 'mul' yang dilarang)
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
	# Print newline (keamanan)
	li $v0, 4
	la $a0, new_line
	syscall

	# Print divider sebelum ringkasan (sesuai contoh)
	li $v0, 4
	la $a0, divider
	syscall

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

	# ========== Cek untung atau rugi ==========
	# jika total_pendapatan < total_pengeluaran -> rugi
	slt $t8, $s1, $s0        # t8 = 1 jika s1 < s0 (pendapatan < pengeluaran)
	bne $t8, $zero, do_rugi

	# else -> untung (termasuk sama besar -> keuntungan 0)
	li $v0, 4
	la $a0, untung_msg
	syscall

	# keuntungan = s1 - s0
	sub $t9, $s1, $s0
	li $v0, 1
	add $a0, $t9, $zero
	syscall

	# newline
	li $v0, 4
	la $a0, new_line
	syscall

	j finish

do_rugi:
	# hitung kerugian = s0 - s1
	sub $t9, $s0, $s1

	li $v0, 4
	la $a0, rugi_msg
	syscall

	li $v0, 1
	add $a0, $t9, $zero
	syscall

	# newline
	li $v0, 4
	la $a0, new_line
	syscall

finish:
	# print finished message
	li $v0, 4
	la $a0, finished_msg
	syscall

	# newline
	li $v0, 4
	la $a0, new_line
	syscall

	# exit
	li $v0, 10
	syscall
