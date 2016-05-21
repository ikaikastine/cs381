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
with all activation records

### Exercise 2. Static and Dynamic Scope


### Exercise 3. Parameter Passing
