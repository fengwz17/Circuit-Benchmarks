# Circuit-Benchmarks
Benmarks written in Chisel/Verilog/BTOR2/AIGER for circuit verification

## Benchmark for Divider Verification

Chisel and Verilog divider implementation.

### Chisel

* Restoring divider
* Nutshell fixed clock divider

### Verilog

* Non-opt non-restoring divider
* gate-level divider from [FMCAD'22](https://abs.informatik.uni-freiburg.de/src/projects_view.php?projectID=24)
* gate-level divider translated by yosys
```
abc -fast -g simple,MUX
```

### Aiger

Translated from Verilog by yosys
```
read_verilog filename.v
synth -flatten
clean -purge
aigmap (abc -fast -g AND)
write_aiger -ascii -symbols filename.aag
```
