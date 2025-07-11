`timescale 1ns / 1ps

module pipelined_processor_tb;

    reg clk, reset;
    integer i;

    // Instantiate the pipelined processor
    pipelinedprocessor uut (
        .clk(clk),
        .reset(reset)
    );

    // Clock generation
    always #5 clk = ~clk; // 10ns clock period

    // Instruction Memory (Example Instructions - Change as needed)
    reg [31:0] instr_mem [0:15]; // 16 instruction slots

    initial begin
        // Sample Instruction Sequence (RISC-style)
        instr_mem[0]  = 32'h20080005;  // addi  $t0, $zero, 5   // t0 = 5
        instr_mem[1]  = 32'h20090003;  // addi  $t1, $zero, 3   // t1 = 3
        instr_mem[2]  = 32'h01095020;  // add   $t2, $t0, $t1   // t2 = t0 + t1
        instr_mem[3]  = 32'h214A0002;  // addi  $t2, $t2, 2     // t2 += 2
        instr_mem[4]  = 32'hAC0A0004;  // sw    $t2, 4($zero)   // store t2 at mem[4]
        instr_mem[5]  = 32'h8C0B0004;  // lw    $t3, 4($zero)   // load from mem[4] to t3
        instr_mem[6]  = 32'h116BFFFC;  // beq   $t3, $t2, -4    // if t3 == t2, loop

        // Initialize instruction memory in processor (if needed)
        for (i = 0; i < 16; i = i + 1) 
            uut.IF_Stage_U.instr_mem[i] = instr_mem[i];

        // Initialize clock and reset
        clk = 0;
        reset = 1;

        // Hold reset for a few cycles
        #10 reset = 0;

        // Run simulation for some time
        #200 $stop; 
    end

    // Monitor outputs
    initial begin
        $monitor("Time = %0t | PC = %h | Instr = %h | Reg $t0 = %d | Reg $t1 = %d | Reg $t2 = %d | Reg $t3 = %d", 
                 $time, uut.pc, uut.instr, uut.reg_file[8], uut.reg_file[9], uut.reg_file[10], uut.reg_file[11]);
    end

endmodule
