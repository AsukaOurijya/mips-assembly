.data
	msg1: .asciiz "Frekuensi: "
	msg2: .asciiz "Data dengan frekuensi terbesar adalah "
	msg3: .asciiz " (muncul "
	msg4: .asciiz " kali)\n"
	divider: .asciiz "\n=============================\n"
	space: .asciiz " "
   	nilai_kepuasan: .word 1, 1, 1, 1, 1
	nk_length: .word 5

.text
.globl main
main:
    #  Melakukan load array address dan panjang array
    la $t0, nilai_kepuasan
    lw $t1, nk_length
    
    # Melakukan print "Frekuensi: "
    li $v0, 4
    la $a0, msg1
    syscall
    
    # Loop untuk setiap elemen, hitung dan print frekuensinya
    li $t2, 0
    
loop_print_freq:
    beq $t2, $t1, after_print_freq  # jika i sama dengan length, keluar
    
    # Load nilai array[i]
    sll $t3, $t2, 2             
    add $t3, $t0, $t3       
    lw $t4, 0($t3) 
    
    # Hitung frekuensi nilai ini di seluruh array
    li $t5, 0                   
    li $t6, 0                  
    
count_freq:
    beq $t6, $t1, done_count    # jika j sama dengan length, selesai hitung
    
    # Load array[j]
    sll $t7, $t6, 2             
    add $t7, $t0, $t7           
    lw $t8, 0($t7)             
    
    # Cek apakah array[j] sama dengan array[i]
    bne $t8, $t4, skip_increment
    addi $t5, $t5, 1            # increment frekuensi
    
skip_increment:
    addi $t6, $t6, 1            # increment j
    j count_freq
    
done_count:
    # Print frekuensi
    li $v0, 1
    move $a0, $t5
    syscall
    
    # Print spasi jika bukan elemen terakhir
    addi $t9, $t1, -1
    beq $t2, $t9, skip_space    
    
    li $v0, 4
    la $a0, space
    syscall
    
skip_space:
    addi $t2, $t2, 1            # increment i
    j loop_print_freq
    
after_print_freq:
    # Melakukan print divider
    li $v0, 4
    la $a0, divider
    syscall
    
    # Cari nilai dengan frekuensi terbesar dan inisialisasi counter, max_freq, max_value, index pertama
    li $t2, 0                   
    li $s0, 0                   
    li $s1, 0                   
    li $s2, -1                  
    
find_max_loop:
    beq $t2, $t1, after_find_max    # jika i sama dengan length, keluar
    
    # Load nilai array[i]
    sll $t3, $t2, 2             
    add $t3, $t0, $t3           
    lw $t4, 0($t3)             
    
    # Cek apakah nilai ini sudah pernah diproses sebelumnya
    li $t6, 0                   
    
check_duplicate:
    beq $t6, $t2, not_duplicate # jika j sama dengan i, tidak ada duplikasi sebelumnya
    
    # Load array[j]
    sll $t7, $t6, 2      
    add $t7, $t0, $t7
    lw $t8, 0($t7)     
    
    # Jika array[j] sama dengan array[i], skip (sudah dihitung)
    beq $t8, $t4, skip_this_value
    
    addi $t6, $t6, 1            #  increment j
    j check_duplicate
    
not_duplicate:
    # Hitung frekuensi nilai ini
    li $t5, 0                   # $t5 = counter frekuensi
    li $t6, 0                   # $t6 = counter untuk loop dalam (j)
    
count_freq_max:
    beq $t6, $t1, done_count_max    # jika j == length, selesai
    
    # Load array[j]
    sll $t7, $t6, 2             # $t7 = j * 4
    add $t7, $t0, $t7           # $t7 = address array[j]
    lw $t8, 0($t7)              # $t8 = nilai array[j]
    
    # Cek apakah array[j] == array[i]
    bne $t8, $t4, skip_increment_max
    addi $t5, $t5, 1            # increment frekuensi 
       
skip_increment_max:
    addi $t6, $t6, 1            # increment j
    j count_freq_max
    
done_count_max:
    # Cek apakah frekuensi ini > max_freq
    slt $t9, $s0, $t5         
    beq $t9, $zero, skip_update_max
    
    # Update maksimum
    move $s0, $t5
    move $s1, $t4               
    
skip_update_max:
skip_this_value:
    addi $t2, $t2, 1            # increment i
    j find_max_loop
    
after_find_max:
    # Melakukan print hasil
    # "Data dengan frekuensi terbesar adalah "
    li $v0, 4
    la $a0, msg2
    syscall
    
    # Melakukan print nilai
    li $v0, 1
    move $a0, $s1
    syscall
    
    # Melakukan print " (muncul "
    li $v0, 4
    la $a0, msg3
    syscall
    
    # Melakukan print frekuensi
    li $v0, 1
    move $a0, $s0
    syscall
    
    #  Melakukan print " kali)\n"
    li $v0, 4
    la $a0, msg4
    syscall
    
    # Exit program
    li $v0, 10
    syscall