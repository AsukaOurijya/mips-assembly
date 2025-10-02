# Nama : Muhammad Azka Awliya
# NPM  : 2406431510
# Latihan 1 A 

.data
	input1: .asciiz "=== Scorecard Golf Sae Ro Ni ===\n"
	input2: .asciiz "Jumlah hole yang dimainkan: "
	input3: .asciiz "Hole ke-"
	input4: .asciiz ":\nPar berapa? (3/4/5): "
	input5: .asciiz "Jumlah pukulan: "
	result1: .asciiz "=== Hasil Permainan Golf ===\n"
	result2: .asciiz "Total Par: "
	result3: .asciiz "Total Pukulan: "
	result4: .asciiz "Selisih dengan Par: "
	result5: .asciiz "Total Poin Bonus: "
	msg1: .asciiz "Hebat! Sae Ro Ni bermain di bawah par! :D\n"
	msg2: .asciiz "Bagus! Sae Ro Ni tepat sesuai par!\n"
	msg3: .asciiz "Tidak apa-apa, Sae Ro Ni! Latihan lagi ya! :)\n"
	divider: .asciiz "--------------------\n"
	newline:  .asciiz "\n"

.text
.globl main
main:
	# Print header
	li $v0, 4
	la $a0, input1
	syscall

	# Prompt jumlah hole
	li $v0, 4
	la $a0, input2
	syscall

	# Read jumlah hole (N)
	li $v0, 5
	syscall
	# simpan N di $t0
	add $t0, $v0, $zero

	# Inisialisasi akumulator
	li $t1, 0    # total par
	li $t2, 0    # total pukulan
	li $t3, 0    # total bonus
	li $t4, 1    # counter hole (start 1)

iterasi_hole:
	# Print divider
	li $v0, 4
	la $a0, divider
	syscall

	# Print "Hole ke-"
	li $v0, 4
	la $a0, input3
	syscall

	# Print nomor hole (integer)
	li $v0, 1
	add $a0, $t4, $zero
	syscall

	# Print prompt par
	li $v0, 4
	la $a0, input4
	syscall

	# Read par (3/4/5)
	li $v0, 5
	syscall
	add $t5, $v0, $zero    # simpan par di $t5

	# Print prompt jumlah pukulan
	li $v0, 4
	la $a0, input5
	syscall

	# Read pukulan aktual
	li $v0, 5
	syscall
	add $t6, $v0, $zero    # simpan pukulan di $t6

	# Tambah ke total par dan total pukulan
	add $t1, $t1, $t5
	add $t2, $t2, $t6

	# Hitung apakah ada bonus: jika pukulan < par
	# Ganti blt dengan slt + bne
	slt $s1, $t6, $t5      # s1 = 1 jika t6 < t5
	bne $s1, $zero, bonus_section
	# jika tidak ada bonus, lompat ke no_bonus
	j no_bonus

bonus_section:
	# selisih = par - pukulan
	sub $t7, $t5, $t6

	# kali selisih * 10 dengan penjumlahan berulang
	li $t8, 0      # hasil sementara
	li $t9, 10     # counter = 10

bonus_iterasi:
	beq $t9, $zero, bonus_done
	add $t8, $t8, $t7
	addi $t9, $t9, -1
	j bonus_iterasi

bonus_done:
	add $t3, $t3, $t8   # total bonus += hasil

no_bonus:
	# next hole
	addi $t4, $t4, 1

	# cek apakah t4 <= t0 (lanjut loop)
	# implementasi: if (t4 < t0) goto iterasi_hole; else if (t4 == t0) goto iterasi_hole
	slt $s1, $t4, $t0
	bne $s1, $zero, iterasi_hole
	beq $t4, $t0, iterasi_hole

	# Print hasil akhir
	li $v0, 4
	la $a0, result1
	syscall

	# Total Par label & value
	li $v0, 4
	la $a0, result2
	syscall
	li $v0, 1
	add $a0, $t1, $zero
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	# Total Pukulan label & value
	li $v0, 4
	la $a0, result3
	syscall
	li $v0, 1
	add $a0, $t2, $zero
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	# Selisih label & value (total pukulan - total par)
	li $v0, 4
	la $a0, result4
	syscall
	sub $s0, $t2, $t1
	li $v0, 1
	add $a0, $s0, $zero
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	# Total Bonus label & value
	li $v0, 4
	la $a0, result5
	syscall
	li $v0, 1
	add $a0, $t3, $zero
	syscall
	li $v0, 4
	la $a0, newline
	syscall

	# Pesan motivasi: gunakan slt + bne untuk cek <
	slt $s1, $t2, $t1
	bne $s1, $zero, pesan_kurangdari
	# cek equal
	beq $t2, $t1, pesan_samadengan
	j pesan_selesai

pesan_kurangdari:
	li $v0, 4
	la $a0, msg1
	syscall
	j keluar

pesan_samadengan:
	li $v0, 4
	la $a0, msg2
	syscall
	j keluar

pesan_selesai:
	li $v0, 4
	la $a0, msg3
	syscall
	j keluar

keluar:
	li $v0, 10
	syscall
