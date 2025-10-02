# Nama : Muhammad Azka Awliya
# NPM   : 2406431510
#  Latihan 2 

.data
	rata_rata:    	   	.asciiz "Rata-rata curah hujan: "
	mm:     		   	.asciiz " mm\n"
	persentase_kering: 	.asciiz "Persentase hari kering: "
	persentase_basah: 	.asciiz "Persentase hari basah: "
	enter:    		.asciiz "%\n"
	hasil_ok:     		.asciiz "Lina bisa bercocok tanam\n"
	hasil_no:     		.asciiz "Lina menunda bercocok tanam\n"
	curah_hujan: .word 18, 20, 25, 30, 12, -1 

.text
.globl main
main:
    la   $s0, curah_hujan    # bekerja sebagao pointer 
    li   $t0, 0              # Inisialisasi $t0 = sum
    li   $t1, 0              # Inisialisasi $t1 = total hari (count)
    li   $t2, 0              # Inisialisasi $t2 = jumlah hari kering (<10)
    li   $t3, 0              # Inisialisasi $t3 = jumlah hari basah (>=10)

# loop baca array sampai -1
loop_read:
    lw   $t4, 0($s0)  
    li   $t5, -1
    beq  $t4, $t5, compute
    addi $t1, $t1, 1         # Increment $t1
    add  $t0, $t0, $t4       # Increment $t0

    slti $t6, $t4, 10
    bne  $t6, $zero, cek_kering
    addi $t3, $t3, 1
    j    lanjut_iterasi
    
cek_kering:
    addi $t2, $t2, 1
    
lanjut_iterasi:
    addi $s0, $s0, 4         # maju ke elemen berikutnya
    j    loop_read

# jika tidak ada hari (total==0), set semua hasil ke 0
compute:
    beq  $t1, $zero, hasil_zero

    # rata-rata 
    div  $t0, $t1            # quotient di LO
    mflo $t6                # $t6 = average

    # persentase kering 
    li   $t7, 100
    mult $t2, $t7
    mflo $t8
    div  $t8, $t1
    mflo $t9

    # persentase basah 
    mult $t3, $t7
    mflo $s7              
    div  $s7, $t1
    mflo $s6              

    j    hasil

# jika total masing-masing hari 0 
hasil_zero:
    li   $t6, 0
    li   $t9, 0
    li   $s6, 0

hasil:
    # Melakukan print "Rata-rata curah hujan: "
    la   $a0, rata_rata
    li   $v0, 4
    syscall

    # Melakukan print average (integer)
    move $a0, $t6
    li   $v0, 1
    syscall

    # Melakukan print satuan mm
    la   $a0, mm
    li   $v0, 4
    syscall

    # Melakukan print persentase hari kering:
    la   $a0, persentase_kering
    li   $v0, 4
    syscall

    # Melakukan print persen kering dalam integer
    move $a0, $t9
    li   $v0, 1
    syscall

    # Melakukan print persen
    la   $a0, enter
    li   $v0, 4
    syscall

    # Melakukan print persentase hari basah
    la   $a0, persentase_basah
    li   $v0, 4
    syscall

    # Melakukan print persen basah dalam integer
    move $a0, $s6
    li   $v0, 1
    syscall

    # Melakukan print persentase
    la   $a0, enter
    li   $v0, 4
    syscall

    # jika persentase kering >= 50% -> bisa bercocok tanam
    slti $s5, $t9, 50      
    beq  $s5, $zero, bisa_tanam

    # jika persen_kering < 50
    la   $a0, hasil_no
    li   $v0, 4
    syscall
    j    keluar

bisa_tanam:
    la   $a0, hasil_ok
    li   $v0, 4
    syscall

keluar:
    li   $v0, 10
    syscall
	
	