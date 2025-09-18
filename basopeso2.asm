# ============================================
# Latihan B - Sae Ro Ni Bagi-Bagi
# File: latihan_1_b.asm
# Deskripsi: Membagi B bola ke T teman tanpa instruksi terlarang.
# Metode: Pembagian dengan pengurangan berulang (quotient ++, remainder -= T)
# ============================================

.data
prompt1:     .asciiz "=== Pembagian Bola Golf ===\n"
prompt_b:    .asciiz "Jumlah bola golf: "
prompt_t:    .asciiz "Jumlah teman: "
not_even:    .asciiz "Yah, Sae Ro Ni tidak bisa membagi bola golf secara merata. :(\n"
sisa_label:  .asciiz "Sisa bola: "
even_pref:   .asciiz "Yay! Setiap teman mendapat "
even_suf:    .asciiz " bola golf! :D\n"
newline:     .asciiz "\n"

.text
.globl main
main:
    # Tampilkan header & minta input B
    li $v0, 4
    la $a0, prompt1
    syscall

    li $v0, 4
    la $a0, prompt_b
    syscall

    li $v0, 5      # read integer
    syscall
    move $t0, $v0  # $t0 = B (jumlah bola)

    # Minta input T
    li $v0, 4
    la $a0, prompt_t
    syscall

    li $v0, 5
    syscall
    move $t1, $v0  # $t1 = T (jumlah teman)

    # Inisialisasi quotient dan remainder
    li $t2, 0      # $t2 = quotient (jumlah bola per teman)
    move $t3, $t0  # $t3 = remainder (sisa), mulai = B

    # Guard: jika T == 0 (tidak diharapkan menurut spesifikasi, tapi aman)
    beq $t1, $zero, div_by_zero

div_loop:
    # Jika remainder < T maka selesai
    slt $t4, $t3, $t1   # $t4 = 1 jika remainder < T
    bne $t4, $zero, div_end

    # remainder >= T -> remainder -= T ; quotient++
    sub $t3, $t3, $t1
    addi $t2, $t2, 1
    j div_loop

div_end:
    # Jika remainder == 0 -> bisa dibagi rata
    beq $t3, $zero, print_even

    # Jika remainder != 0 -> tidak bisa dibagi rata
    li $v0, 4
    la $a0, not_even
    syscall

    li $v0, 4
    la $a0, sisa_label
    syscall

    li $v0, 1
    move $a0, $t3   # cetak sisa
    syscall

    # newline agar rapi
    li $v0, 4
    la $a0, newline
    syscall

    j exit

print_even:
    # Cetak pesan sukses beserta jumlah per teman (quotient)
    li $v0, 4
    la $a0, even_pref
    syscall

    li $v0, 1
    move $a0, $t2
    syscall

    li $v0, 4
    la $a0, even_suf
    syscall

    j exit

div_by_zero:
    # Penanganan T == 0: tampilkan pesan tidak bisa dibagi + sisa = B
    li $v0, 4
    la $a0, not_even
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

exit:
    li $v0, 10
    syscall
