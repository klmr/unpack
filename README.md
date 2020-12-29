# Vector unpack assignment syntax for R

The ‘unpack’ package allows unpacking multiple values from a vector or list in a
single assignment expression. Unlike other packages, this package does not
require using a new operator or other, “convoluted” means.

## Usage

For example, we can unpack a specific, known number of variables:

```r
library(unpack)

c[a, b, c] = c('foo', 'bar', 'baz')

message(a) # foo
message(b) # bar
message(c) # baz
```

This looks like a subset assignment to a multi-dimensional array, `c`. But no
such array exists. The sole purpose of this syntax is to enable compound
assignment. The `c[…] = values` syntax intentionally mimics the inverse syntax
to create a vector from multiple values, i.e. `values = c(…)`.

And even though the ‘unpack’ package exports the name `c` to enable this, you
can still use the `c` function from base R. Both work side by side.

We can also specify that we want to unpack a fixed number of items, and keep the
rest inside a vector:

```r
c[first, second, rest[]] = month.name

message(first)  # January
message(second) # February
message(rest)   # March, April, May, …
```

Great!

And maybe we only cared about February, and want to ignore the rest:

```r
c[., feb, .[]] = month.name
message(feb) # February
```
