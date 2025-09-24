# my_fib.s
# 描述源文件名
.file "main.c"

# --- 编译属性 ---
.option nopic
.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0"
.attribute unaligned_access, 0
.attribute stack_align, 16

# --- 只读数据段 (Read-Only Data) ---
.section .rodata
.align 3 # 8字节对齐以优化性能
.LC0:
    .string "%d"      # 用于 scanf
.align 3
.LC1:
    .string "%d\n"    # 用于 printf

# --- 代码段 ---
.text
.globl main         # 声明 main 是一个全局符号
.type main, @function # 声明 main 是一个函数

main:
    # --- Prologue: 开辟栈帧 ---
    # sp 是栈指针寄存器。栈的增长方向是从高地址到低地址，所以要减小 sp
    # 我们需要 5 个整数变量 (5 * 4 = 20 bytes) + 8 字节保存返回地址 ra
    # 栈需要16字节对齐，所以我们分配 32 字节 (最接近20+8且是16的倍数)
    addi sp, sp, -32

    # 保存返回地址 (ra) 和帧指针 (s0/fp)，这是良好习惯
    # ra 寄存器保存了函数调用结束后应该返回到哪里
    sd ra, 24(sp)  # sd = Store Doubleword (64-bit)
    sd s0, 16(sp)  # s0 将用作我们的帧指针 (Frame Pointer)
    addi s0, sp, 32 # s0 指向旧的栈顶，也就是当前栈帧的底部
    # --- 变量初始化 ---
    li t0, 0          # li = Load Immediate, t0 = 0
    sw t0, -20(s0)    # a = 0; sw = Store Word (32-bit)
    li t0, 1
    sw t0, -16(s0)    # b = 1
    sw t0, -12(s0)    # i = 1

    # --- 调用 scanf("%d", &n) ---
    # 参数1 (a0): 格式化字符串 "%d" 的地址
    la a0, .LC0       # la = Load Address, a0 = address of .LC0
    # 参数2 (a1): 变量 n 的地址
    addi a1, s0, -4   # a1 = s0 - 4 (address of n)
    # 调用函数
    call scanf
    # --- 调用 printf("%d\n", a) ---
    la a0, .LC1       # a0 = address of "%d\n"
    lw a1, -20(s0)    # a1 = a; lw = Load Word (从内存加载到寄存器)
    call printf

    # --- 调用 printf("%d\n", b) ---
    la a0, .LC1
    lw a1, -16(s0)    # a1 = b
    call printf
    # --- while (i < n) 循环 ---
.L_LOOP_COND: # 循环条件判断标签
    lw t0, -12(s0)    # t0 = i
    lw t1, -4(s0)     # t1 = n
    bge t0, t1, .L_LOOP_END # if (i >= n) then branch to end

.L_LOOP_BODY: # 循环体标签
    # t = b;
    lw t2, -16(s0)    # t2 = b
    sw t2, -8(s0)     # t = t2

    # b = a + b;
    lw t3, -20(s0)    # t3 = a
    lw t4, -16(s0)    # t4 = b
    addw t5, t3, t4   # t5 = a + b (addw: 32-bit add)
    sw t5, -16(s0)    # b = t5

    # printf("%d\n", b);
    la a0, .LC1
    mv a1, t5         # a1 = b (mv is a pseudo-instruction for addi a1, t5, 0)
    call printf

    # a = t;
    lw t6, -8(s0)     # t6 = t
    sw t6, -20(s0)    # a = t6

    # i = i + 1;
    lw t0, -12(s0)    # t0 = i
    addi t0, t0, 1    # t0 = t0 + 1
    sw t0, -12(s0)    # i = t0

    # 无条件跳转回循环条件判断
    j .L_LOOP_COND

.L_LOOP_END: # 循环结束标签
    # --- return 0; ---
    #li a0, 0          # 设置返回值为 0 (返回值通过 a0 寄存器传递)

    # --- Epilogue: 销毁栈帧 ---
    #ld ra, 24(sp)     # ld = Load Doubleword, 恢复之前保存的返回地址
    #ld s0, 16(sp)     # 恢复帧指针
    #addi sp, sp, 32   # 释放栈空间

    # 返回
    #jr ra             # jr = Jump Register, 跳转到 ra 中的地址

    # --- 通过exit系统调用结束程序，而非从main返回 ---
    # RISC-V 64位Linux的exit系统调用号是 93
    # 返回值放在 a0 寄存器中
    li a0, 0      # a0 = 0 (程序正常退出的返回值)
    li a7, 93     # a7 = 93 (exit系统调用号)
    ecall         # 执行系统调用，终止程序