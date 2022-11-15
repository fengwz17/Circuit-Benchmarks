package nutshell

import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class DividerFixedClockSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "DividerFixedClock"
  it should "pass divid test" in {
    test(new DividerFixedClock(64)) { c =>
      c.io.in.valid.poke(true.B)
      c.io.in.bits(0).poke(10.U)
      c.io.in.bits(1).poke(2.U)
      c.clock.step(67)
      c.io.out.valid.expect(true.B)
      c.io.out.bits.expect("h00000000_00000000_00000000_00000005".U)
    }
    test(new DividerFixedClock(2)) { c =>
      c.io.in.valid.poke(true.B)
      c.io.in.bits(0).poke(3.U)
      c.io.in.bits(1).poke(1.U)
      c.clock.step(5)
      c.io.out.valid.expect(true.B)
      c.io.out.bits.expect("b0011".U)
    }
  }
  it should "could emit low-firrtl" in {
    (new chisel3.stage.ChiselStage)
      .emitFirrtl(new DividerFixedClock(64), Array("-E", "low", "--target-dir", "test_run_dir/" + getTestName))
  }
  it should "could emit btor2" in {
    (new chisel3.stage.ChiselStage)
      .emitFirrtl(new DividerFixedClock(64), Array("-E", "btor2", "--target-dir", "test_run_dir/" + getTestName))
  }
}
