\name{parmat}
\alias{parmat}
\title{Create a matrix of parameters}
\description{
  \code{parmat} is a utility that makes a vector of parameters suitable for use in \pkg{pomp} functions.
}
\usage{
parmat(params, nrep = 1)
}
\arguments{
  \item{params}{
    named numeric vector or matrix of parameters.
  }
  \item{nrep}{
    number of replicates (columns) desired.
  }
}
\value{
  \code{parmat} returns a matrix consisting of \code{nrep} copies of \code{params}.
}
\author{Aaron A. King}
\examples{
  ## generate a bifurcation diagram for the Ricker map
  pompExample(ricker)
  p <- parmat(coef(ricker),nrep=500)
  p["r",] <- exp(seq(from=1.5,to=4,length=500))
  x <- trajectory(ricker,times=seq(from=1000,to=2000,by=1),params=p)
  matplot(p["r",],x["N",,],pch='.',col='black',xlab="log(r)",ylab="N",log='x')
}
