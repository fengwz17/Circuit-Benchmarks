`timescale 1ns / 1ps
`include "full_adder.v"
// 纹波进位加法器
module Non_restoring_Divider 
    #(
		parameter Nx = 5
	)
    (
    input [Nx - 1 - 1:0] d_nosign,
    input [2 * Nx - 2 - 1:0] r_nosign,
    output [Nx - 1:0]  Quotient,
    output [2 * Nx - 2:0]  Remainder
    );

    // 部分以N=5直接写了 后续要改
    wire [2 * Nx - 2:0] i_add_term1[Nx:0];
    wire [2 * Nx - 2:0] i_add_term2[Nx:0];

    wire [2 * Nx - 2 + 1:0] w_CARRY[Nx:0];
    wire [2 * Nx - 2:0] w_SUM[Nx:0];

    wire [2 * Nx - 2:0] r = {1'b0,r_nosign};
    wire [2 * Nx - 2:0] d = {{(Nx){1'b0}}, d_nosign}; // need change

    genvar             ii;
    genvar             nn;

    generate 
    for (nn=0; nn<Nx; nn=nn+1) 
    begin
		// 2 1 0 
		assign Quotient[Nx - 1 - nn] = w_CARRY[nn][2 * Nx - 2];
	end
	endgenerate
    // Carry
    generate
    for (nn=0; nn<Nx+1; nn=nn+1) 
    begin
        // 第nn层 0-3
		if(nn==0)begin
		    assign w_CARRY[0][0] = 1'b1;
		end
        else if(nn == Nx) begin
            assign w_CARRY[nn][0] = 1'b0;
        end
        else begin
            assign w_CARRY[nn][0] = w_CARRY[nn-1][2 * Nx - 2 + 1];
        end
        //第ii个 0-4
        for (ii=0; ii<2 * Nx - 2 + 1; ii=ii+1) 
            begin
            if(nn == 0) begin
                assign i_add_term2[nn][ii] = r[ii];
            end
            else begin
                assign i_add_term2[nn][ii] = w_SUM[nn-1][ii];
            end
			
            if(nn == Nx) begin
				// 此处注意 最后一层的初始carry为0 需借用上一层最后数据
                assign i_add_term1[nn][ii] = d[ii] & (!w_CARRY[nn-1][2 * Nx - 2]);
            end
            else begin
                assign i_add_term1[nn][ii] = d[(ii + Nx + nn) % (2 * Nx - 2 + 1)] ^ w_CARRY[nn][0];
            end
            full_adder full_adder_inst
                ( 
                    .i_bit1(i_add_term1[nn][ii]),
                    .i_bit2(i_add_term2[nn][ii]),
                    .i_carry(w_CARRY[nn][ii]),
                    .o_sum(w_SUM[nn][ii]),
                    .o_carry(w_CARRY[nn][ii+1])
                );
            end
    end
    endgenerate
   
   assign Remainder = w_SUM[Nx];
 
endmodule 