## Creates a matrix object that caches its inverse.

## The caching is enabled by the lexical scoping mechanism in R
## and implemented by the `<<-` operator.
## The (possibly cached) inverse of the matrix
## is returned by `cacheSolve`, for example:
##
## m = matrix(1:4, 2, 2)
## cm = makeCacheMatrix(m)
## inv1 = cacheSolve(cm) ## computed and cached
## inv2 = cacheSolve(cm) ## retrieved from cache

makeCacheMatrix <- function(x = matrix()) {

    ## "private" member: cached inverse
    cinv <- NULL

    ## matrix accessors
    get <- function() x
    set <- function(v) {
        x <<- v; ## save to creating enviro
        cinv <<- NULL ## invalidate cache
    }

    ## cache accessors
    getInv <- function() cinv
    setInv <- function(v) cinv <<- v

    ## return a named list of "object methods"
    list(get = get,
         set = set,
         getInv = getInv,
         setInv = setInv)

}#makeCacheMatrix


## Returns the (possibly cached) inverse of a matrix.

## Pre-condition:
## The matrix must be invertible and
## must have been created with the `makeCacheMatrix()`
## factory method ("constructor").

## The inverse is (lazily) computed only once,
## namely, the first time it is needed.
## After that, the cached value is returned.
## If the inverse is never needed (cacheSolve never called),
## it is never computed (hence the term "lazy evaluation").

cacheSolve <- function(x, ...) {
    ## Return a matrix that is the inverse of 'x'

    ## Is this a cached-inverse or a plain matrix?
    isCachedMatrix <- is.list(x) && length(x[["getInv"]]) > 0

    ## Plain matrix: solve() pass-through
    if (!isCachedMatrix) {
        ## Regular matrix: compute inverse every time
        message("regular matrix: computing inverse")
        # compute inverse; issue errors just like regular solve
        return(solve(x))
    }

    ## Cahed-inverse: has the inverse been cached?
    ## If yes, just return it
    if (!is.null(x$getInv())) {
        message("getting cached inverse")
        return(x$getInv())
    }

    ## If not yet cached, compute it and cache it
    message("computing and caching inverse")
    # compute it
    ret <- solve(x$get())
    # cache it
    x$setInv(ret)

    ## return it
    return(ret)

}# cacheSolve
