## Homework 4: Runtime Stack, Scoping, Parameter Passing

### Exercise 1. Runtime Stack
Consider the following block. Assume static scoping and call-by-value parameter
passing.
```
{ int x;
  int y;
  y := 1;
  { int f(int x) {
      if x=0 then {
        y := 1 }
      else {
        y := f(x-1)*y+1 };
      return y;
    };
    x := f(2);
  };  
}
```
Illustrate the computations that take place during the evaluation of this block,
that is, draw a sequence of pictures each showing the complete runtime stack
with all activation records after each statement or function call.
```
0  []
1  [x:?]
2  [y:?, x:?]
3  [y:1, x:?]
4  [f{}, y:1, x:?]
11 [f{}, f{}, y:1, x:?]
>>
  5 [x:2, f{}, y:1, x:?]  
  8 [x:2, f{}, y:1, x:?]
  >>
    5 [x:1, x:2, f{}, y:1, x:?]
    8 [x:1, x:2, f{}, y:1, x:?]
    >>
      5 [x:0, x:1, x:2, f{}, y:1, x:?]
      6 [x:0, x:1, x:2, f{}, y:1, x:?]
      9 [res:1, x:0, x:1, x:2, f{}, y:1, x:?]
      <<
    8 [x:1, x:2, f{}, y:2, x:?]
    9 [res:2, x:1, x:2, f{}, y:2, x:?]
    <<
  8 [x:2, f{}, y:2, x:?]
  9 [res:5, x:2, f:{}, y:5, x:?]
  <<
11 [f:{}, y:5, x:5]
12 [y:5, x:5]
12 []  
```

### Exercise 2. Static and Dynamic Scope
Consider the following block. Assume call-by-value parameter passing.
```
{ int x;
  int y;
  int z;
  x := 3;
  y := 7;
  { int f(int y) { return x*y };
    int y;
    y := 11;
    { int g(int x) { return f(y) };
      { int y;
        y := 12;
        z := g(2);
      };
    };
  };
}
```
1. Which value will be assigned to z in line 12 under static scoping?
2. Which value will be assigned to z in line 12 under dynamic scoping?

### Exercise 3. Parameter Passing
Consider the following block. Assume dynamic scoping.
```
{ int y;
  int z;
  y := 7;
  { int f(int a) {
      y := a+1;
      return (y+a)
    };
    int g(int x) {
      y := f(x+1)+1;
      z := f(x-y+3);
      return (z+1)
    }
    z := g(y*2);
  };
}
```
What are the values of y and z at the end of the above block under the
assumption that both parameters a and x are passed:
1. Call-by-Name
2. Call-by-Need
