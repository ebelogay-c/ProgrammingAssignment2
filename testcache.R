## Testing script for Project 2

source("cachematrix.R")


## --- test data
a = matrix(1:4, 2,2) # invertible matrix
a
solve(a) # its regular inverse

## -- create new objects
ca = makeCacheMatrix(a) ## create a cached-inverse matrix
ca
cacheSolve(ca) ## 1st call: compute and cache
cacheSolve(ca) ## 2nd call: retrieve cached

## -- another cached object
cb = makeCacheMatrix(2*a) ## another cached-inverse matrix
cacheSolve(cb) ## 1st call: compute and cache; different inverse
solve(b) ## this is the correct inverse
cacheSolve(cb) ## 2nd call: retrieve cached inverse

## -- note: matrix expressions are not cached!
cacheSolve(makeCacheMatrix(a))
cacheSolve(makeCacheMatrix(a)) # not cached


## -- extra credit: plain input ;-)
cacheSolve(a) ## plain matrix input ok: no cached inverse, no problem


## -- singular input: complain exactly like solve()
s = matrix(c(1,2,2,4), 2,2) # singular matrix
s
## --- this must be the last line:  script will stop with error
cacheSolve(s) ## error, just like solve(s) -- will stop



