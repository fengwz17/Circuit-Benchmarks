package mini

import chisel3._
import chisel3.util._

class Delay(len: Int = 64) extends Module {
  val io = IO(new Bundle {
    val in1 = Input(UInt(len.W))
    val in2 = Input(UInt(len.W))

    val out = Output(UInt(len.W))
  })

  val value1 = Reg(UInt(len.W))
  val value2 = Reg(UInt(len.W))
  value1 := io.in1
  value2 := io.in2

  io.out := RegNext(value1 + value2)
}
