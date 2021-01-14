https://www.alexeyshmalko.com/2014/7-things-you-should-know-about-make/

https://github.com/stewartweiss/Make-Tutorial

---

Make supports variables to ease writing makefiles. They are assigned with
one of the following operators: `=`, `?=`, `:=`, `::=`, `+=`, `!=`.
The difference between them is the following:

* `=` assigns a deferred value to a variable. That means that value of the
variable will be computed every time variable is used. Be aware of that
 when assigning the result of shell command—shell command will be executed
 every time variable is read.

* `:=` and `::=` are essentially the same. Such assignment computes variable value once and just stores it. Simple and powerful. This type of assignment should be your default choice.

* `?=` works as `:=` if the variable was not defined, otherwise does nothing
. `+=` is append operator. The right-hand side is considered immediate if
 the variable was previously set with `:=` or `::=`, and deferred otherwise.
`!=` is a shell assignment operator. The right-hand side is evaluated immediately and handed to the shell. The result is stored in the variable named on the left.

