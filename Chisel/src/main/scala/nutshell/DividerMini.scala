package nutshell

import chisel3._
import chisel3.util._

class DividerMini(len: Int = 64) extends Module {
  val io = IO(new Bundle {
    val in1  = Input(UInt(len.W))
    val in2  = Input(UInt(len.W))
    val sign = Input(Bool())
    val out  = Output(UInt((len * 2).W))
  })

  def abs(a: UInt, sign: Bool): (Bool, UInt) = {
    val s = a(len - 1) && sign
    (s, Mux(s, -a, a))
  }

  val newReq = RegInit(true.B)
  newReq := false.B

  val (a, b) = (io.in1, io.in2)
  val divBy0 = b === 0.U(len.W)

  val shiftReg = Reg(UInt((1 + len * 2).W))
  val hi       = shiftReg(len * 2, len)
  val lo       = shiftReg(len - 1, 0)

  val (aSign, aVal) = abs(a, io.sign)
  val (bSign, bVal) = abs(b, io.sign)
  val aSignReg      = RegEnable(aSign, newReq)
  val qSignReg      = RegEnable((aSign ^ bSign) && !divBy0, newReq)
  val bReg          = RegEnable(bVal, newReq)
  val aValx2Reg     = RegEnable(Cat(aVal, "b0".U), newReq)

  when(RegNext(newReq)) {
    shiftReg := aValx2Reg
  }
  val enough = hi.asUInt >= bReg.asUInt
  when(!RegNext(newReq)) {
    shiftReg := Cat(Mux(enough, hi - bReg, hi)(len - 1, 0), lo, enough)
  }

  val r    = hi(len, 1)
  val resQ = Mux(qSignReg, -lo, lo)
  val resR = Mux(aSignReg, -r, r)
  io.out := Cat(resR, resQ)
}

object RunDividerMini extends App {
  import chisel3._
  import chisel3.stage._
  import firrtl.options.Dependency
  import firrtl.stage.RunFirrtlTransformAnnotation
  import firrtl.backends.experimental.smt.random._
  import firrtl.backends.experimental.smt._
  val compiler = new chisel3.stage.ChiselStage
  val r = compiler.execute(
    Array("-E", "experimental-btor2", "--target-dir", "main_run_dir/RunDividerMini"),
    Seq(
      ChiselGeneratorAnnotation(() => new DividerMini(2)),
      RunFirrtlTransformAnnotation(Dependency(InvalidToRandomPass))
    )
  )
  println("Transiton System")
  println(r.collectFirst { case TransitionSystemAnnotation(s) => s }.get.serialize)
  println()
}
