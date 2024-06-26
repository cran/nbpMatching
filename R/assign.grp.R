#' @include nonbimatch.R
NULL

#'Random Group Assignment
#'
#'Randomly assign each element into treatment group A or B.
#'
#'This function takes the matched pairs generated by nonbimatch and randomly
#'assigns each element to a group.
#'
#'@aliases assign.grp assign.grp,data.frame-method assign.grp,nonbimatch-method
#'@param matches A data.frame or nonbimatch object.  Contains information on
#'how to match the covariate data set.
#'@param seed Seed provided for random-number generation.  Default value of 68.
#'@param \dots Additional arguments, not used at the moment.
#'@return original data.frame with treatment group column
#'@exportMethod assign.grp
#'@author Cole Beck
#'@seealso \code{\link{nonbimatch}}
#'@examples
#'
#'df <- data.frame(id=LETTERS[1:25], val1=rnorm(25), val2=rnorm(25))
#'df.dist <- gendistance(df, idcol=1)
#'df.mdm <- distancematrix(df.dist)
#'df.match <- nonbimatch(df.mdm)
#'assign.grp(df.match)
#'assign.grp(df.match$matches)
#'

setGeneric("assign.grp", function(matches, seed=68, ...) standardGeneric("assign.grp"))
setMethod("assign.grp", "data.frame", function(matches, seed=68, ...) {
    if(exists(".Random.seed", envir = .GlobalEnv)) {
        save.seed <- get(".Random.seed", envir= .GlobalEnv)
        on.exit(assign(".Random.seed", save.seed, envir = .GlobalEnv))
    } else {
        on.exit(rm(".Random.seed", envir = .GlobalEnv))
    }
    n <- nrow(matches)
    if(n%%2 == 1) {
        stop("There must be an even number of elements")
    }
    if(!all(sapply(matches[,c(2,4)], is.numeric))) {
        stop("matches must contain numeric values in columns two and four")
    }
    pairs <- matches[matches[,2] < matches[,4], c(2,4)]
    if(!is.numeric(seed)) seed <- 68
    set.seed(seed)
    choices <- sample(c(TRUE, FALSE), n, replace=TRUE)
    choices <- choices[pairs[,1]]
    matches <- cbind(matches, treatment.grp=NA)
    matches$treatment.grp[ifelse(choices, pairs[,1], pairs[,2])] <- "A"
    matches$treatment.grp[ifelse(choices, pairs[,2], pairs[,1])] <- "B"
    matches
})

setMethod("assign.grp", "nonbimatch", function(matches, seed=68, ...) {
    assign.grp(matches$matches, seed, ...)
})
