package nutshell

import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class DividerMiniSpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "DividerMini"
  it should "pass divid test" in {
    test(new DividerMini(64)) { c =>
      c.io.in1.poke(3.U)
      c.io.in2.poke(1.U)
      c.clock.step(66)
      c.io.out.expect("h00000000_00000000_00000000_00000003".U)
    }
    test(new DividerMini(2)) { c =>
      c.io.in1.poke(3.U)
      c.io.in2.poke(1.U)
      c.clock.step(4)
      c.io.out.expect("b0011".U)
    }
  }
  it should "could emit low-firrtl" in {
    (new chisel3.stage.ChiselStage)
      .emitFirrtl(new DividerMini(2), Array("-E", "low", "--target-dir", "test_run_dir/" + getTestName))
  }
  it should "could emit btor2" in {
    (new chisel3.stage.ChiselStage)
      .emitFirrtl(new DividerMini(2), Array("-E", "btor2", "--target-dir", "test_run_dir/" + getTestName))
  }
}
