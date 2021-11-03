```c
int atoi(char s[])
{
        int n = 0;
        for(int i = 0; s[i] >= '0' && s[i] <= '9'; ++i)
                n = 10 * n + (s[i] - '0');
        return n;
}
```

```c
struct Person {
	char *name;
	int age;
};

/* ... */

struct Person jim = {"jim", 11};
struct Person joe = {.age=12, .name="joe"};
```

```c
/* using a union as opposed to wasting memory by having 
   both mutually exclusive attributes in a struct */
typedef struct {
        char *name;
        bool isrobot;
        union {
                char *personality;
                int firmware_version;
        }   
} character;
```

```c
/* bit fields */
struct Person {
   unsigned int age:3;
};
```

## Comma Operator
I came across this line:
```c
/* http://brainfuck.org/sbi.c */
if(!(prog = fopen(argv[1], "r"))) fprintf(stderr,"Can't open the file %s.\n", argv[1]),exit(1);
```
The `exit` called is tacked on to the `fprintf` call (this is not a bug). Cool! I use the comma operator in `for` loops often:
```c
for(int i = 0, size = items.size(); i < size; i++)
```
Other examples:
```c
if( y = f(x), x > y )
	...

if( ... )
   x = 2, y = 3;
```

## Advice

### [*An Empirical Study of the Reliability of UNIX Utilities*](http://pages.cs.wisc.edu/~bart/fuzz/) by Barton P. Miller
1. All array references should be checked for valid bounds. This is an argument for using range checking full-time. Even (especially!) pointer-based array references in C should be checked. This spoils the terse and elegant style often used by experienced C programmers, but correct programs are more elegant than incorrect ones.
2. All input fields should be bounded − this is just an extension of guideline (1). In UNIX, using ‘‘%s’’ without a length specification in an input format is bad idea.
3. Check all system call return values; do this checking even when a error result is unlikely and the response to a error result is awkward.
4. Pointer values should often be checked before being used. If all the paths to a reference are not obvious, an extra sanity check can help catch unexpected problems.
5. Judiciously extend your trust to others; they may not be as careful a programmer as you. If you have to use someone else’s program, make sure that the data you feed it has been checked. This is sometimes called ‘‘defensive programming’’.
6. If you redefine something to look too much like something else, you may eventually forget about the rede- finition. You then become subject to problems that occur because of the hidden differences. This may be an argument against excessive use of procedure overloading in languages such as Ada or C++.
7. Error handlers should handle errors. These routines should be thoroughly tested so that they do not intro- duce new errors or obfuscate old ones.
8. Goto statements are generally a bad idea. Dijkstra observed this many years ago [1], but some programmers are difficult to convince. Our search for the cause of a bad pointer in the prolog interpreter’s main loop was complicated by the interesting weaving of control flow caused by the goto statements.

[Advice for Writing Small Programs in C](https://www.youtube.com/watch?v=eAhWIO1Ra6M) by Sean Barrett

1. whenever you see strncpy(), there's a bug in the code. Nobody remembers if the `n` includes the terminating 0 or nor. I implemented it, and I never remember. I always have to look it up. Don't trust your memory on it. Same goes for all the `n` string functions.
2. be aware of all the C string functions that do strlen. Only do strlen once. Then use memcmp, memcpy, memchr.
3. assign strlen result to a const variable.
4. for performance, use a temporary array on the stack rather than malloc. Have it fail over to malloc if it isn't long enough. You'd be amazed how this speeds things up. Use a shorter array length for debug builds, so your tests are sure to trip the fail over.
5. remove all hard-coded string length maximums
6. make sure size_t is used for all string lengths
7. disassemble the string handling code you're proud of after it compiles. You'll learn a lot about how to write better string code that way
8. I've found subtle errors in online documentation of the string functions. Never use them. Use the C Standard. Especially for the `n` string functions.
9. If you're doing 32 bit code and dealing with user input, be wary of length overflows.
10. check again to ensure your created string is 0 terminated
11. check again to ensure adding the terminating 0 does not overflow the buffer
12. don't forget to check for a NULL pointer
13. ensure all variables are initialized before using them
14. minimize the lifetime of each variable
15. do not recycle variables - give each temporary its own name. Try to make these temporaries const, refactor if that'll enable it to be const.
16. watch out for `char` being either signed or unsigned
17. I structure loops so the condition is <. Avoid using <=, as odds are high that'll will result in a fencepost error
