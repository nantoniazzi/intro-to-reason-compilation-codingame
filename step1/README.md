# 1 - Compile and Run a Single Reason File

OCaml's compiler has a nice, flexible pre-processing step described in `run.sh`. A Reason file is just an ordinary OCaml file that leverages that feature. Therefore, everything that semantically works in OCaml should, in theory, work in Reason, and vice-versa.

We start with a shell file, `run.sh`, which, upon execution, compiles & runs the output.

@["Run"]({"stubs": ["step1/src/test.re", "step1/run.sh}, "command":"/bin/bash /project/target/step1/run.sh")
