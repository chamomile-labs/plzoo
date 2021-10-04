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
