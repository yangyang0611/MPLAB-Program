extern unsigned int divide(unsigned int a, unsigned int b);
#include<xc.h>

void main(void) {
    volatile unsigned int result = divide(255,13);
    volatile unsigned char quo = (result << 8) >> 8;
    volatile unsigned char rem = result >> 8;
    while(1)
        ;
    return;
}
