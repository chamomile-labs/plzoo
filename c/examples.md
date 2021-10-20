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
