/* Generated by Yosys 0.22+72 (git sha1 14aa48517, clang 14.0.0 -fPIC -Os) */

module Non_restoring_Divider(D, R_0, Q, R_n1);
  input [1:0] D;
  input [3:0] R_0;
  output [2:0] Q;
  output [4:0] R_n1;
  wire _056_;
  wire _057_;
  wire _058_;
  wire _059_;
  wire _060_;
  wire _061_;
  wire _062_;
  wire _063_;
  wire _064_;
  wire _065_;
  wire _066_;
  wire _067_;
  wire _068_;
  wire _069_;
  wire _070_;
  wire _071_;
  wire _072_;
  wire _073_;
  wire _074_;
  wire _075_;
  wire _076_;
  wire _077_;
  wire _078_;
  wire _079_;
  wire _080_;
  wire _081_;
  wire _082_;
  wire _083_;
  wire _000_;
  wire _001_;
  wire _002_;
  wire _003_;
  wire _004_;
  wire _005_;
  wire _006_;
  wire _007_;
  wire _008_;
  wire _009_;
  wire _010_;
  wire _011_;
  wire _012_;
  wire _013_;
  wire _014_;
  wire _015_;
  wire _016_;
  wire _017_;
  wire _018_;
  wire _019_;
  wire _020_;
  wire _021_;
  wire _023_;
  wire _024_;
  wire _025_;
  wire _026_;
  wire _027_;
  wire _028_;
  wire _029_;
  wire _030_;
  wire _031_;
  wire _032_;
  wire _033_;
  wire _034_;
  wire _035_;
  wire _036_;
  wire _037_;
  wire _038_;
  wire _040_;
  wire _041_;
  wire _042_;
  wire _043_;
  wire _044_;
  wire _045_;
  wire _046_;
  wire _047_;
  wire _048_;
  wire _049_;
  wire _050_;
  wire _051_;
  wire _052_;
  wire _053_;
  wire _054_;
  wire _055_;
  assign _034_ = D[0] ? _033_ : _023_;
  assign _063_ = ~R_0[2];
  assign _064_ = ~D[1];
  assign _065_ = ~_003_;
  assign _005_ = ~_082_;
  assign _006_ = ~_083_;
  assign Q[2] = ~_004_;
  assign _066_ = ~_013_;
  assign _067_ = ~_010_;
  assign _068_ = ~_016_;
  assign _069_ = ~_008_;
  assign _070_ = ~_019_;
  assign _024_ = ~_074_;
  assign _025_ = ~_075_;
  assign _026_ = ~_076_;
  assign _027_ = ~_077_;
  assign _028_ = ~_078_;
  assign _029_ = ~_056_;
  assign _031_ = ~D[0];
  assign _057_ = ~_036_;
  assign _041_ = ~_072_;
  assign _042_ = ~_073_;
  assign Q[1] = ~_023_;
  assign _044_ = ~_079_;
  assign _059_ = ~Q[0];
  assign _046_ = ~_060_;
  assign _049_ = ~_080_;
  assign _061_ = ~_051_;
  assign R_n1[3] = ~_081_;
  assign _062_ = ~_053_;
  assign _000_ = R_0[3] ^ D[1];
  assign _001_ = D[0] & _063_;
  assign _002_ = _001_ | _000_;
  assign _003_ = R_0[3] & _064_;
  assign _004_ = _002_ & _065_;
  assign _082_ = _001_ ^ _000_;
  assign _083_ = _005_ ^ _004_;
  assign _007_ = R_0[2] ^ D[0];
  assign _008_ = _004_ ^ D[1];
  assign _009_ = _008_ ^ _007_;
  assign _010_ = _004_ ^ D[0];
  assign _011_ = _010_ ^ R_0[1];
  assign _012_ = _004_ | R_0[0];
  assign _013_ = R_0[0] & Q[2];
  assign _014_ = _012_ & _066_;
  assign _015_ = _014_ | _011_;
  assign _016_ = R_0[1] & _067_;
  assign _017_ = _015_ & _068_;
  assign _018_ = _017_ | _009_;
  assign _019_ = _007_ & _069_;
  assign _020_ = _018_ & _070_;
  assign _021_ = _020_ | _006_;
  assign _071_ = _005_ | _004_;
  assign _023_ = _021_ & _071_;
  assign _074_ = _020_ ^ _006_;
  assign _075_ = _024_ ^ _023_;
  assign _076_ = _017_ ^ _009_;
  assign _077_ = _026_ ^ _023_;
  assign _078_ = _023_ ^ D[1];
  assign _056_ = _014_ ^ _011_;
  assign _030_ = _029_ ^ _028_;
  assign _032_ = _004_ ^ R_0[0];
  assign _033_ = _032_ ^ Q[2];
  assign _035_ = _034_ | _030_;
  assign _036_ = _028_ & _056_;
  assign _037_ = _035_ & _057_;
  assign _038_ = _037_ | _027_;
  assign _058_ = _026_ | _023_;
  assign _040_ = _038_ & _058_;
  assign _072_ = _040_ | _025_;
  assign _073_ = _024_ | _023_;
  assign Q[0] = _042_ | _041_;
  assign _043_ = Q[0] | _031_;
  assign _079_ = R_0[0] ^ D[0];
  assign R_n1[0] = _044_ ^ _043_;
  assign _045_ = D[1] & _059_;
  assign _060_ = _034_ ^ _030_;
  assign _047_ = _046_ ^ _045_;
  assign _048_ = _044_ | _043_;
  assign R_n1[1] = _048_ ^ _047_;
  assign _080_ = _037_ ^ _027_;
  assign _050_ = _048_ | _047_;
  assign _051_ = _045_ & _060_;
  assign _052_ = _050_ & _061_;
  assign R_n1[2] = _052_ ^ _049_;
  assign _053_ = _040_ ^ _025_;
  assign _054_ = _052_ | _049_;
  assign _081_ = _054_ ^ _053_;
  assign _055_ = _054_ | _062_;
  assign R_n1[4] = _055_ ^ Q[0];
endmodule