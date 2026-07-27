// Microsoft packed 8-bytes MBF format decoder

// This FP format was used on:
//   MSX
//   Tandy M100
//   Kyocera KC85
//   Olivetti M10


#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

int main(int argc, char *argv[])
{
    uint8_t b[8];

    if (argc != 2) {
        fprintf(stderr, "usage: %s <16 hex digits>\n", argv[0]);
        return 1;
    }

    if (strlen(argv[1]) != 16) {
        fprintf(stderr, "need exactly 16 hex digits\n");
        return 1;
    }

    for (int i = 0; i < 8; i++) {
        char tmp[3];
        tmp[0] = argv[1][i * 2];
        tmp[1] = argv[1][i * 2 + 1];
        tmp[2] = 0;
        b[i] = (uint8_t)strtoul(tmp, NULL, 16);
    }

    int sign = (b[0] & 0x80) ? -1 : 1;
    int exp10 = (b[0] & 0x7f) - 0x40;

    int digit[15];

    digit[0] = (b[1] >> 4) & 0x0f;
    digit[1] = b[1] & 0x0f;

    int k = 2;

    for (int i = 2; i < 8; i++) {
        digit[k++] = (b[i] >> 4) & 0x0f;
        digit[k++] = b[i] & 0x0f;
    }

    double mant = 0.0;
    double p = 0.1;

    for (int i = 0; i < 14; i++) {
        mant += digit[i] * p;
        p *= 0.1;
    }

    double value = sign * mant * pow(10.0, exp10);

    printf("%.14f\n", value);

    return 0;
}
