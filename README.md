# Circuit-Benchmarks
Benmarks written in Chisel/Verilog/BTOR2/AIGER for circuit verification

## Benchmark for Divider Verification

Chisel and Verilog divider implementation.

### Chisel

* Restoring divider
* Nutshell fixed clock divider

### Verilog

* Non-opt non-restoring divider
  - high-level
  - low-level (`loop flattened`)
  - gate-level translated by [yosys](https://github.com/YosysHQ/yosys)
  
    ```
    read_verilog filename.v
    synth -flatten
    clean -purge
    abc -fast -g simple,MUX
    write_verilog filename-gl.v
    ```

* Dividers from [FMCAD'22](https://abs.informatik.uni-freiburg.de/src/projects_view.php?projectID=24) benchmark
  - gate-level opt-old/new non-restoring divider
  - gate-level restoring divider

### Aiger

Translated from Verilog by [yosys](https://github.com/YosysHQ/yosys)

```
read_verilog filename.v
synth -flatten
clean -purge
aigmap (abc -fast -g AND)
write_aiger -ascii -symbols filename.aag
```
