\name{get.sets}
\Rdversion{1.4.0}
\alias{get.sets}
\alias{get.sets,data.frame-method}
\title{
Get named sets of matches
}
\description{
Create a factor variable using the names from a matched data set.
}
\usage{
get.sets(matches, remove.unpaired=TRUE, ...)
}

\arguments{
  \item{matches}{
A data.frame object.  Contains information on how to match the covariate data set.
}
  \item{remove.unpaired}{
A boolean value.  The default is to remove elements matched to phantom elements.
}
  \item{\dots}{
Additional arguments, not used at this time.
}
}

\details{
Calculate a name for each pair by using the ID columns from the matched data set.  Return a factor of these named pairs.
}

\value{
a factor vector
}

\author{
Cole Beck
}

\examples{
df <- data.frame(id=LETTERS[1:25], val1=rnorm(25), val2=rnorm(25))
df.dist <- gendistance(df, idcol=1)
df.mdm <- distancematrix(df.dist)
df.match <- nonbimatch(df.mdm)
get.sets(df.match$matches)
# include the phantom match
get.sets(df.match$matches, FALSE)
}