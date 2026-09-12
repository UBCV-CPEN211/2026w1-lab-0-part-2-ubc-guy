# RUNNING NIOS V PROGRAMS ON DE10-Lite

In Windows, go to **Start** --> **Nios V Command Shell** and run the following commands on your laptop:

    make DE10-Lite
    make GDB_SERVER

The first command transmits a Nios V computer system to your DE10-Lite board.
The second command will start a program on your laptop that you need to leave running -- it
continuously communicates between your Nios V computer system and your laptop.
If you exit the GDB server by typing Q, the commands below will not longer work.
Sometimes things get confused and you need to stop everything, including the GDB server,
and start over.

Again, go to **Start** --> **Nios V Command Shell** and run the following commands on your laptop:

    make TERMINAL

or equivalently

    nios2-terminal.exe

This launches a program to listen and display any characters sent by your Nios V computer.
(Yes, I know the command was nios2-terminal.exe. That's because nios2 is the name of Altera's
previous processor and they haven't bothered to rename the tool yet.) Leave this program
running to capture everything printed by your program. Control-C will exit.

You can merge windows by dragging the tab for the Nios V Command Shell window over the tab from the first window.

Again, go to **Start** --> **Nios V Command Shell** and run the following commands on your laptop:

    make COMPILE
    make RUN

The first command compiles your program, `hello_niosv.s` into an executable, `hello_niosv.elf`.
The second command transfers the `hello_niosv.elf` executable to your Nios V computer and runs it.

This Nios V program will write out a message to the TERMINAL window you started earlier, then it will
continuously copy the 1s and 0s of the SWITCHES on your DE10-Lite to the red LEDs and two of the 7-segment displays.

You can edit your hello_niosv.s program, save it, then run `make COMPILE` and `make RUN` again.
Hint: the easiest way to edit is with `notepad hello_niosv.s`, but you can also right-click the
file and use notepad++ or launch WSL and run vim.

After `make COMPILE`, you can also launch gdb to debug your program:

    niosv-download.exe -r
    make GDB_CLIENT

The first command resets the processor to stop it from running the program you gave it.
(Check it out -- the LEDs no longer change when you move the switches.)
This is important to do before starting GDB (gdb cannot attach to a running program).

After debugging, you can use `make RUN` again, or manually run its equivalent:

    niosv-download.exe -r -g hello_niosv.elf

Sometimes things get messed up. Pressing Ctrl-C will quit most programs on your computer (like the nios2-terminal.exe),
but that may not affect what is running on the Nios V computer.

**Task**: Modify the `hello_niosv.s` program so it first copies the switch values to the red LEDs
on a continuous basis, but when you set all switches to 0 it exits the copy loop and prints
the `Hello World!` message and stops. Suggestion: set **SW9** before when you start running your program.
Upload your solution to Canvas.
