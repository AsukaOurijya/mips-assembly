# Nama : Muhammad Azka Awliya
# NPM   : 2406431510
# Latihan A: Interview

.data
    pertanyaan1: .asciiz "Siapakah nama Anda? "
    pertanyaan2: .asciiz "Anda angkatan tahun berapa? "
    pertanyaan3: .asciiz "Apa motivasi anda maju menjadi ketua BEM? "

    nama: .space 20
    motivasi: .space 50

    output0: .asciiz "\n"
    output1: .asciiz "\nHalo mas Peokra, perkenalkan nama saya "
    output2: .asciiz "\nDari angkatan tahun "
    output3: .asciiz "\nDan motivasi saya adalah "

.text
.globl main 
main:
    # Pertanyaan 1
    li $v0, 4
    la $a0, pertanyaan1
    syscall

    # Input nama (string)
    li $v0, 8
    la $a0, nama
    li $a1, 20
    syscall

    # Pertanyaan 2
    li $v0, 4
    la $a0, pertanyaan2
    syscall

    # Input angkatan (integer)
    li $v0, 5
    syscall
    move $t2, $v0

    # Pertanyaan 3
    li $v0, 4
    la $a0, pertanyaan3
    syscall

    # Input motivasi (string)
    li $v0, 8
    la $a0, motivasi
    li $a1, 50
    syscall

    # Output nama
    li $v0, 4
    la $a0, output1
    syscall

    li $v0, 4
    la $a0, nama
    syscall

    # Output angkatan
    li $v0, 4
    la $a0, output2
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    # Output motivasi
    li $v0, 4
    la $a0, output3
    syscall

    li $v0, 4
    la $a0, motivasi
    syscall

    # Exit
    li $v0, 10
    syscall
	