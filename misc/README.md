# Miscellaneous Languages and Notes

dont want to pollute the root directory /too/ much

Some of the sections below were written by Subash Shankar.

### (Programming Language)-Related Turing Awards

* 1972 Edsger Dijkstra (1972): Art and science of PLs
* 1974 Donald Knuth: Analysis of Algos & Design of PLs
* 1976 Michael Rabin and Dana Scott: Nondeterministic machines
* 1977 John Backus: PL Specification (grammars)
* 1978 Robert Floyd: Formal semantics, PL verification/synthesis
* 1979 Kenneth Iverson: APL, PL theory and practice
 	- when all you have is a hammar everything looks like a nail
* 1980 Hoare: Hoare logic, CSP, other PL topics
* 1984 Niklaus Wirth: ALGOL, Euler, Modula, Pascal
* 1987 John Cocke: Optimizing compilers (and RISC)
* 1991 Robin Milner: LCS, ML, CCS, formal semantics
 	- caculus of communication systems
* 1996 Amir Pnueli: Temporal logic for formal methods
* 2001 Ole-Johan Dahl and Kristen Nygaard: Object-oriented PLs
* 2003 Alan Kay: Object Oriented PLs
* 2005 Peter Naur: PL and compiler design
* 2006 Frances Allen: Optimizing Compilers
* 2007 Ed Clarke, Allen Emerson and Joseph Sifakis: Model Checking
* 2008 Barbara Liskov: PL design foundations
* 2013 Leslie Lamport: Distributed systems


### Why Programming Languages Matter

* Some languages foster better (less buggy, cleaner, more
secure, etc.) software
* Some languages are easier to learn than others
* More tools in your toolchest, enables thinking about problems ”in the right way” (when all you have is a hammer, everything looks like a nail).
* Sapir–Whorf Hypothesis (Linguistics): Language structure determines our thought processes
	- 1979 Turing Award (Iverson): Notation as a Tool of Thought
* Research in PLs, SWE, Applied Logic, SW
* Analysis/Verification/Synthesis (Formal Methods)
* Efficiency: programmer, translation (compilation), execution


### Timeline
* 1801 Jacquard Loom: weaving patterns expressed as a sequence of “instructions” on punched cards
* 1840 Ada Lovelace (world’s first programmer) created iteration (?) for programming Babbage’s “Analytic Engine”
* 1940s 1GL: Machine Language
* 1940s 2GL: Assembly Language
* 1950s 3GL: High Level Language (HLL)
	+ 1954 Backus, etal: Fortran (Formula Translator)
	+ 1958 McCarthy, etal: LISP (List Processing Language)
	+ 1958 US/Euro committee: Algol (Algorithm Language)
	+ 1959 Hopper, etal: Cobol (Common Business Oriented Language)
* 1970s 4GL: Application- or Domain- Specific Languages (e.g., RPG, SAS, CASE (computer-aided software engineering), SQL,
Mathematica, visual)

### Criteria For Evaluating A Language
* Readability: How easy is it to read/understand a program?
* Writeability: How easy/fast is it to write a program?
* Reliability: Does the language support specification? And verification of conformance to specification?
* Portability
* Generality (across applications)
* Formal semantics for language
* Implementation and efficiency issues

#### Readiablity

* Simplicity
* Manageable set of features/constructs
* Minimal feature multiplicity (and overloading?)
* Orthogonality: Every combination of constructs can be used in every context
* Data types: adequate set
* Syantactic considerations: identifiers, statements, punctuation, keywords, etc.

#### Writability
* Simplicity and orthogonality again
* Support for abstraction:
	+ can you concentrate on one level of abstraction (ignoring details) when coding?
* Expressivity:
	+ appropriate predefined operators/functions convenient to express what you want, along with ways to specify operations

#### Reliability
* Type checking: Capture errors early in the software life cycle Exception Handling support
* Aliasing: Are there multiple ways of referring to same memory location (e.g., C pointers)? Not good for reliability!
* Programs in unreadable/unwritable PLs are likely to use unnatural approaches, reducing reliability
* Explicit language support for testing and formal verification?

---

## SNOBOL

## BLISS

BLISS is an "expression language" rather than a "statement language".

This means that every construct of the language that is not a declaration is an expression.

## pq (post query)
- unix shell db language
```
- prefix, e.g.  pq mackin* got all mackin, mackintosh, mackinson, etc
- soundex, e.g. pq mackin~ got all with the last name that sounding like mackin,
    so names such as mackin, mckinney, mckinnie, mickin, mikami, etc
```
- this soundex thing is cool
