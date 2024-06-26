% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/subsetMatches.R
\name{subsetMatches}
\alias{subsetMatches}
\alias{subsetMatches,nonbimatch-method}
\title{Subset Matches}
\usage{
subsetMatches(
  matches,
  phantom = TRUE,
  chameleon = TRUE,
  ghost = TRUE,
  infinite = TRUE,
  halvesOnly = TRUE
)
}
\arguments{
\item{matches}{A nonbimatch object.}

\item{phantom}{A logical value.  Remove elements matched to phantom elements.}

\item{chameleon}{A logical value.  Remove elements matched to chameleon
elements.}

\item{ghost}{A logical value.  Remove elements matched to ghost elements.}

\item{infinite}{A logical value.  Remove elements matched at infinite
distance. This will include elements forced to match in spite of having an
infinite distance set by the prevent option in \code{\link{gendistance}}.}

\item{halvesOnly}{A logical value.  Use halves element instead of matches.}
}
\value{
a data.frame
}
\description{
Remove unpaired or unnecessary matches.
}
\details{
Given a nonbimatch object, remove elements matched to phantoms, chameleons, or
ghosts.  Also remove pairs whose distance is infinite.
}
\examples{

df <- data.frame(id=LETTERS[1:25], val1=rnorm(25), val2=rnorm(25))
df.dist <- gendistance(df, idcol=1, ndiscard=4)
df.mdm <- distancematrix(df.dist)
df.match <- nonbimatch(df.mdm)
subsetMatches(df.match)
subsetMatches(df.match, halvesOnly=FALSE)
subsetMatches(df.match, phantom=FALSE)

}
\author{
Cole Beck
}
