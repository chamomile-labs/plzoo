## Bon

[Bon User's Manual](http://people.csail.mit.edu/saltzer/Multics/MHP-Saltzer-060508/filedrawers/180.btl-misc/Scan%204.PDF)

... --> BCPL --> ... --> Bon --> B --> new B --> C

> 44. Q:  What language preceded C?
>
> A: nb
> 
> Between B and C was NB. B was interpreted and typeless. NB was compiled and barely typed. C added structs and became powerful enough to rewrite the Unix kernel.
>
> 45. Q:  What language preceded B?
> 
> A: bon | fortran
> 
> BCPL is not the right answer.
> 
> https://commandcenter.blogspot.com/2020/01/unix-quiz-answers.html

---

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
