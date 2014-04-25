GraNoLa/M
=========

This is the reference distribution for the esoteric programming language
_GraNoLa/M_.

GraNoLa/M is a programming language in which the directed graph is the
only data type.  See the file `GraNoLa-M.markdown` in the `doc` directory
for a more complete description of the GraNoLa/M language.

This distribution also contains an interpreter for GraNoLa/M written in
Erlang, as `granolam.erl` in the `src` directory.

You need an Erlang compiler at least at language version 4.4 to compile
`granolam.erl`.  This program was developed with OTP/R8B, so that is the
recommended platform for using it, although more recent versions should
work as well.  (It has recently been tested with R17.)

To build the `granolam` module, run the script `make.sh`.

After the module is built, run the script `granolam_shell` in the `bin`
directory to start a GraNoLa/M shell.

Or you can run `bin/granolam run` _filename_ to run a GraNoLa/M program
written in a text file on the filesystem.  This uses `escript`, so you
don't have to build the module first.  But you need `realpath`.

To run the built-in test cases, start an Erlang shell and run

    granolam:test(N).

where _N_ is an integer from 1 to 7.
