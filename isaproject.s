// "I pledge" Wade Nelson
//*** I am using this to signify my added code


// The code you must implement is provided in ISAproject.pdf

// Define stack start address
.stack 0x5000

// Define address of printf
.text 0x7000
.label printf

.data 0x100
.label sia // static integer array a
50
43
100
-5
-10
50
0
.label sib // static integer array b
500
43
100
-5
-10
50
0
//***
.label string1
.string // cmp_arrays(sia, sib): %d
.label string2
.string // cmp_arrays(sia, sia): %d
.label string3
.string // cmp_arrays(ia, sia): %d
.label fmt3
.string // ia[%d]: %d
.label smallest1
.string // smallest(ia): %d
.label smallest2
.string // smallest(sia): %d
.label factorial1
.string // factorial(4) ia: %d
.label factorial2
.string // factorial(7) ia: %d
.label cmp_print
.string // s1: %d, s2: %d
.label goodstring
.string // Nice sort and smallest
//***

.label fmt1
.string //sia[%d]: %d
.label fmt2
.string //Something bad
.text 0x300
// r0 has ia - address of null terminated array
// sum_array is a leaf function
// If you only use r0, r1, r2, r3; you do not need a stack
.label sum_array
mov r0, 2          // hardcode to return a 2
mov r15, r14       // return

.text 0x400
// r0 has ia1 - address of null terminated array
// r1 has ia1 - address of null terminated array
// cmp_arrays must allocate a stack
// Save lr on stack and allocate space for local vars
.label cmp_arrays
                   // Allocate stack
                   // Call sum_array two times
mov r0, -1         // hardcode to return -1
		   // Deallocate stack
mov r15, r14       // return

.text 0x500
// r0 has ia - address of null terminated array
// numelems is a leaf function
// If you only use r0, r1, r2, r3; you do not need a stack
.label numelems
mov r0, 0xa        // hardcode to return a 10
.label break
mov r15, r14       // return

.text 0x600
// r0 has ia - address of null terminated array
// sort must allocate a stack
// Save lr on stack and allocate space for local vars
.label sort
                   // Allocate stack
// blr numelems    // count elements in ia[]
                   // create nested loops to sort
		   // Deallocate stack
mov r15, r14       // return - sort is a void function

.text 0x700
// r0 has ia - address of null terminated array
// smallest must allocate a stack
// Save lr on stack and allocate space for local vars
.label smallest
                   // Allocate stack
// blr numelems    // count elements in ia[]
                   // create loop to find smallest
mov r0, 2          // hardcode to return a 2
		   // Deallocate stack
mov r15, r14       // return

.text 0x800
// r0 has an integer
// factorial must allocate a stack
// Save lr on stack and allocate space for local vars
.label factorial
                   // Allocate stack
		   // implement algorithm
//blr factorial    // factorial calls itself
		   // Deallocate stack
mov r0, 120        // hardcode 5! as return value
mov r15, r14       // return

.text 0x900
// This sample main implements the following
// int main() {
//     int n = 0, l = 0, c = 0;
//     printf("Something bad");
//     for (int i = 0; i < 3; i++)
//         printf("ia[%d]: %d", i, sia[i]);
//     n = numelems(sia);
//     sm1 = smallest(sia);
//     cav = cmp_arrays(sia, sib);
// }
.label main
//***
// added code below 
// int ia[] = {2,3,5,1,0};
// allocating mem on stack for array
sbi sp, sp, 20 // allocate space for stack
                   // [sp,0] is int 2
                   // [sp,4] is int 3
                   // [sp,8] is int 5
                   // [sp,12] is int 1
                   // [sp,16] is int 0
str lr, [sp, 20]   // [sp,20] is lr (save lr)
mov r0, 2
str r0, [sp, 0]
mov r0, 3
str r0, [sp, 4]
mov r0, 5
str r0, [sp, 8]
mov r0, 1
str r0, [sp, 12]
mov r0, 0
str r0, [sp, 16]

mva r0, string1
blr printf

mva r0, string2
blr printf

mov r0, 4
mva r1, sib
str r0, [r1, 0]

mva r0, string1
blr printf

mva r0, string3
blr printf

mva r0, sp
bal sort // this is calling sort(ia) the sp is at ia[0] 
// code above is added
//***

sbi sp, sp, 16     // allocate space for stack
                   // [sp,0] is int cav
                   // [sp,4] is int n
                   // [sp,8] is int sm1
str lr, [sp, 12]   // [sp,12] is lr (save lr)
mov r0, 0
str r0, [sp, 0]    // cav = 0;
str r0, [sp, 4]    // n = 0;
str r0, [sp, 8]    // sm1 = 0;
// printf("Something bad");
// Kernel call to printf expects parameters
// r1 - address of format string - "Something bad"
// mva r1, bad
// ker #0x11
// The os has code for printf at address 0x7000
// The code there generates the ker instruction
// You call printf with
// r0 - has address of format string - "Something bad"
mva r0, fmt2
blr printf
//
// for (int i = 0; i < 4; i++)
//     printf("ia[%d]: %d", i, sia[i]);
mov r4, 0          // i to r4
mva r5, sia   // address is sia to r5
.label loop4times  // print 3 elements if sia
cmp r4, 4
bge end_loop4times
// Kernel call to printf expects parameters
// r1 - address of format string - "ia[%d]: %d"
// r2 - value for first %d
// r3 - value for second %d
mva r1, fmt1       // fmt1 to r1
mov r2, r4         // i to r2
ldr r3, [r5], 4    // sia[i] to r3
ker #0x11          // Kernel call to printf
adi r4, r4, 1      // i++
bal loop4times
.label end_loop4times
// int n = numelems(sia);
mva r0, sia        // put address of sia in r0
blr numelems       // n = numelems(sia)
str r0, [sp, 4]
// int sm1 = smallest(sia);
mva r0, sia        // put address of sia in r0
blr smallest       // sm1 = smallest(sia)
str r0, [sp, 8]    // store return value in sm1
// cav = cmp_arrays_sia, sib);
mva r0, sia        // put address of sia in r0
mva r1, sib        // put address of sib in r1
blr cmp_arrays
str r0, [sp, 0]
// Do not deallocate stack.
// This leaves r13 with an address that can be used to dump memory
// > d 0x4ff0 
// Shows the three hardcoded values stored in cav, n, and sm1.
// 0x4ff0 (0d20464) 0xffffffff 0x0000000a 0x00000002
.label end
bal end            // branch to self
