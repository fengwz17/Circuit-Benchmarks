`timescale 1ns / 1ps
module Non_restoring_Divider 
    #(
		parameter Nx = 3
	)
    (
    input [Nx - 1 - 1:0] D,
    input [2 * Nx - 2 - 1:0] R_0,
    output [Nx - 1:0]  Q,
    output [2 * Nx - 2:0]  R_n1
    );

    // wire [2 * Nx - 2:0] i_add_term1[Nx:0];
    // wire [2 * Nx - 2:0] i_add_term2[Nx:0];

    wire [2 * Nx - 2 + 1:0] w_CARRY[Nx:0];
    wire [2 * Nx - 2:0] w_SUM[Nx:0];

    wire [2 * Nx - 2:0] r = {1'b0,R_0};
    wire [2 * Nx - 2:0] d = {{(Nx){1'b0}}, D}; // need change

    genvar             ii;
    genvar             nn;

    // generate 
     for (nn=0; nn<Nx; nn=nn+1) 
     begin
		// 2 1 0 
	 	assign Q[Nx - 1 - nn] = w_CARRY[nn][2 * Nx - 1];
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
            assign w_CARRY[nn][0] = Q[Nx - nn];
        end
        //第ii个 0-4
        for (ii=0; ii<2 * Nx - 2 + 1; ii=ii+1) 
            begin
            // if(nn == 0) begin
            //     assign i_add_term2[nn][ii] = r[ii];
            // end
            // else begin
            //     assign i_add_term2[nn][ii] = w_SUM[nn-1][ii];
            // end
			
            if(nn == Nx) begin
				// 此处注意 最后一层的初始carry为0 需借用上一层最后数据
                // assign i_add_term1[nn][ii] = d[ii] & (!w_CARRY[nn-1][2 * Nx - 2]);
                assign w_SUM[nn][ii] = (d[ii] & (!Q[0])) ^ (w_SUM[nn-1][ii]) ^ w_CARRY[nn][ii];
                assign w_CARRY[nn][ii+1] = (((d[ii] & (!Q[0])) ^ (w_SUM[nn-1][ii])) & w_CARRY[nn][ii]) | ((d[ii] & (!Q[0])) & (w_SUM[nn-1][ii]));

            end
            else begin
                if(nn == 0) begin
                    // assign i_add_term2[nn][ii] = r[ii];
                    assign w_SUM[nn][ii] = (d[(ii + Nx + nn) % (2 * Nx - 2 + 1)] ^ (1'b1)) ^ (r[ii]) ^ w_CARRY[nn][ii];
                    assign w_CARRY[nn][ii+1] = (((d[(ii + Nx + nn) % (2 * Nx - 2 + 1)] ^ (1'b1)) ^ (r[ii])) & w_CARRY[nn][ii]) | ((d[(ii + Nx + nn) % (2 * Nx - 2 + 1)] ^ (1'b1)) & (r[ii]));

                end
                else begin
                    // assign i_add_term2[nn][ii] = w_SUM[nn-1][ii];
                    assign w_SUM[nn][ii] = (d[(ii + Nx + nn) % (2 * Nx - 2 + 1)] ^ w_CARRY[nn][0]) ^ (w_SUM[nn-1][ii]) ^ w_CARRY[nn][ii];
                    assign w_CARRY[nn][ii+1] = (((d[(ii + Nx + nn) % (2 * Nx - 2 + 1)] ^ w_CARRY[nn][0]) ^ (w_SUM[nn-1][ii])) & w_CARRY[nn][ii]) | ((d[(ii + Nx + nn) % (2 * Nx - 2 + 1)] ^ w_CARRY[nn][0]) & (w_SUM[nn-1][ii]));

                end
                // assign i_add_term1[nn][ii] = d[(ii + Nx + nn) % (2 * Nx - 2 + 1)] ^ w_CARRY[nn][0];
                // assign w_SUM[nn][ii] = (d[(ii + Nx + nn) % (2 * Nx - 2 + 1)] ^ w_CARRY[nn][0]) ^ i_add_term2[nn][ii] ^ w_CARRY[nn][ii];
                // assign w_CARRY[nn][ii+1] = (((d[(ii + Nx + nn) % (2 * Nx - 2 + 1)] ^ w_CARRY[nn][0]) ^ i_add_term2[nn][ii]) & w_CARRY[nn][ii]) | ((d[(ii + Nx + nn) % (2 * Nx - 2 + 1)] ^ w_CARRY[nn][0]) & i_add_term2[nn][ii]);
            end
            // assign w_SUM[nn][ii] = i_add_term1[nn][ii] ^ i_add_term2[nn][ii] ^ w_CARRY[nn][ii];
            // assign w_CARRY[nn][ii+1] = ((i_add_term1[nn][ii] ^ i_add_term2[nn][ii]) & w_CARRY[nn][ii]) | (i_add_term1[nn][ii] & i_add_term2[nn][ii]);

            // full_adder full_adder_inst
            //     ( 
            //         .i_bit1(i_add_term1[nn][ii]),
            //         .i_bit2(i_add_term2[nn][ii]),
            //         .i_carry(w_CARRY[nn][ii]),
            //         .o_sum(w_SUM[nn][ii]),
            //         .o_carry(w_CARRY[nn][ii+1])
            //     );
            end
    end
    endgenerate
   
   assign R_n1 = w_SUM[Nx];
 
endmodule 
