#include <inttypes.h>


uint64_t bit_manip(uint64_t num) {
    uint64_t *rightmost = num & 0b1111111111111111111111111111111;
    uint64_t *middle = (num >> 31) & 0b1111111111111111111111111111111;
    uint64_t *trail = (num >> 62);

//rotate bits left by 23 bits= rotate right by 8 bits
    *rightmost = (*rightmost >> 8) & ((*rightmost & 0b11111111)) << 23);
    *middle = (*middle >> 8) & ((*middle & 0b11111111)) << 23);
    *trail = (*trail >> 8) & ((*trail & 0b11111111)) << 23);
//create masks
    uint64_t maskON = 1 << 17;
    uint64_t maskOFF = 1 << 27;
//turn on bit 17
    *rightmost = (*rightmost & ~maskON) | ((1 << 17) & maskON);
    *middle = (*middle & ~maskON) | ((1 << 17) & maskON);
    *trail = (*trail & ~maskON) | ((1 << 17) & maskON);
//turns off bit 27
    *rightmost = (*rightmost & ~maskOFF) | ((0 << 27) & maskOFF);
    *middle = (*middle & ~maskOFF) | ((0 << 27) & maskOFF);
    *trail = (*trail & ~maskOFF) | ((0 << 27) & maskOFF);
    return (*trail << 62 & *middle << 31 & *rightmost);
}
