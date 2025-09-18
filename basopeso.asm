# ============================================
# Latihan A - Sae Ro Ni Golf Adventure
# File: latihan_1_a.asm
# ============================================

.data
input1:   .asciiz "=== Scorecard Golf Sae Ro Ni ===\n"
input2:   .asciiz "Jumlah hole yang dimainkan: "
input3:   .asciiz "Hole ke-"
input4:   .asciiz ":\nPar berapa? (3/4/5): "
input5:   .asciiz "Jumlah pukulan: "
divider:  .asciiz "--------------------\n"

result1:  .asciiz "=== Hasil Permainan Golf ===\n"
result2:  .asciiz "Total Par: "
result3:  .asciiz "Total Pukulan: "
result4:  .asciiz "Selisih dengan Par: "
result5:  .asciiz "Total Poin Bonus: "

msg1: .asciiz "Hebat! Sae Ro Ni bermain di bawah par! :D\n"
msg2: .asciiz "Bagus! Sae Ro Ni tepat sesuai par!\n"
msg3: .asciiz "Tidak apa-apa, Sae Ro Ni! Latihan lagi ya! :)\n"

newline:  .asciiz "\n"

.text
.globl main
main:
    # Tampilkan judul input
    li $v0, 4
    la $a0, input1
    syscall

    # Minta jumlah hole
    li $v0, 4
    la $a0, input2
    syscall

    li $v0, 5
    syscall
    move $t0, $v0       # $t0 = jumlah hole (N)

    # Inisialisasi variabel akumulasi
    li $t1, 0   # total par
    li $t2, 0   # total pukulan
    li $t3, 0   # total bonus
    li $t4, 1   # counter hole

loop_hole:
    # Cetak divider
    li $v0, 4
    la $a0, divider
    syscall

    # Cetak "Hole ke-"
    li $v0, 4
    la $a0, input3
    syscall

    # Cetak nomor hole
    li $v0, 1
    move $a0, $t4
    syscall

    # Cetak ":\nPar berapa? (3/4/5): "
    li $v0, 4
    la $a0, input4
    syscall

    # Input par
    li $v0, 5
    syscall
    move $t5, $v0       # $t5 = par

    # Cetak "Jumlah pukulan: "
    li $v0, 4
    la $a0, input5
    syscall

    # Input pukulan
    li $v0, 5
    syscall
    move $t6, $v0       # $t6 = pukulan

    # Tambahkan ke total
    add $t1, $t1, $t5   # total par += par
    add $t2, $t2, $t6   # total pukulan += pukulan

    # Hitung bonus
    blt $t6, $t5, bonus_case
    j no_bonus

bonus_case:
    sub $t7, $t5, $t6   # selisih = par - pukulan

    # Perkalian selisih * 10 dengan penjumlahan berulang
    li $t8, 0           # hasil sementara
    li $t9, 10          # faktor kali (10)
bonus_loop:
    beqz $t9, bonus_done
    add $t8, $t8, $t7
    addi $t9, $t9, -1
    j bonus_loop

bonus_done:
    add $t3, $t3, $t8   # total bonus += hasil
    j end_bonus

no_bonus:
    # bonus = 0, tidak menambah apapun
    addu $zero, $zero, $zero

end_bonus:
    addi $t4, $t4, 1    # next hole
    ble $t4, $t0, loop_hole

    # Cetak hasil akhir
    li $v0, 4
    la $a0, result1
    syscall

    # Total Par
    li $v0, 4
    la $a0, result2
    syscall
    li $v0, 1
    move $a0, $t1
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Total Pukulan
    li $v0, 4
    la $a0, result3
    syscall
    li $v0, 1
    move $a0, $t2
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Selisih
    li $v0, 4
    la $a0, result4
    syscall
    sub $s0, $t2, $t1   # selisih = total pukulan - total par
    li $v0, 1
    move $a0, $s0
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Total Bonus
    li $v0, 4
    la $a0, result5
    syscall
    li $v0, 1
    move $a0, $t3
    syscall
    li $v0, 4
    la $a0, newline
    syscall

    # Cetak pesan motivasi
    blt $t2, $t1, msg_under
    beq $t2, $t1, msg_equal
    j msg_over

msg_under:
    li $v0, 4
    la $a0, msg1
    syscall
    j exit

msg_equal:
    li $v0, 4
    la $a0, msg2
    syscall
    j exit

msg_over:
    li $v0, 4
    la $a0, msg3
    syscall

exit:
    li $v0, 10
    syscall
