#include <stdio.h>   // 验证文件包含处理
#define edison main  // 为了验证宏定义，我故意将 main 定义为 edison
int edison() {
    int a, b, i, t, n;
    // 这是一个单行注释，用于测试预处理器的注释消除功能
    a = 0;
    b = 1;
    i = 1;
    scanf("%d", &n); // 读取输入的整数n
    printf("%d\n", a);
    printf("%d\n", b); // 输出a和b的值
    /*
     这是一个多行注释
     斐波那契数列的计算
    */
    while (i < n) {
        t = b;
        b = a + b;
        printf("%d\n", b);
        a = t;
        i = i + 1;
    }
    return 0;
}