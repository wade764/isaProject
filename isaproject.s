// "I pledge" Wade Nelson
//*** I am using this to signify my added code

// The code you must implement is provided in ISAproject.pdf

// Define stack start address
.stack 0x5000

// Define address of scanf
.text 0x7050
.label scanf

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
//.label s // used in and sort
//0 // temp value should equal the numelems(ia)
//.label t // used in sort
//0 // temp value should equal the numelems(ia)
//.label i // used in sort
//0
//.label j // used in sort
//0

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

mov r1, 0 // this is int s = 0

.label loop_sum // the while loop needed to compute the sum
ldr r2, [r0], 4 // this is the address of the array to sum
cmp r2, 0      // *ia != 0
beq done_sum        // branches to done if they equal

add r1, r1, r2  // adding to s += *ia into r7

bal loop_sum  // branching back to loop_sum

.label done_sum

mov r0, r1

mov r15, r14       // return

.text 0x400
// r0 has ia1 - address of null terminated array
// r1 has ia1 - address of null terminated array
// cmp_arrays must allocate a stack
// Save lr on stack and allocate space for local vars
.label cmp_arrays
//***
sbi sp, sp, 20 // 16 bytes for the addresses and 4 for lr
str r14, [sp, 16] // storing the lr at sp byte 16
str r0, [sp, 0] // storing the address first array
str r1, [sp, 4] // storing the address second array

blr sum_array   // Call sum_array two times
str r0, [sp, 8] // int s1

ldr r0, [sp, 4] // loading the second array into r0

blr sum_array
str r0, [sp, 12] // int s2
// print cmp_print here
ldr r5, [sp, 8]
ldr r6, [sp, 12]
mva r1, r5
mva r2, r6
mva r0, cmp_print
blr printf

ldr r0, [sp, 8] // int s1
ldr r1, [sp, 12] // int s2

cmp r0, r1

beq return_0

bgt return_1

mov r0, -1
bal return

.label return_0
mov r0, 0
bal return

.label return_1
mov r0, 1

.label return

ldr r14, [sp, 16]

adi sp, sp, 20

mov r15, r14
//***

.text 0x500

// r0 has ia - address of null terminated array
// numelems is a leaf function
// If you only use r0, r1, r2, r3; you do not need a stack
.label numelems
//***
// JUNK //mov r1, 0 //this is the literal 0
mov r2, 0 //this is the counter variable c
// JUNK //adi sp, sp, 16 // adding to the stack pointer 16 to get the starting address
               // of ia[0] that holds 5 elements
// JUNK //str r3, [sp, 0] // moving the value of the stack pointer into r1
.label loop_numelems // the while loop
// JUNK //str r3, sp
// JUNK //ldr r3, [r0]
ldr r1, [r0], 4  // this is a post increment equivalent to ia[0]++
                 //*ia to r0, ia++

cmp r1, 0 // comparing the value of r1 to r0 *ia++ != 0
          // *ia == 0

// JUNK // adi sp, sp, 4 // incrementing the sp r13
// JUNK //adi r2, [r2, 1] // *** I am confused how to add to the counter variable
// JUNK  blt while1 // branching if the value != 0

beq done_numelems
adi r2, r2, 1
bal loop_numelems
.label done_numelems
mov r0, r2
mov r15, r14 // moves the link register to the program counter
//***

//mov r0, 0xa        // hardcode to return a 10
//.label break
//mov r15, r14       // return // the numelems is in r2

.text 0x600
// r0 has ia - address of null terminated array
// sort must allocate a stack
// Save lr on stack and allocate space for local vars
.label sort // uses bubblesort to sort the elements in the array
// this uses a variable s set to the numelems(ia)
// two nested for loops, variables i, j
// int t used as a temp variable
// int literal 1
sbi sp, sp, 20     // sub 20 because there are 4 variables s, t, i, j and the lr

str r14, [sp, 16] // storing the lr

mov r1, 0
str r1, [sp, 0] // variable s = 0

str r1, [sp, 4] // variable t = 0
// *** STUCK HERE
// how do I allocate mem for i and j if I have to post increment i and j
//mov r1, i
//mov r1, 0
str r1, [sp, 8] // variable i = 0
//mov r1, j
//mov r1, 0
str r1, [sp, 12] // variable j = 0


blr numelems       // count elements in ia[] // *** the sp should be shift up 16 bytes
// numelems returns and the num is stored in r0

str r0, [sp, 0]    // s = numelems(ia)

                   // create nested loops to sort
.label for1
str r1, [sp, 8] // counter i = 0
cmp r1, r2      // i < s, s is the numelems
// STUCK HERE
// blt // *** trouble thinking of how to for nested for loops here

// STUCK I dont know how to post increment the [sp, 8]*** remove static var 
// located at [sp, 12]
ldr r5, [sp, 8]
ldr r1, [r5], 4 // post increment of i
                   // Deallocate stack
mov r15, r14       // return - sort is a void function

.text 0x700
// r0 has ia - address of null terminated array
// smallest must allocate a stack
// Save lr on stack and allocate space for local vars
.label smallest
//***
sbi sp, sp, 16 // DOUBLE CHECK THE VALUE I AM SUBTRACTING
str r0, [sp, 0]         // stores ia on stack
mov r1, 0
str r1, [sp, 8]         // sm = 0
str r14, [sp, 12]        // stores lr on stack
// func entry sequence above this comment
blr numelems            // count elems in ia[]
str r0, [sp, 4]         // save num elems on stack

//***
                   // Allocate stack
// blr numelems    // count elements in ia[]
                   // create loop to find smallest

//***
ldr r0, [sp, 0]    // address of ia into r0
ldr r1, [r0]       // ia[0] into r1
str r1, [sp, 8]    // sm = *ia
ldr r3, [sp,0]     // int *p = ia;

ldr r0, [sp, 4]         // loading the number of elem into r0

mov r2, 4               // 4 is for the size of type
mul r0, r0, r2     // num elems * 4

str r0, [sp, 4]    // storing the total num of elements * 4 back on to the stack at the 4th byte

//ldr r2, [sp, 4]    // numelems to r0
//add r2, r2, r0  // ia + s

ldr r5, [sp, 0]    // r5 has ia
add r6, r5, r0          // r6 has ia + s
adi r2, r2, 24

.label sm_loop    
//***

ldr r4, [sp, 0] // this is p the int* in the loop
cmp r4, r6      // p < ia+s
bge sm_done        // branches to done if they equal

ldr r7, [r4], 4         // this post increments the value of *ia 

ldr r8, [sp, 8] // loads the current smallest into r8

cmp r7, r8      // comparing *p < sm

bge sm_skip
// if it doesnt skip then you have to store r7 into [sp, 8]
str r7, [sp, 8] // updates smallest

.label sm_skip
bal sm_loop

.label sm_done
ldr r0, [sp, 8]         // this loads the smallest in r0 //*** r0 is the return register
ldr r14, [sp, 12]       // loads the correct address for link register back into r14

adi r13, sp, 16 // adds imm 16 back on to the stack 

//mov r0, 2          // hardcode to return a 2
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
// int ia[] = {2,3,5,1,0};
// allocating mem on stack for array
sbi sp, sp, 24 // allocate space for stack
                   
mov r0, 2          // [sp,0] is int 2
str r0, [sp, 0]
mov r0, 3          // [sp,4] is int 3
str r0, [sp, 4]
mov r0, 5          // [sp,8] is int 5
str r0, [sp, 8]    
mov r0, 1          // [sp,12] is int 1
str r0, [sp, 12]   
mov r0, 0          // [sp,16] is int 0
str r0, [sp, 16]
str lr, [sp, 20]   // [sp,20] is lr (save lr)

// calling cmp_arrays with (sia,sib)
mva r0, sia // must move the arrays to the registers before calling
mva r1, sib
// *** BUG calling cmp_arrays leads to an ILLEGAL INSTRUCTION ERROR
blr cmp_arrays

//.label stop
//bal stop

mva r1, r0
mva r0, string1
//mva r1, 5 // printing off this temp value
blr printf

// calling cmp_arrays with (sia,sia)
mov r0, sia // must move the arrays to the registers before calling
mov r1, sia
blr cmp_arrays

mva r1, r0
mva r0, string2
//mva r1, 16 // printing off this temp value
blr printf

// sib[0] = 4
mov r0, 4
mva r1, sib
str r0, [r1, 0]

// calling cmp_arrays with (sia,sib) second time
mov r0, sia // must move the arrays to the registers before calling
mov r1, sib
blr cmp_arrays

mva r1, r0
mva r0, string1
blr printf

// calling cmp_arrays with (ia,sia)
mva r0, sp // must move the arrays to the registers before calling
mov r1, sia
blr cmp_arrays

mva r1, r0
mva r0, string3
blr printf

// calling sort(ia)
mov r0, sp
blr sort // this is calling sort(ia) the sp is at ia[0] 
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
//***
mov r1, r0
mva r0, fmt3
blr printf

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
