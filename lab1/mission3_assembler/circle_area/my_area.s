# my_area.s
.file "circle_area.c"

# --- 编译属性 ---
.option nopic
.attribute arch, "rv64i2p1_m2p0_a2p1_f2p2_d2p2_c2p0"
.attribute unaligned_access, 0
.attribute stack_align, 16

# --- 只读数据段 ---
.section .rodata
.align 3
.LC0:
    .string "Enter the radius of the circle: "
.align 3
.LC1:
    .string "%f"
.align 3
.LC2:
    .string "The area is: %f\n"

# --- 数据段 ---
.data
.align 2
PI:
    .float 3.14159

# --- 代码段 ---
.text
.globl main
.type main, @function

main:
    # Prologue: 开辟16字节栈帧
    addi sp, sp, -16
    sd ra, 8(sp)

    # 打印提示信息
    la a0, .LC0
    call printf

    # 读取半径, 存放在0(sp)
    la a0, .LC1
    addi a1, sp, 0
    call scanf

    # 加载操作数到浮点寄存器
    la t0, PI
    flw fa0, 0(t0)    # fa0 = PI
    flw fa1, 0(sp)    # fa1 = radius

    # 核心计算: area = PI * r * r
    fmul.s fa2, fa0, fa1  # fa2 = PI * radius
    fmul.s fa2, fa2, fa1  # fa2 = (PI * radius) * radius

    # 打印结果
    la a0, .LC2
    fcvt.d.s fa0, fa2   # 步骤1: 将float结果转为double
    fmv.x.d a1, fa0     # 步骤2: 将double的二进制位移入整数寄存器a1
    call printf

    # exit系统调用
    li a0, 0
    li a7, 93
    ecall

.size main, .-main