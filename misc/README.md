# Miscellaneous Languages

dont want to pollute the root directory /too/ much

## misc notes

- orthogonality

```
Edsger Dijkstra: Art and Science of PLs
Donald Knuth: Analysis of Algorithms and Design of PLs
Michael Rabin and Dana Scott: Nondeterministic machines
John Backus: PL Specification (grammars)
Robert Floyd: Formal Semantics, PL verification/synthesis
Kenneth Iverson: APL, PL theory and pratice
        - when all you have is a hammar everything looks like a nail
Tony Hoare: Hoare logic, CSP, other PL topics
Niklaus Wirth : ALGOL, Euler, Modula, Pascal
John Cocke: Optimizing Compilers (and RISC)
Robin Milner: LCS, ML (language), CCS, formal semantics
        - caculus of communication systems
Amir Pnueli: Temporal logic for formal methods
Ole-Johan Dahl and Kristen Nygaard: Object-oriented PLs
Alan Kay: Object Oriented PLs
Peter Naur: PL and compiler design
Frances Allen: Optimizes Compilers
Ed Clarke, Allen Emerson, Joseph Sifakis: Model Checkingg
Leslie Lamport: Distributed systems
```

Why PLs matter
- some languages foster better software (less bugs,cleaner, more secure, etc)
- sapir-whorf hypothess (lingustics): language structure determines our thought process
	+ Iverson: Notation as a Tool of Thought
- chomsky, grammar, innate language for humans
- Efficiency: programmer efficiency, translation (compile), execution (runtime, memory)


---

## SNOBOL

## BLISS

BLISS is an "expression language" rather than a "statement language".

This means that every construct of the language that is not a declaration is an expression.

## Bon

[Bon User's Manual](http://people.csail.mit.edu/saltzer/Multics/MHP-Saltzer-060508/filedrawers/180.btl-misc/Scan%204.PDF)

... --> BCPL --> ... --> Bon --> B --> new B --> C
```bon
x + 3 
a := 5
b := (a := a+1) + a 
print(b + print(a))
```
Any statement may be suffixed with one of these clauses:
```bon
; while ...
; until ...
; if ...
; unless ...
; init ...
```
In each case, "..." stands for an expression. A suffixed statement may have a suffix; thus any number of suffixes are permitted.
```bon
i := 0
print(i := i+1); while i<10

i := 0
print(i := i+1); until i=10

print(i := i+=1); while i<10; init i:=0
```
Picks ith element from array and invokes it as a function
```
process(a, b, c)
f[i](x)
```
There is a single null value denoted "()". It's principal use is to supply empty arguments to function calls.

The namelist, i.e. all the current identifiers, can be printed by executing `dump()`. *if in "full" mode, then for each identifier its type, value, etc will also be printed*

The following line creates abbreviations "p(...)", "a(...)", "d(...)" for three
very common builtins `p,a,d := print,append,delete`

curious about where these came from and how they were kept/discarded between bon and c:
* walrus operator
* `*` and `&` for dereferencing and referencing (referred to as `pointer indirection` and `pointer creation`)
* string enclosed in single or double quotes
* zero converts to false, all other values to true
* `name` and `value` used in same way as `lvalue` and `rvalue` in c++
* `|` or, `&` and, `||` string concatenation, `^=` not equal, `^>` not greater than (wtf)
* `$` expects a string operand, which is interpreted as an identifiers
* distributive laws, -(1,2,3) means -1,-2,-3
* metaprogramming, `delete(1); while true` (deletes entire program), `print(label(2))` (prints second line)
* return()
* identifiers (names) don't turn into values automatically, you can have a list of names, or a list of values. to make coerce a name into a value you use the `[]` operators: `return([x])`
* has official BNF syntax
* arbitrary number of blanks may appear near syntactic structures (except for some exceptions)

## pq (post query)
- unix shell db language
```
- prefix, e.g.  pq mackin* got all mackin, mackintosh, mackinson, etc
- soundex, e.g. pq mackin~ got all with the last name that sounding like mackin,
    so names such as mackin, mckinney, mckinnie, mickin, mikami, etc
```
- this soundex thing is cool
