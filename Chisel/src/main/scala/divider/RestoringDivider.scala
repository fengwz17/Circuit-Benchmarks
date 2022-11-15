package divider

import chisel3._
import chisel3.util._

class RestoringDivider(len: Int = 64) extends Module {
  val io = IO(new Bundle {
    val op1  = Input(SInt(len.W))
    val op2  = Input(SInt(len.W))
    val outQ = Output(SInt(len.W))
    val outR = Output(SInt(len.W))
  })

  val n = len
  val D = io.op2
  val q = Wire(Vec(n, Bool()))
  val R = Wire(Vec(n + 1, SInt((2 * n - 1).W)))

  R(0) := io.op1

  // R(0) = Q * D + R(n)
  // R(0) and D are SInt, but the sign-bit must be 0

  for (j <- 1 to n) {
    q(n - j) := Mux(
      R(j - 1) - (D << (n - j)) < 0.S,
      0.B,
      1.B
    )
    R(j) := R(j - 1) - Mux(q(n - j), D << (n - j), 0.S)
  }
  io.outQ := q.asUInt.asSInt
  io.outR := R(n)
}
