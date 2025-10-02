# Nama : Muhammad Azka Awliya
# NPM   : 2406431510
# Latihan 1 B

.data
	header: .asciiz "=== Pembagian Bola Golf ===\n"
	input1: .asciiz "Jumlah bola golf: "
	input2: .asciiz "Jumlah teman: "
	tidak_rata: .asciiz "Yah, Sae Ro Ni tidak bisa membagi bola golf secara merata. :(\n"
	sisa_label: .asciiz "sisa bola: "
	teman_dapat: .asciiz "Yay! Setiap teman mendapat "
	bola_golf: .asciiz " bola golf! :D\n"
	newline: .asciiz "\n"

.text
.globl main
main:
   	# Tampilkan header & minta input B
    	li $v0, 4
    	la $a0, header
    	syscall

	# Mengambil input jumlah bola golf 
    	li $v0, 4
    	la $a0, input1
    	syscall

    	li $v0, 5      # 
    	syscall
   	move $t0, $v0  

    	# Minta input jumlah teman
    	li $v0, 4
    	la $a0, input2
    	syscall

    	li $v0, 5
    	syscall
    	move $t1, $v0 

    	# Inisialisasi pembagi dan sisa
    	li $t2, 0     
    	move $t3, $t0  # $t3 = sisa

   	 # jika pembagi adalah 0
    	beq $t1, $zero, div_by_zero

div_loop:
    	# Jika sisa < pembagi maka selesai
    	slt $t4, $t3, $t1   
    	bne $t4, $zero, div_end

    	sub $t3, $t3, $t1
    	addi $t2, $t2, 1
    	j div_loop

div_end:
    	beq $t3, $zero, print_even

    	li $v0, 4
    	la $a0, tidak_rata
    	syscall

    	li $v0, 4
    	la $a0, sisa_label
    	syscall

	# cetak sisa
    	li $v0, 1
    	move $a0, $t3
    	syscall

    	li $v0, 4
    	la $a0, newline
    	syscall

    	j keluar

print_even:
    	# Cetak pesan sukses beserta jumlah per teman (pembagi)
    	li $v0, 4
    	la $a0, teman_dapat
    	syscall

    	li $v0, 1
    	move $a0, $t2
    	syscall

    	li $v0, 4
    	la $a0, teman_dapat
    	syscall

   	 j keluar

div_by_zero:
    # Menangani jika pembagi == 0
    	li $v0, 4
    	la $a0, tidak_rata
    	syscall

    	li $v0, 4
    	la $a0, sisa_label
    	syscall

    	li $v0, 1
    	move $a0, $t3
    	syscall

    	li $v0, 4
    	la $a0, newline
    	syscall

keluar:
    	li $v0, 10
    	syscall
