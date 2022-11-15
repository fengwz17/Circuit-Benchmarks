package nutshell

import chisel3._
import chisel3.util._
import chiseltest._
import chiseltest.formal._
import org.scalatest.flatspec.AnyFlatSpec

class DividerSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "Divider"
  it should "could emit low-firrtl" in {
    (new chisel3.stage.ChiselStage)
      .emitFirrtl(new Divider(64), Array("-E", "low", "--target-dir", "test_run_dir/" + getTestName))
  }
  it should "could emit btor2" in {
    (new chisel3.stage.ChiselStage)
      .emitFirrtl(new Divider(64), Array("-E", "btor2", "--target-dir", "test_run_dir/" + getTestName))
  }
}

class DividerFormalSpec extends AnyFlatSpec with ChiselScalatestTester with Formal {
  behavior of "Divider with formal"
  it should "pass formal test" in {
    verify(new DividerInsideProp(64), Seq(BoundedCheck(4), BtormcEngineAnnotation))
  }
}

class DividerInsideProp(len: Int) extends Divider(len) {

  val propResQ = Reg(UInt(len.W))
  val propResR = Reg(UInt(len.W))

  when(io.in.fire && state === s_idle) {
    assume(io.in.bits(1) =/= 0.U)
    when(io.sign) {
      propResQ := (io.in.bits(0).asSInt / io.in.bits(1).asSInt).asUInt
      propResR := (io.in.bits(0).asSInt % io.in.bits(1).asSInt).asUInt
    }.otherwise {
      propResQ := io.in.bits(0) / io.in.bits(1)
      propResR := io.in.bits(0) % io.in.bits(1)
    }
  }
  when(io.out.valid) {
    assert(io.out.bits === Cat(propResR, propResQ))
  }
}
