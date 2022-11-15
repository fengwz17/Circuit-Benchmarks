package mini

import chisel3._
import chisel3.util._
import chiseltest._
import org.scalatest.flatspec.AnyFlatSpec

class DelaySpec extends AnyFlatSpec with ChiselScalatestTester {
  behavior of "Delay"
  it should "test" in {
    test(new Delay(64)) { c =>
      c.io.in1.poke(10.U)
      c.io.in2.poke(5.U)

      c.clock.step()

      c.clock.step()
      c.io.out.expect(15.U)
    }
  }
  it should "could emit low-firrtl" in {
    (new chisel3.stage.ChiselStage)
      .emitFirrtl(new Delay(64), Array("-E", "low", "--target-dir", "test_run_dir/" + getTestName))
  }
  it should "could emit btor2" in {
    (new chisel3.stage.ChiselStage)
      .emitFirrtl(new Delay(64), Array("-E", "btor2", "--target-dir", "test_run_dir/" + getTestName))
  }
}
