#include <stdio.h>

int main() {
    // 定义一个浮点数常量 PI
    const float PI = 3.14159;
    float radius;
    float area;

    // 提示并读取用户输入的半径
    printf("Enter the radius of the circle: ");
    scanf("%f", &radius);

    // 计算面积: area = PI * radius * radius
    area = PI * radius * radius;

    // 输出结果
    printf("The area is: %f\n", area);

    return 0;
}