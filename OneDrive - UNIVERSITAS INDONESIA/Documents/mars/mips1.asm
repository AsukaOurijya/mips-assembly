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
	msg1: .asciiz "Hebat! Sae Ro Ni bermain di bawah par! :D\n"
	msg2: .asciiz "Bagus! Sae Ro Ni tepat sesuai par!\n"
	msg3: .asciiz "Tidak apa-apa, Sae Ro Ni! Latihan lagi ya! :)\n"
	divider: .asciiz "--------------------\n"

.globl main 
main:
	# Melakukan print header scoreboard
	li $v0, 4
	la $a0, input1
	syscall
	
	# Melakukan print pertanyaan jumlah hole
	li $v0, 4
	la $a0, input2
	syscall
	
	# Mengambil input dari user
	li $v0, 5 # Input harus berupa integer
	syscall
	move $t0, $v0
	
	# Inisialisasi
	li $t1, 0 # total par 
	li $t2, 0 # total pukulan
	li $t3, 0 # total bonus
	li $t4, 1 # counter hole
	
iterasi_hole:
	# Melakukan print divider
	li $v0, 4
	la $a0, divider
	syscall 
	
	# Melakukan print "Hole ke-i"
	li $v0, 4
	la $a0, input3
	syscall
	
	# Mengupdate nomor hole
	li $v0, 1
	move $a0, $t4
	syscall
	
	# Melakukan print "Par berapa?"
	li $v0, 4
	la $a0, input4
	syscall
	
	# Mengambil input jumlah par dalam bentuk integer
	li $v0, 5
	syscall
	move $t5, $v0
	
	# Melakukan print "Jumlah Pukulan"
	li $v0, 4
	la $a0, input5
	syscall
	
	# Mengambil input jumlah pukulan dalam bentuk integer
	li $v0, 5
	syscall
	move $t6, $v0
	
	# Melakukan increment pada total masing2
	add $t1, $t1, $t5 # total par += par
	add $t2, $t2, $t6 # total pukulan += pukulan
	
	# Perhitungan bonus
	blt $t6, $t5, bonus_section
	j no_bonus
	
bonus_section:

bonus_loop:

bonus_done:

no_bonus:

end_bonus:

pesan_bawah:

pesan_sama:

pesan_selesai:

keluar:
	li $v0, 10
	syscall