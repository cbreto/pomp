setMethod(
  "trajectory",signature=signature(object="pomp"),
  definition=function (object, params, times, t0, as.data.frame = FALSE, ...,
    verbose = getOption("verbose",FALSE))
    trajectory.internal(object=object,params=params,times=times,t0=t0,as.data.frame=as.data.frame,...,verbose=verbose)
)

trajectory.internal <- function (object, params, times, t0,
  as.data.frame = FALSE, .getnativesymbolinfo = TRUE, ..., verbose) {

  ep <- paste0("in ",sQuote("trajectory"),": ")

  verbose <- as.logical(verbose)
  as.data.frame <- as.logical(as.data.frame)

  if (missing(times))
    times <- time(object,t0=FALSE)
  else
    times <- as.numeric(times)

  if (length(times)==0)
    stop(ep,sQuote("times")," is empty, there is no work to do",call.=FALSE)

  if (any(diff(times)<=0))
    stop(ep,sQuote("times"),
      " must be an increasing sequence of times",call.=FALSE)

  if (missing(t0))
    t0 <- timezero(object)
  else
    t0 <- as.numeric(t0)

  if (t0>times[1L])
    stop(ep,"the zero-time ",sQuote("t0"),
      " must occur no later than the first observation",call.=FALSE)
  ntimes <- length(times)

  if (missing(params)) params <- coef(object)
  if (is.list(params)) params <- unlist(params)
  if (length(params)==0) stop(ep,sQuote("params")," must be supplied",call.=FALSE)
  storage.mode(params) <- "double"

  params <- as.matrix(params)
  nrep <- ncol(params)
  paramnames <- rownames(params)
  if (is.null(paramnames))
    stop(ep,sQuote("params")," must have rownames",call.=FALSE)

  x0 <- init.state(object,params=params,t0=t0)
  nvar <- nrow(x0)
  statenames <- rownames(x0)
  dim(x0) <- c(nvar,nrep,1)
  dimnames(x0) <- list(statenames,NULL,NULL)

  type <- object@skeleton.type          # map or vectorfield?

  pompLoad(object,verbose=verbose)
  on.exit(pompUnload(object,verbose=verbose))

  if (type=="map") {

    x <- tryCatch(
      .Call(iterate_map,object,times,t0,x0,params,.getnativesymbolinfo),
      error = function (e) {
        stop(ep,"in map iterator: ",
          conditionMessage(e),call.=FALSE)
      }
    )
    .getnativesymbolinfo <- FALSE

  } else if (type=="vectorfield") {

    znames <- object@zeronames
    if (length(znames)>0) x0[znames,,] <- 0

    .Call(pomp_desolve_setup,object,x0,params,.getnativesymbolinfo)
    .getnativesymbolinfo <- FALSE

    X <- tryCatch(
      ode(
        y=x0,
        times=c(t0,times),
        method="lsoda",
        func="pomp_vf_eval",
        dllname="pomp",
        initfunc=NULL,
        parms=NULL,
        ...
      ),
      error = function (e) {
        stop(ep,"error in ODE integrator: ",conditionMessage(e),call.=FALSE)
      }
    )

    .Call(pomp_desolve_takedown)

    if (attr(X,"istate")[1L]!=2)
      warning(ep,"abnormal exit from ODE integrator, istate = ",attr(X,'istate')[1L],
        call.=FALSE) # nocov

    if (verbose) {
      deSolve::diagnostics(X)
    }

    x <- array(data=t(X[-1L,-1L]),dim=c(nvar,nrep,ntimes),
      dimnames=list(statenames,NULL,NULL))

    for (z in znames)
      for (r in seq_len(ncol(x)))
        x[z,r,-1] <- diff(x[z,r,])

  } else {

    stop(ep,"deterministic skeleton has not been properly specified",call.=FALSE)

  }

  dimnames(x) <- setNames(dimnames(x),c("variable","rep","time"))

  if (as.data.frame) {
    x <- lapply(
      seq_len(ncol(x)),
      function (k) {
        nm <- rownames(x)
        y <- x[,k,,drop=FALSE]
        dim(y) <- dim(y)[c(1L,3L)]
        y <- as.data.frame(t(y))
        names(y) <- nm
        y$time <- times
        y$traj <- as.integer(k)
        y
      }
    )
    x <- do.call(rbind,x)
    x$traj <- factor(x$traj)
  }

  x
}
