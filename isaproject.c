#include <stdio.h>

int sum_array(int *ia) {
    int s = 0;
    while (*ia != 0) {
        s += *ia;
        ia++; }
    return s; }

    int cmp_arrays(int *ia1, int *ia2) {
        int s1 = sum_array(ia1);
        int s2 = sum_array(ia2);
        printf("s1: %d, s2: %d\n", s1, s2);
        return s1 == s2 ? 0 : (s1 > s2 ? 1 : -1);
    }

int numelems(int *ia) {
    int c = 0;
    while (*ia++ != 0)
        c++;
    return c; }

    void sort(int *ia) {
        int s = numelems(ia);
        for (int i = 0; i < s; i++)
            for (int j = 0; j < s-1-i; j++)
                if (ia[j] > ia[j+1]) {
                    int t = ia[j];
                    ia[j] = ia[j+1];
                    ia[j+1] = t;
                }
    }

int smallest(int *ia) {
    int s = numelems(ia);
    int sm = *ia;
    for (int *p = ia; p < ia+s; p++)
        if (*p < sm)
            sm = *p;
    return sm; }

    int factorial(int n) {
        if (n == 1)
            return 1;
        else
            return n * factorial(n-1);
    }

static int sia[] = {50,43,100,-5,-10,50,0};
static int sib[] = {500,43,100,-5,-10,50,0};

int main() {
    int ia[] = {2,3,5,1,0};
    printf("cmp_arrays(sia, sib): %d\n", cmp_arrays(sia, sib));
    printf("cmp_arrays(sia, sia): %d\n", cmp_arrays(sia, sia));
    sib[0] = 4;
    printf("cmp_arrays(sia, sib): %d\n", cmp_arrays(sia, sib));
    printf("cmp_arrays(ia, sia): %d\n", cmp_arrays(ia, sia));
    sort(ia);
    for (int i = 0; i < numelems(ia); i++)
        printf("ia[%d]: %d\n", i, ia[i]);
    sort(sia);
    for (int i = 0; i < numelems(sia); i++)
        printf("sia[%d]: %d\n", i, sia[i]);
    printf("smallest(ia): %d\n", smallest(ia));
    printf("smallest(sia): %d\n", smallest(sia));
    if (smallest(ia) != ia[0])
        printf("Something bad\n");
    else
        printf("Nice sort and smallest\n");
    if (smallest(sia) != sia[0])
        printf("Something bad\n");
    else
        printf("Nice sort and smallest\n");
    printf("factorial(4) ia: %d\n", factorial(4));
    printf("factorial(7) ia: %d\n", factorial(7));
}
