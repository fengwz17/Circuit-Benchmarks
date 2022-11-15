package divider

import chisel3._
import chisel3.util._

class RestoringDividerUnsign(len: Int = 64) extends Module {
  val io = IO(new Bundle {
    val op1  = Input(UInt(len.W))
    val op2  = Input(UInt(len.W))
    val outQ = Output(UInt(len.W))
    val outR = Output(UInt(len.W))
  })

  val n = len
  val D = io.op2
  val q = Wire(Vec(n, Bool()))
  val R = Wire(Vec(n + 1, UInt((2 * n - 1).W)))

  R(0) := io.op1

  // R(0) = Q * D + R(n)
  // R(0) and D are UInt
  // R is an array, R(0) is dividend and R(n) is remainder 

  for (j <- 1 to n) {
    q(n - j) := Mux(
      R(j - 1) < (D << (n - j)),
      0.B,
      1.B
    )
    R(j) := R(j - 1) - Mux(q(n - j), D << (n - j), 0.U)
  }
  io.outQ := q.asUInt
  io.outR := R(n)
}
