`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////

module pipelinedprocessor(input clk, reset);
    wire [31:0] instr, pc, reg1, reg2;
    wire [4:0] rs, rt, rd;
    wire reg_write;

    // Register File (Inside Top Module)
    reg [31:0] reg_file [0:31];

    // Initialize Register File (Optional for Simulation)
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) reg_file[i] = i;
    end

    // IF Stage
    IF_Stage IF_Stage_U (clk, reset, instr, pc);

    // IF/ID Pipeline Register
    wire [31:0] instr_ID;
    IF_ID IF_ID_U (clk, instr, instr_ID);

    // ID Stage (No reg_file input)
    ID_Stage ID_Stage_U (instr_ID, rs, rt, rd);

    // Read Register Values
    assign reg1 = reg_file[rs];
    assign reg2 = reg_file[rt];

    // ID/EX Pipeline Register
    wire [31:0] reg1_EX, reg2_EX;
    wire [4:0] rd_EX;
    wire [3:0] alu_op;
    wire mem_read, mem_write;
    ID_EX ID_EX_U (clk, reg1, reg2, rd, alu_op, mem_read, mem_write, reg1_EX, reg2_EX, rd_EX);

    // EX Stage
    wire [31:0] alu_result_EX;
    EX_Stage EX_Stage_U (reg1_EX, reg2_EX, alu_op, alu_result_EX);

    // EX/MEM Pipeline Register
    wire [31:0] alu_result_MEM;
    EX_MEM EX_MEM_U (clk, alu_result_EX, mem_read, mem_write, alu_result_MEM);

    // MEM Stage
    wire [31:0] mem_data_MEM;
    MEM_Stage MEM_Stage_U (clk, mem_read, mem_write, alu_result_MEM, reg2_EX, mem_data_MEM);

    // MEM/WB Pipeline Register
    wire [31:0] mem_data_WB;
    MEM_WB MEM_WB_U (clk, mem_data_MEM, mem_data_WB);

    // WB Stage
    wire [4:0] write_reg;
    wire [31:0] write_back_data;

    WB_Stage WB_Stage_U (mem_data_WB, rd_EX, reg_write, write_reg, write_back_data);

    // Write Back to Register File
    always @(posedge clk) begin
        if (reg_write) begin
            reg_file[write_reg] <= write_back_data;
        end
    end

endmodule

// Pipeline Registers Updates:
module ID_EX (
    input clk,
    input [31:0] reg1_in, reg2_in,
    input [4:0] rd_in,
    input [3:0] alu_op_in,
    input mem_read_in, mem_write_in,
    output reg [31:0] reg1_out, reg2_out,
    output reg [4:0] rd_out,
    output reg [3:0] alu_op_out,
    output reg mem_read_out, mem_write_out
);
    always @(posedge clk) begin
        reg1_out <= reg1_in;
        reg2_out <= reg2_in;
        rd_out <= rd_in;
        alu_op_out <= alu_op_in;
        mem_read_out <= mem_read_in;
        mem_write_out <= mem_write_in;
    end
endmodule

module EX_MEM (
    input clk,
    input [31:0] alu_result_in,
    input mem_read_in, mem_write_in,
    output reg [31:0] alu_result_out,
    output reg mem_read_out, mem_write_out
);
    always @(posedge clk) begin
        alu_result_out <= alu_result_in;
        mem_read_out <= mem_read_in;
        mem_write_out <= mem_write_in;
    end
endmodule

module MEM_WB (
    input clk,
    input [31:0] mem_data_in,
    output reg [31:0] mem_data_out
);
    always @(posedge clk) begin
        mem_data_out <= mem_data_in;
    end
endmodule
