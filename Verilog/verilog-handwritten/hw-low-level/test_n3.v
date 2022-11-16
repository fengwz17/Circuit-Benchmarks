module Non_restoring_Divider 
    (
    input  [1:0] D,
    input  [3:0] R_0,
    output [2:0]  Q,
    output [4:0]  R_n1
    );

    wire [5:0] w_CARRY[3:0];
    wire [4:0] w_SUM[3:0];
    wire [4:0] r = {1'b0, R_0};
    wire [4:0] d = {{3'b0}, D}; 


    assign Q[2] = w_CARRY[0][5];
    assign Q[1] = w_CARRY[1][5];
    assign Q[0] = w_CARRY[2][5];

    assign w_CARRY[0][0] = 1'b1;
    assign Q[2] = w_CARRY[0][5];
    assign Q[1] = w_CARRY[1][5];
    assign w_CARRY[3][0] = 1'b0;

    assign w_SUM[3][0] = (d[0] & (!Q[0])) ^ (w_SUM[2][0]) ^ w_CARRY[3][0];
    assign w_SUM[3][1] = (d[1] & (!Q[0])) ^ (w_SUM[2][1]) ^ w_CARRY[3][1];
    assign w_SUM[3][2] = (d[2] & (!Q[0])) ^ (w_SUM[2][2]) ^ w_CARRY[3][2];
    assign w_SUM[3][3] = (d[3] & (!Q[0])) ^ (w_SUM[2][3]) ^ w_CARRY[3][3];
    assign w_SUM[3][4] = (d[4] & (!Q[0])) ^ (w_SUM[2][4]) ^ w_CARRY[3][4];
    assign w_CARRY[3][1] = (((d[0] & (!Q[0])) ^ (w_SUM[2][0])) & w_CARRY[3][0]) | ((d[0] & (!Q[0])) & (w_SUM[2][0]));
    assign w_CARRY[3][2] = (((d[1] & (!Q[0])) ^ (w_SUM[2][1])) & w_CARRY[3][1]) | ((d[1] & (!Q[0])) & (w_SUM[2][1]));
    assign w_CARRY[3][3] = (((d[2] & (!Q[0])) ^ (w_SUM[2][2])) & w_CARRY[3][2]) | ((d[2] & (!Q[0])) & (w_SUM[2][2]));
    assign w_CARRY[3][4] = (((d[3] & (!Q[0])) ^ (w_SUM[2][3])) & w_CARRY[3][3]) | ((d[3] & (!Q[0])) & (w_SUM[2][3]));
    assign w_CARRY[3][5] = (((d[4] & (!Q[0])) ^ (w_SUM[2][4])) & w_CARRY[3][4]) | ((d[4] & (!Q[0])) & (w_SUM[2][4]));

    // full_adder full_adder_inst ( 
    //                 .i_bit1(i_add_term1[nn][ii]),
    //                  .i_bit2(i_add_term2[nn][ii]),
    //                  .i_carry(w_CARRY[nn][ii]),
    //                  .o_sum(w_SUM[nn][ii]),
    //                  .o_carry(w_CARRY[nn][ii+1])
    //                  );

    assign w_SUM[0][0] = (d[3] ^ (1'b1)) ^ (r[0]) ^ w_CARRY[0][0];
    assign w_SUM[0][1] = (d[4] ^ (1'b1)) ^ (r[1]) ^ w_CARRY[0][1];
    assign w_SUM[0][2] = (d[0] ^ (1'b1)) ^ (r[2]) ^ w_CARRY[0][2];
    assign w_SUM[0][3] = (d[1] ^ (1'b1)) ^ (r[3]) ^ w_CARRY[0][3];
    assign w_SUM[0][4] = (d[2] ^ (1'b1)) ^ (r[4]) ^ w_CARRY[0][4];

    assign w_CARRY[0][1] = (((d[3] ^ (1'b1)) ^ (r[0])) & w_CARRY[0][0]) | ((d[3] ^ (1'b1)) & (r[0]));
    assign w_CARRY[0][2] = (((d[4] ^ (1'b1)) ^ (r[1])) & w_CARRY[0][1]) | ((d[4] ^ (1'b1)) & (r[1]));
    assign w_CARRY[0][3] = (((d[0] ^ (1'b1)) ^ (r[2])) & w_CARRY[0][2]) | ((d[0] ^ (1'b1)) & (r[2]));
    assign w_CARRY[0][4] = (((d[1] ^ (1'b1)) ^ (r[3])) & w_CARRY[0][3]) | ((d[1] ^ (1'b1)) & (r[3]));
    assign w_CARRY[0][5] = (((d[2] ^ (1'b1)) ^ (r[4])) & w_CARRY[0][4]) | ((d[2] ^ (1'b1)) & (r[4]));

    assign w_SUM[1][0] = (d[4] ^ Q[2]) ^ (w_SUM[0][0]) ^ Q[2];
    assign w_SUM[1][1] = (d[0] ^ Q[2]) ^ (w_SUM[0][1]) ^ w_CARRY[1][1];
    assign w_SUM[1][2] = (d[1] ^ Q[2]) ^ (w_SUM[0][2]) ^ w_CARRY[1][2];
    assign w_SUM[1][3] = (d[2] ^ Q[2]) ^ (w_SUM[0][3]) ^ w_CARRY[1][3];
    assign w_SUM[1][4] = (d[3] ^ Q[2]) ^ (w_SUM[0][4]) ^ w_CARRY[1][4];

    assign w_SUM[2][0] = (d[0] ^ Q[1]) ^ (w_SUM[1][0]) ^ Q[1];
    assign w_SUM[2][1] = (d[1] ^ Q[1]) ^ (w_SUM[1][1]) ^ w_CARRY[2][1];
    assign w_SUM[2][2] = (d[2] ^ Q[1]) ^ (w_SUM[1][2]) ^ w_CARRY[2][2];
    assign w_SUM[2][3] = (d[3] ^ Q[1]) ^ (w_SUM[1][3]) ^ w_CARRY[2][3];
    assign w_SUM[2][4] = (d[4] ^ Q[1]) ^ (w_SUM[1][4]) ^ w_CARRY[2][4];


    assign w_CARRY[1][1] = (((d[4] ^ Q[2]) ^ (w_SUM[0][0])) & Q[2]) | ((d[4] ^ Q[2]) & (w_SUM[0][0]));
    assign w_CARRY[1][2] = (((d[0] ^ Q[2]) ^ (w_SUM[0][1])) & w_CARRY[1][1]) | ((d[0] ^ Q[2]) & (w_SUM[0][1]));
    assign w_CARRY[1][3] = (((d[1] ^ Q[2]) ^ (w_SUM[0][2])) & w_CARRY[1][2]) | ((d[1] ^ Q[2]) & (w_SUM[0][2]));
    assign w_CARRY[1][4] = (((d[2] ^ Q[2]) ^ (w_SUM[0][3])) & w_CARRY[1][3]) | ((d[2] ^ Q[2]) & (w_SUM[0][3]));
    assign w_CARRY[1][5] = (((d[3] ^ Q[2]) ^ (w_SUM[0][4])) & w_CARRY[1][4]) | ((d[3] ^ Q[2]) & (w_SUM[0][4]));

    assign w_CARRY[2][1] = (((d[0] ^ Q[1]) ^ (w_SUM[1][0])) & Q[1]) | ((d[0] ^ Q[1]) & (w_SUM[1][0]));
    assign w_CARRY[2][2] = (((d[1] ^ Q[1]) ^ (w_SUM[1][1])) & w_CARRY[2][1]) | ((d[1] ^ Q[1]) & (w_SUM[1][1]));
    assign w_CARRY[2][3] = (((d[2] ^ Q[1]) ^ (w_SUM[1][2])) & w_CARRY[2][2]) | ((d[2] ^ Q[1]) & (w_SUM[1][2]));
    assign w_CARRY[2][4] = (((d[3] ^ Q[1]) ^ (w_SUM[1][3])) & w_CARRY[2][3]) | ((d[3] ^ Q[1]) & (w_SUM[1][3]));
    assign w_CARRY[2][5] = (((d[4] ^ Q[1]) ^ (w_SUM[1][4])) & w_CARRY[2][4]) | ((d[4] ^ Q[1]) & (w_SUM[1][4]));

   
   assign R_n1 = w_SUM[3];
 
endmodule 