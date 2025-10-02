# Nama : Muhammad Azka Awliya
# NPM   : 2406431510
# Latihan B: Ketua BEM

.data
    menu: .asciiz "\nSelamat datang di SiBEM, berikut adalah calon ketua BEM terpilih:\n1. Frank\n2. Prima\n3. Salim\n"
    tanya: .asciiz "Silakan masukkan nomor urut calon yang ingin anda pilih: "
    golput: .asciiz "\nAnda tidak diperkenankan untuk golput. Silakan pilih kembali.\n"
    hasil1: .asciiz "\nTerima kasih! Anda telah memilih Frank dengan nomor urut 1\n"
    hasil2: .asciiz "\nTerima kasih! Anda telah memilih Prima dengan nomor urut 2\n"
    hasil3: .asciiz "\nTerima kasih! Anda telah memilih Salim dengan nomor urut 3\n"

.text
.globl main
main:
    li $v0, 4
    la $a0, menu
    syscall

    li $v0, 4
    la $a0, tanya
    syscall

    li $v0, 5
    syscall
    move $t0, $v0

    beq $t0, $zero, cetak_golput

    li $t1, 1
    beq $t0, $t1, pilih1

    li $t1, 2
    beq $t0, $t1, pilih2

    li $t1, 3
    beq $t0, $t1, pilih3

    j main

cetak_golput:
    li $v0, 4
    la $a0, golput
    syscall
    j main

pilih1:
    li $v0, 4
    la $a0, hasil1
    syscall
    li $v0, 10
    syscall

pilih2:
    li $v0, 4
    la $a0, hasil2
    syscall
    li $v0, 10
    syscall

pilih3:
    li $v0, 4
    la $a0, hasil3
    syscall
    li $v0, 10
    syscall
