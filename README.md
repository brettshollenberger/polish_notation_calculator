# Reverse Polish Notation Calculator

In Reverse Polish Notation (e.g. postfix notation), an operator follows all of its operands.

## Infix notation to postfix notation:

```
1 + 3         == (1 3 +)

1 + 3 * 2     == ((1 3 +) 2 *)

5 * 1 + 3 * 2 == (5 ((1 3 +) 2 *) *)
```

As is standard with parser-building, we can build a Polish Notation calculator by building trees where each node is either reducible or irreducible (terminal). We then strictly evaluate the functions--we reduce all operands until they are terminal nodes, and then apply the function to the operands.

Thanks to Ruby's metaprogramming magic, we can build the arguments like:

```ruby
def reduce
  left      = left.reducible?  ? left.reduce  : left.value
  right     = right.reducible? ? right.reduce : right.value
  operation = root.value

  left.send(operation, right)
end
```
