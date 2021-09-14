## Resources
- https://tour.golang.org/
- https://golang.org/doc/effective_go
- https://golang.org/doc/faq
- https://gobyexample.com/

## Exported names
> In Go, a name is exported if it begins with a capital letter. For example, Pizza is an exported name, as is Pi, which is exported from the math package.

> pizza and pi do not start with a capital letter, so they are not exported.

> When importing a package, you can refer only to its exported names. Any "unexported" names are not accessible from outside the package.

Makes more sense than Python's underscore convention, in my opinion

## Declaration syntax

https://go.dev/blog/declaration-syntax - makes a good case for `name: type` style declarations (left to right readable, easier to parse, etc)

## Multiple results

> A function can return any number of results.

```go
func swap(x, y string) (string, string) {
	return y, x
}
```

## Named return values

> Go's return values may be named. If so, they are treated as variables defined at the top of the function.

> These names should be used to document the meaning of the return values.

I think that this is a good idea, there's nothing so inherently different about the inputs and outputs to a function,
 so why should the inputs be specified precisely/labled with names while the outputs are not? It's not symmetric.
However, there's still something weird about this:

```go
func split3(sum int) (x, y int) {
	x = sum * 4 / 9
	y = sum - x
	return 10, 5
	/* or, return y, x */
}
```

I labled my outputs as x and y (meaning variables x and y were defined on top), but ~~I did not return them~~ (see EDIT below). 
Nothing is forcing me to actually return what I said I would return, as long as the types match.
The same issue exists when passing arguments to functions, though, the only criteria for accepting arguments is that the peg is right-shaped for the hole.
Maybe worth taking a look at keyword/named arguments in Python. Positional vs named arguments.

"Naked return" in Go automatically returns the outputs you specified in the function declaration, so in that sense it's good/forces you to be consistent.
I can see how it can get confusing, one has to look to the top of the function to see what's being returned at the bottom (locality of mind and all that, not all on the screen at once so you lose frame of reference).
So is the right thing to just force the programmer to write `return x,y` (where x and y are whatever outputs you specified in the declaration)? Why/why not?

- Examples in other languages: http://rosettacode.org/wiki/Named_parameters
- Relevant link: https://web.archive.org/web/20070502112455/http://plg.uwaterloo.ca/~rgesteve/cforall/named_pars.html

EDIT: I misunderstood the construct, check this out

> In this example, a deferred function increments the return value i after the surrounding function returns. Thus, this function returns 2:

```go
func c() (i int) {
    defer func() { i++ }()
    return 1
}
```
So above when I wrote `return 10, 5`, that was equivalent to setting x to 10, y to 5, and then returning x and y. So the named return values ARE always what's being returned, just sometimes not explicitly by name. I don't know how I feel about this, with the amount of things Go yells at you about (e.g. braces not on same line), I feel like it could have afforded yelling at you for not returning the named return values explicitly by name.
