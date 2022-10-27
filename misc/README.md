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

*Clem:*
> The original DEC \[drum printers] were OEM'ed from Centronix and were noted for always being a little random on the hammer timing and thus the print on the paper often looked like the characters bounced on the line. I remember the ones we had on the PDP-10s were awful and the issue with BLISS is that the dot operator is extremely important to your code and the dots were sometimes notoriously missing.


## pq (post query)
- unix shell db language
```
- prefix, e.g.  pq mackin* got all mackin, mackintosh, mackinson, etc
- soundex, e.g. pq mackin~ got all with the last name that sounding like mackin,
    so names such as mackin, mckinney, mckinnie, mickin, mikami, etc
```
- this soundex thing is cool

## miranda

> Haskell was originally intended as a teaching language, and in particular as a less-license-encumbered version of the language Miranda, which was a popular teaching language at the time.

[https://en.wikipedia.org/wiki/Miranda\_(programming\_language)](https://en.wikipedia.org/wiki/Miranda_(programming_language))

## ISWIM

https://en.wikipedia.org/wiki/ISWIM

The Next 700 Programming Languages [URL](https://www.cs.cmu.edu/~crary/819-f09/Landin66.pdf)

## Fortress

> Fortress was designed from the outset to have multiple syntactic stylesheets. Source code can be rendered as ASCII text, in Unicode, or as a prettied image. This would allow for support of mathematical symbols and other symbols in the rendered output for easier reading. An emacs-based tool called fortify transforms ASCII-based Fortress source code into LaTeX output.[2]

> Fortress' designers made its syntax as close as possible to pseudocode and analyzed hundreds of computer science and mathematics papers, courses, books and journals using pseudocode to extract the common usage patterns of the English language and standard mathematical notation when used to represent algorithms in pseudocode. Then they made the compiler trying to maintain a one-to-one correspondence between pseudocode and executable Fortress.

## Jai

### Arbitrary Compile-Time Code Execution

Sometimes I get confused about compile-time execution, is the goal just to move as much run-time calculation to the compile-time stage (as a form of optimization)? Might as well run the whole program at compile-time and be done with it :P. That's only if I think too hard about it though. Saw this comment about C++ constexpr:
> The primary usage of constexpr is to declare intent.
Cool but not really that cool.

To me, the real cool part about compile-time code execution is demonstrated by this example from [JaiPrimer](https://github.com/BSVino/JaiPrimer/blob/master/JaiPrimer.md):

(my summary)

1. we want to implement `float linear_to_srgb(float f)`, can calculate in typical manner using `pow()` but that's slow, make a pre-calculated lookup table instead
2. write a helper program to build lookup table, paste results in lookup table in main program
3. So we now have to maintain two separate source codes. This can get unwieldy for large programs.
4. `srgb_table: [] float = #run generate_linear_srgb();`, #run invokes the compile time execution
5. > The compile-time function execution has very few limitations; in fact, you can run arbitrary code in your code base as part of the compiler. The first demonstration of Jai shows how to run an entire game as part of the compiler, and bake the data from the game into the program binary. The compiler builds the compile-time executed functions to a special bytecode language and runs them in an interpreter, and the results are funneled back into the source code. The compiler then continues as normal.

I often find myself writing a little program to generate parts of another program (then copying it over). It's usually like a python script or shell script with some hardcoded strings and string interpolation + basic logic, copy it, massage it in vim a little after pasting it into the main program, etc. METAPROGRAMMING.

If you combine this mechanism with something like Julia's exposing of the language's AST and so on, maybe you can do some really cool stuff.

Yeah, maybe I don't ever want to debug that in a giant legacy codebase (or do I? maybe it'll reduce code-duplication and make things simpler). Either way, not all programming has to be from the perspective of corporations.

### Integrated Build

> All information for building a program is contained within the source code of the program. Thus there is no need for a make command or project files to build a Jai program. As a simple example:
>
> ```
> build :: () {
>    build_options.executable_name = "my_program";
>    print("Building program '%'\n", build_options.executable_name);
>    build_options.optimization_level = Optimization_Level.DEBUG;
>    ...
>}
>
> #run build();
Cool idea

### Perl

Perl has some really weird parts that overall make me dislike it, but at times I find that I like it more than Python.

I really like the given/when construct; it's not super special but it feels good to write it:
```perl
sub cast {
   my ($data, $type) = @_;
   
   given ($type) {
       when ("csv") {
           my @csv = split ',', $data;
	   return \@csv;
       }
       when ([qw(integer long double float short byte]) {
           return $data * 1;
       }
       when ("boolean") {
           return min_es_version(6) ? bool($data) : $data * 1;
       }
       default {
           return $data;
       }
   }
}
```

"Perl defines its built-in data types based on their multiplicity rather than the semantic types commonly found in other languages"


### Tcl
Antirez's http://antirez.com/articoli/tclmisunderstood.html really made me like the idea of Tcl. I was biased against it by Stallman's Tcl diatribe, but now I realize I've been missing a string oriented metaprogramming language in my life... (see above discussion regarding me using strings in Python/shell scripts to generate other programs).

Random thought: I often use the Python REPL as a calculator. This is mostly limited to reasoning with numbers though. It would be cool to have a string calculator REPL (whatever that means). I kind of use vim like that already except the language is a bunch of random letters rather than an actual language...
