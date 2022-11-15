package divider

import chisel3._
import chisel3.util._
import chiseltest._
import chiseltest.formal._
import org.scalatest.flatspec.AnyFlatSpec

class RestoringDividerSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "RestoringDivider"
  it should "pass test" in {
    test(new RestoringDivider(4)).withAnnotations(Seq(WriteVcdAnnotation)) { c =>
      c.io.op1.poke(5.S)
      c.io.op2.poke(3.S)

      c.io.outQ.expect(1.S)
      c.io.outR.expect(2.S)

      c.clock.step()

      // divide 0
      c.io.op1.poke(5.S)
      c.io.op2.poke(0.S)

      c.io.outQ.expect(-1.S)
      c.io.outR.expect(5.S)

      c.clock.step()
    }
  }
  it should "could emit low-firrtl" in {
    (new chisel3.stage.ChiselStage)
      .emitFirrtl(new RestoringDivider(64), Array("-E", "low", "--target-dir", "test_run_dir/" + getTestName))
  }
  it should "could emit btor2" in {
    (new chisel3.stage.ChiselStage)
      .emitFirrtl(new RestoringDivider(64), Array("-E", "btor2", "--target-dir", "test_run_dir/" + getTestName))
  }
}

class RestoringDividerFormalSpec extends AnyFlatSpec with ChiselScalatestTester with Formal {
  behavior of "RestoringDivider with formal"
  it should "pass formal test" in {
    verify(new RestoringDividerProp(4), Seq(BoundedCheck(1), BtormcEngineAnnotation))
  }
}

class RestoringDividerProp(len: Int = 64) extends RestoringDivider(len) {
  assume(io.op1(len - 1) === 0.U)
  assume(io.op2(len - 1) === 0.U)

  when(io.op2 === 0.S) {
    assert(io.outQ === -1.S)
  }.otherwise {
    assert(io.outQ === io.op1 / io.op2)
    assert(io.outR === io.op1 % io.op2)
  }
}
