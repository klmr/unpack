library(unpack)

attach(list2env(list(
    assert = stopifnot
)))

assert(ls('package:unpack') == 'c')

assert(length(ls()) == 0L)

c[jan, feb, rest[]] = month.name

assert(all.equal(sort(ls()), c('feb', 'jan', 'rest')))

assert(jan == 'January')
assert(feb == 'February')
assert(all.equal(rest,  month.name[- (1 : 2)]))

f = function () {
    c[a, b, c] = 1 : 3
    assert(a == 1L)
    assert(b == 2L)
    assert(c == 3L)
}

f()
