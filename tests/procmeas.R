library(pomp)

pompExample(ou2)

po <- window(ou2,end=10)

set.seed(3434388L)

pmat <- parmat(coef(po),3)
sims <- simulate(po,states=T,obs=T,params=pmat)

dp <- dprocess(po,x=sims$states,times=time(po),params=pmat,log=T)
try(dprocess(po,x=sims$states[,,c(1,2,4)],times=time(po)[c(1,2,4)],params=pmat))
dm <- dmeasure(po,x=sims$states,y=obs(po),times=time(po),params=pmat,log=T)

apply(dp,1,sum)
apply(dm,1,sum)

dp1 <- dprocess(po,x=sims$states,times=time(po),params=coef(po),log=T)
dm1 <- dmeasure(po,x=sims$states,y=obs(po),times=time(po),params=coef(po),log=T)
stopifnot(identical(dp,dp1))
stopifnot(identical(dm,dm1))

x <- simulate(po,states=T,params=coef(po))
dp2 <- dprocess(po,x=x,times=time(po),params=coef(po),log=T)
dp3 <- dprocess(po,x=x,times=time(po),params=pmat,log=T)
stopifnot(identical(rbind(dp2,dp2,dp2),unname(dp3)))

dm2 <- dmeasure(po,x=x,y=obs(po),times=time(po),params=coef(po),log=T)
dm3 <- dmeasure(po,x=x,y=obs(po),times=time(po),params=pmat,log=T)
stopifnot(identical(rbind(dm2,dm2,dm2),unname(dm3)))

pomp(po,dprocess=function(x1, x2, t1, t2, params, ...) stop("yikes!")) -> po
try(dprocess(po,x=x,times=time(po),params=coef(po),log=T))
