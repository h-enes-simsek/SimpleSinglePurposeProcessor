# SimpleSinglePurposeProcessor
A single purpose processor designed in Verilog calculating division between integers

This repo contains source files and testbench files of a single purpose processor that was designed with Verilog to calculate division operation between two integers for my final project of the lecture "EHB 436E - Digital System Design Application".

/src contains source files,
/design_docs contains design documents of register block, alu and top view of processor architecture,
and finalreport.pdf describes my state machine that operates division.

A little note if anyone wonders why I didn't use long division. Because there are only two registers can access ALU in this design and this situation increases the fsm complexity. I had no right to change the design; so, I had to use a simpler fsm.
