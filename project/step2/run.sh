# Explanations of compiler flags (when in doubt, there's always `ocamlc --help`)

# -pp: before processing the source file, pass it through a preprocessor. This
#      is a powerful feature that's at the heart of how the Reason syntax
#      transform works. We're basically taking a raw text file and piping it
#      through our custom lexer & parser, before handling over the valid OCaml
#      abstract syntax tree for actual compilation. For Reason's `refmt`
#      command, `refmt --print binary` prints the binary AST.
# -o: output file name.
# -impl: `ocamlc` recognizes, by default, `ml` files (and `mli`, which we'll
#        talk about later). Reason uses new file extensions, `re` (and `rei`).
#        In order to make `ocamlc` understand that `.re` is a normal source file
#        equivalent to a `.ml`, we pass the `impl` flag, meaning "this is an
#        implementation file" (as opposed to an interface file, `mli/rei`).
# -I: "search in that directory for dependencies". You may wonder why this is
#     necessary, given that we've already passed both files to the compiler.
#     Doesn't it already know where the sources are? It doesn't. In reality,
#     we're really just compiling two files independently, one after another,
#     in the specified order. You can imagine a parallelized build system which
#     invokes two separate `ocamlc` commands, one for each `.re` respectively.
#     In this case, the compiler wouldn't know about these source files since
#     they're not compiled together anymore.
#     The order of compilation is important! if you place `-impl src/test.re`
#     before `-impl src/myDep.re`, you'll get an error saying "Reference to
#     undefined global `MyDep'". `myDep.re` has to be compiled first. We're
#     effectively manually sorting the dependency graph (a topological sort)
#     right now. We'll change that soon.

# Example of wrong compilation order:
# ocamlc -pp refmt -o out -I src/ -impl src/test.re -impl src/myDep.re
ocamlc -pp "refmt --print binary" -o ./out -I src/ -impl src/myDep.re -impl src/test.re

# Run!
./out
