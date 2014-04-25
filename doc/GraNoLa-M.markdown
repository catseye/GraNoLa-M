GraNoLa/M - Graph Node Language Mark "M"
========================================

Introduction
------------

GraNoLa/M is a programming language that owes much of its heritage to
Tamerlane and Q-BAL, but hints of BASIC, LISP, FORTH, SETL, Muriel, and
Aardappel can be detected in faint outline.  It is widely believed to be a
subset of a much larger, PL/I-like language called 'GraNoLa/88800'.

Data Types
----------

The basic data type in GraNoLa/M is the directed graph.  Each vertex of
the graph (called a node) can be labelled and can contain a datum.  This
datum is itself a graph, and thus graphs (and the namespaces which their
labels make up) can be nested.  A graph is not the same thing as a drum.

Each node is defined by its name, which must not be used elsewhere in
this graph, and by a list of edges, connecting to either further new
node definitions, or backreferences to previous node definitions.  Note
that each node has an (ordered) list of edges and not just a set of
edges; we make no pretense of these being 'proper' graphs.

Actually, that different nodes have unique names and that backreferences
must be to existing nodes are mere convention, as well.  However, we
define here that a graph in which two nodes share the same label will
produce undefined behaviour.  A single backreference to a non-existent
node is a legal graph though, and this special case (called a nub) is
regarded differently in certain roles, usually something akin to an
'atom' in certain other languages.

Syntax
------

The following EBNF exemplifies the simplicity of the grammar for this
data type:

    Graph ::= "^" ExtantName | NewName ["=" Graph] "(" {Graph} ")".

That is, the syntactic representation of a graph starts with either a
caret followed by an existing label in the graph, or it starts with a
new label, optionally followed by an equals sign and a graph (to be
embedded,) followed by an open paren, any number of graphs (to connect
to), and a close paren.

So, some example GraNoLa/M graphs are:

    a(b(^a)c(^a)d(^a)e(^a))
    a(b(c(d(e(^a)))))
    a=a()(b=a(b())(^a))
    a=b=c=d=e()()()()(^a)
    ^potrzebie
    a=^#potrzebie(b=^uwaming(^a))

Semantics
---------

All GraNoLa/M operations work on graphs.  Actually they work on an
internal stack of graphs — actually the stack is nothing more than a
graph, but to avoid (and cause) confusion, we will call it a stack,
because mainly we are concerned with putting things into it and getting
things off of it.

In truth, there is a cursor which tells us where, in graph, we should be
pushing and popping things.

Pushing a graph onto the stack entails that we add the graph, as a node,
to a new edge in the current node in the stack, named by the cursor.

Popping a graph from the stack entails that we remove the last edge
(remember, it's an ordered list) from the current node named by the
cursor.

Execution
---------

A GraNoLa/M program is a graph.  For this reason the syntax of a legal
GraNoLa/M program is the same as the syntax for a graph, already given.

Embedded graphs within a program graph can be thought of as subprograms
or data, depending on whether they are executed or not.

Execution of a graph begins at the outermost (first defined) node. (That
would be node `a` in most of the examples given above.)

At each node, if there is an embedded graph, it is executed (in its own
context - it uses the same stack but it has it's own set of labels.)

When a nub is embedded in a node, it specifies an operation to perform
when executed, as in the case of the example `b=^uwaming(...)` above.

Execution then passes to another node.  An edge is picked by the
traversal method (random, first, or last) and the node at the other end
of the edge becomes the new current node.  The process repeats until a
degenerate node (with no outgoing edges) is encountered - this halts
execution of this (sub)program, returning to the parent program (if
there is one.)

Operations
----------

*   `#`label - push a nub onto the stack
*   `0`label - push an empty graph (node) onto the stack
*   `1`label - copy node with label from program onto stack
*   `@`label - set the cursor to label
*   `whebong` - push current (sub)program onto stack
*   `duronilt` - pop graph and replace current (sub)program with it
*   `chehy` - pop graph off of stack and use it as new stack
*   `taug` - push stack onto stack embedded into a new node
*   `soduv` - pop a graph, set execution order to first if it is empty, last if not
*   `rehohur` - pop and discard graph
*   `bimodang` - pop label and jump to it as subroutine in current program graph
*   `ubewic` - return from current subroutine (jump back to last bimodang)
*   `chuwakagathaz` - switch to nondeterministic execution order (default)
*   `sajalom` - deterministic execution order - use first edge
*   `grangnum` - deterministic execution order - use last edge 
*   `uwaming` - pop a graph off the stack and print it
*   `bejadoz` - input a graph (in GraNoLa/M syntax) and push it on the stack

Tests

    -> Functionality "Interpret GraNoLa/M Program" is implemented by
    -> shell command "bin/granolam %(test-body-file)"

    -> Tests for functionality "Interpret GraNoLa/M Program"

    | a=^#cthulhu(b=^uwaming(^a))
    = ??

    | a=^whebong(b=^uwaming(^a))
    = ??

    | a=^0hello(b=^@hello(c=^taug(d=^uwaming(^a))))
    = ??

    | a=^1hello(b=^uwaming(end=() hello=(world())))
    = ??

    | a=^sajalom(b=^#d(c=^bimodang(^a))
    = ??

    | d(e=^#sakura(f=^uwaming(g=^ubewic()))))
    = ??

    | a=^sajalom(b=^bejadoz(c=^soduv(^a d())))
    = ??
