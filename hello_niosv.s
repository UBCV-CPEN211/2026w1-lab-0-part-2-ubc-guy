.include    "address_map_niosv.s" 

.global _start

_start:
        /* first, print a string on the terminal */
        la    s0, JTAG_UART_BASE  # JTAG UART base address
        la    a1, mystring        # load address of mystring
        addi  a2, zero, 13        # string length in characters
        jal   putstring           # prints the string

        /* second, continuously copy SWITCH values to LEDR and HEX4 and HEX0 */
        la    s0, SW_BASE         # Switches base address
        la    s1, LEDR_BASE       # Red LED base address
        la    s2, HEX3_HEX0_BASE  # 7-segment display for HEX3,HEX2,HEX1,HEX0
        la    s3, HEX5_HEX4_BASE  # 7-segment display for HEX5,HEX4
loop:   lw    t0, 0(s0)           # read the switch pattern
        sw    t0, 0(s1)           # write switch pattern to the LEDs
        andi  t0, t0, 0xff        # keep only the lower 8 bits
        sw    t0, 0(s2)           # writes to HEX0
        sw    t0, 0(s3)           # writes to HEX4
        j     loop


/******************************************************************************
 * Subroutine to send a string of characters to JTAG UART
 *		a0	= character sent to putchar
 *		a1	= address of string to send
 *		a2	= string length in characters
 *		s0	= JTAG UART base address
 *              t0,t1   = temporary registers used (overwrites contents)
 *****************************************************************************/
putstring:
        beqz    a2, end_putstring   # stop printing if no more characters
        lb      a0, 0(a1)           # read the character from the string
checkspace:
        lw      t0, 4(s0)           # read the JTAG UART control register
        srli    t0, t0, 16          # shift: upper 16b is space remaining in buffer
        beqz    t0, checkspace      # if no space now, check again
        sw      a0, 0(s0)           # send the character
nextchar:
        addi    a1, a1, 1
        addi    a2, a2, -1
        j       putstring

end_putstring:                            
        ret                         

.data
mystring:    .ascii "Hello World!\n"

