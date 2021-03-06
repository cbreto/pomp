setClass(
  "probe.matched.pomp",
  contains="probed.pomp",
  slots=c(
    transform="logical",
    est="character",
    fail.value="numeric",
    value="numeric",
    evals="integer",
    convergence="integer",
    msg="character"
  )
)

setMethod("$",signature=signature(x="probe.matched.pomp"),function(x, name)slot(x,name))

setMethod(
  "summary",
  "probe.matched.pomp",
  function (object, ...) {
    c(
      summary(as(object,"probed.pomp")),
      list(
        est=object@est,
        value=object@value,
        eval=object@evals,
        convergence=object@convergence
      ),
      if(length(object@msg)>0) list(msg=object@msg) else NULL
    )
  }
)

pmof.internal <- function (object, params, est, probes,
  nsim, seed = NULL, fail.value = NA,
  transform = FALSE, ...)
{

  ep <- paste0("in ",sQuote("probe.match.objfun"),": ")
  object <- as(object,"pomp")
  transform <- as.logical(transform)
  fail.value <- as.numeric(fail.value)
  if (missing(est)) est <- character(0)
  est <- as.character(est)
  if (missing(nsim)) stop(ep,sQuote("nsim")," must be specified",call.=FALSE)
  nsim <- as.integer(nsim)

  if (missing(params)) params <- coef(object)
  if (is.list(params)) params <- unlist(params)
  if ((!is.numeric(params))||(is.null(names(params))))
    stop(ep,sQuote("params")," must be a named numeric vector",call.=FALSE)
  if (transform)
    params <- partrans(object,params,dir="toEstimationScale")
  par.est.idx <- match(est,names(params))
  if (any(is.na(par.est.idx)))
    stop(ep,"parameter(s): ",sQuote(est[is.na(par.est.idx)])," not found in ",sQuote("params"),call.=FALSE)

  if (missing(probes)) stop(ep,sQuote("probes")," must be supplied",call.=FALSE)
  if (!is.list(probes)) probes <- list(probes)
  if (!all(sapply(probes,is.function)))
    stop(ep,sQuote("probes")," must be a function or a list of functions",call.=FALSE)
  if (!all(sapply(probes,function(f)length(formals(f))==1)))
    stop(ep,"each probe must be a function of a single argument",call.=FALSE)
  ## apply probes to data
  datval <- tryCatch(
    .Call(apply_probe_data,object,probes),
    error = function (e) {
      stop(ep,"applying probes to actual data: ",conditionMessage(e),call.=FALSE)
    }
  )

  function (par) {

    pompLoad(object)

    params[par.est.idx] <- par

    if (transform)
      tparams <- partrans(object,params,dir="fromEstimationScale")

    ## apply probes to model simulations
    simval <- tryCatch(
      .Call(
        apply_probe_sim,
        object=object,
        nsim=nsim,
        params=if (transform) tparams else params,
        seed=seed,
        probes=probes,
        datval=datval
      ),
      error = function (e) {
        stop(ep,"applying probes to simulated data: ",conditionMessage(e),call.=FALSE)
      }
    )

    ll <- tryCatch(
      .Call(synth_loglik,simval,datval),
      error = function (e) {
        stop(ep,"in synthetic likelihood computation: ",conditionMessage(e),call.=FALSE)
      }
    )
    pompUnload(object)
    if (is.finite(ll)||is.na(fail.value)) -ll else fail.value  # nocov
  }
}

setMethod(
  "probe.match.objfun",
  signature=signature(object="pomp"),
  function (object, params, est, probes,
    nsim, seed = NULL, fail.value = NA,
    transform = FALSE, ...)
    pmof.internal(
      object=object,
      params=params,
      est=est,
      probes=probes,
      nsim=nsim,
      seed=seed,
      fail.value=fail.value,
      transform=transform,
      ...
    )
)

setMethod(
  "probe.match.objfun",
  signature=signature(object="probed.pomp"),
  function (object, probes, nsim, seed, ...) {

    if (missing(probes)) probes <- object@probes
    if (missing(nsim)) nsim <- nrow(object@simvals)
    if (missing(seed)) seed <- object@seed

    probe.match.objfun(
      object=as(object,"pomp"),
      probes=probes,
      nsim=nsim,
      seed=seed,
      ...
    )
  }
)

setMethod(
  "probe.match",
  signature=signature(object="pomp"),
  function(object, start, est = character(0),
    probes, nsim, seed = NULL,
    method = c("subplex","Nelder-Mead","SANN","BFGS",
      "sannbox","nloptr"),
    verbose = getOption("verbose"),
    fail.value = NA,
    transform = FALSE,
    ...) {

    ep <- paste0("in ",sQuote("probe.match"),": ")

    pompLoad(object,verbose=verbose)

    if (missing(start)) start <- coef(object)
    if (missing(probes)) stop(ep,sQuote("probes")," must be supplied",call.=FALSE)
    if (missing(nsim)) stop(ep,sQuote("nsim")," must be supplied",call.=FALSE)

    method <- match.arg(method)
    est <- as.character(est)
    transform <- as.logical(transform)
    fail.value <- as.numeric(fail.value)

    m <- minim.internal(
      objfun=probe.match.objfun(
        object=object,
        params=start,
        est=est,
        probes=probes,
        nsim=nsim,
        seed=seed,
        fail.value=fail.value,
        transform=transform
      ),
      start=start,
      est=est,
      object=object,
      method=method,
      transform=transform,
      verbose=verbose,
      ...
    )

    coef(object) <- m$params

    pb <- tryCatch(
      probe(
        object,
        probes=probes,
        nsim=nsim,
        seed=seed
      ),
      error = function (e) {
        stop(ep,conditionMessage(e),call.=FALSE)
      }
    )

    pompUnload(object,verbose=verbose)

    new(
      "probe.matched.pomp",
      pb,
      transform=transform,
      est=est,
      fail.value=fail.value,
      value=m$value,
      evals=m$evals,
      convergence=m$convergence,
      msg=m$msg
    )
  }
)

setMethod(
  "probe.match",
  signature=signature(object="probed.pomp"),
  function(object, probes, nsim, seed, ...,
    verbose = getOption("verbose"))
  {
    if (missing(probes)) probes <- object@probes
    if (missing(nsim)) nsim <- nrow(object@simvals)
    if (missing(seed)) seed <- object@seed

    f <- selectMethod("probe.match","pomp")

    f(object=object,probes=probes,nsim=nsim,seed=seed,
      verbose=verbose,...)
  }
)

setMethod(
  "probe.match",
  signature=signature(object="probe.matched.pomp"),
  function(object, est, probes, nsim, seed, transform,
    fail.value, ..., verbose = getOption("verbose"))
  {
    if (missing(est)) est <- object@est
    if (missing(probes)) probes <- object@probes
    if (missing(nsim)) nsim <- nrow(object@simvals)
    if (missing(seed)) seed <- object@seed
    if (missing(transform)) transform <- object@transform
    if (missing(fail.value)) fail.value <- object@fail.value

    f <- selectMethod("probe.match","pomp")

    f(object=object,est=est,probes=probes,nsim=nsim,seed=seed,
      transform=transform,fail.value=fail.value,verbose=verbose,...)
  }
)
