library(pomp)

dat <- '"time";"reports"
0,0192307692307692;617
0,0384615384615385;638
0,0576923076923077;603
0,0769230769230769;655
0,0961538461538462;585
0,115384615384615;677
0,134615384615385;686
0,153846153846154;674
0,173076923076923;710
0,192307692307692;798
0,211538461538462;803
0,230769230769231;795
0,25;892
0,269230769230769;925
0,288461538461538;1000
0,307692307692308;1002
0,326923076923077;1088
0,346153846153846;1012
0,365384615384615;1043
0,384615384615385;1095
0,403846153846154;998
0,423076923076923;1045
0,442307692307692;1034
0,461538461538462;904
0,480769230769231;938
0,5;854
0,519230769230769;831
0,538461538461539;734
0,557692307692308;678
0,576923076923077;715
0,596153846153846;593
0,615384615384615;581
0,634615384615385;549
0,653846153846154;509
0,673076923076923;419
0,692307692307692;389
0,711538461538462;323
0,730769230769231;305
0,75;258
0,769230769230769;255
0,788461538461539;233
0,807692307692308;208
0,826923076923077;197
0,846153846153846;168
0,865384615384616;171
0,884615384615385;160
0,903846153846154;138
0,923076923076923;138
0,942307692307692;134
0,961538461538462;100
0,980769230769231;110
1;126
1,01923076923077;120
1,03846153846154;115
1,05769230769231;125
1,07692307692308;109
1,09615384615385;98
1,11538461538462;112
1,13461538461538;136
1,15384615384615;123
1,17307692307692;123
1,19230769230769;113
1,21153846153846;155
1,23076923076923;132
1,25;158
1,26923076923077;139
1,28846153846154;139
1,30769230769231;161
1,32692307692308;171
1,34615384615385;156
1,36538461538462;199
1,38461538461538;183
1,40384615384615;221
1,42307692307692;200
1,44230769230769;221
1,46153846153846;227
1,48076923076923;200
1,5;233
1,51923076923077;221
1,53846153846154;225
1,55769230769231;228
1,57692307692308;223
1,59615384615385;215
1,61538461538462;233
1,63461538461538;227
1,65384615384615;220
1,67307692307692;208
1,69230769230769;199
1,71153846153846;243
1,73076923076923;182
1,75;197
1,76923076923077;183
1,78846153846154;176
1,80769230769231;191
1,82692307692308;173
1,84615384615385;172
1,86538461538462;171
1,88461538461538;224
1,90384615384615;196
1,92307692307692;212
1,94230769230769;210
1,96153846153846;204
1,98076923076923;189
2;224
2,01923076923077;216
2,03846153846154;198
2,05769230769231;261
2,07692307692308;267
2,09615384615385;292
2,11538461538462;284
2,13461538461538;311
2,15384615384615;368
2,17307692307692;374
2,19230769230769;473
2,21153846153846;482
2,23076923076923;506
2,25;626
2,26923076923077;644
2,28846153846154;675
2,30769230769231;826
2,32692307692308;917
2,34615384615385;1014
2,36538461538462;1083
2,38461538461538;1174
2,40384615384615;1265
2,42307692307692;1244
2,44230769230769;1390
2,46153846153846;1468
2,48076923076923;1507
2,5;1468
2,51923076923077;1455
2,53846153846154;1470
2,55769230769231;1333
2,57692307692308;1294
2,59615384615385;1207
2,61538461538462;1126
2,63461538461538;1025
2,65384615384615;979
2,67307692307692;942
2,69230769230769;828
2,71153846153846;738
2,73076923076923;707
2,75;594
2,76923076923077;532
2,78846153846154;525
2,80769230769231;493
2,82692307692308;452
2,84615384615385;424
2,86538461538462;369
2,88461538461538;355
2,90384615384615;330
2,92307692307692;336
2,94230769230769;270
2,96153846153846;254
2,98076923076923;250
3;238
3,01923076923077;230
3,03846153846154;238
3,05769230769231;241
3,07692307692308;242
3,09615384615385;249
3,11538461538462;218
3,13461538461538;240
3,15384615384615;266
3,17307692307692;237
3,19230769230769;233
3,21153846153846;213
3,23076923076923;224
3,25;244
3,26923076923077;249
3,28846153846154;280
3,30769230769231;262
3,32692307692308;292
3,34615384615385;282
3,36538461538462;281
3,38461538461538;298
3,40384615384615;280
3,42307692307692;343
3,44230769230769;296
3,46153846153846;281
3,48076923076923;297
3,5;323
3,51923076923077;287
3,53846153846154;276
3,55769230769231;259
3,57692307692308;238
3,59615384615385;259
3,61538461538462;273
3,63461538461538;206
3,65384615384615;240
3,67307692307692;219
3,69230769230769;227
3,71153846153846;206
3,73076923076923;196
3,75;191
3,76923076923077;180
3,78846153846154;166
3,80769230769231;165
3,82692307692308;180
3,84615384615385;157
3,86538461538462;152
3,88461538461538;154
3,90384615384615;150
3,92307692307692;157
3,94230769230769;147
3,96153846153846;152
3,98076923076923;149
4;168
'

pomp(
  data=read.csv2(text=dat),
  times="time",
  t0=0,
  params=c(
    gamma=26,mu=0.02,iota=0.01,
    beta1=400,beta2=480,beta3=320,
    beta.sd=1e-3,
    pop=2.1e6,
    rho=0.6,
    S_0=26/400,I_0=0.001,R_0=1-26/400
  ),
  globals=Csnippet("
    static int nbasis = 3, degree = 3;
    static double period = 1.0;"),
  initializer=Csnippet("
    double m = pop/(S_0+I_0+R_0);
    S = nearbyint(m*S_0);
    I = nearbyint(m*I_0);
    R = nearbyint(m*R_0);
    cases = 0;
    W = 0;"
  ),
  rprocess=euler.sim(
    step.fun=Csnippet("
    int nrate = 6;
    double rate[nrate];		  // transition rates
    double trans[nrate];		// transition numbers
    double beta;
    const double *BETA = &beta1;
    double dW;
    double seasonality[nbasis];
    int k;

    if (nbasis <= 0) return;
    periodic_bspline_basis_eval(t,period,degree,nbasis,&seasonality[0]);
    for (k = 0, beta = 0; k < nbasis; k++)
      beta += seasonality[k]*BETA[k];

    // gamma noise, mean=dt, variance=(beta_sd^2 dt)
    dW = rgammawn(beta_sd,dt);

    // compute the transition rates
    rate[0] = mu*pop;		// birth into susceptible class
    rate[1] = (iota+beta*I*dW/dt)/pop; // force of infection
    rate[2] = mu;			// death from susceptible class
    rate[3] = gamma;	// recovery
    rate[4] = mu;			// death from infectious class
    rate[5] = mu; 		// death from recovered class

    // compute the transition numbers
    trans[0] = rpois(rate[0]*dt);	// births are Poisson
    reulermultinom(2,S,&rate[1],dt,&trans[1]);
    reulermultinom(2,I,&rate[3],dt,&trans[3]);
    reulermultinom(1,R,&rate[5],dt,&trans[5]);

    // balance the equations
    S += trans[0]-trans[1]-trans[2];
    I += trans[1]-trans[3]-trans[4];
    R += trans[3]-trans[5];
    cases += trans[3];		// cases are cumulative recoveries
    if (beta_sd > 0.0)  W += (dW-dt)/beta_sd;"
    ),
    delta.t=1/52/20
  ),
  skeleton=vectorfield(Csnippet("
    int nrate = 6;
    double rate[nrate];		// transition rates
    double term[nrate];		// terms in the equations
    double beta;
    const double *BETA = &beta1;
    double seasonality[nbasis];
    int k;

    periodic_bspline_basis_eval(t,period,degree,nbasis,&seasonality[0]);
    for (k = 0, beta = 0; k < nbasis; k++)
      beta += seasonality[k]*BETA[k];

    // compute the transition rates
    rate[0] = mu*pop;		// birth into susceptible class
    rate[1] = (iota+beta*I)/pop; // force of infection
    rate[2] = mu;			// death from susceptible class
    rate[3] = gamma;	// recovery
    rate[4] = mu;			// death from infectious class
    rate[5] = mu; 		// death from recovered class

    // compute the several terms
    term[0] = rate[0];
    term[1] = rate[1]*S;
    term[2] = rate[2]*S;
    term[3] = rate[3]*I;
    term[4] = rate[4]*I;
    term[5] = rate[5]*R;

    // balance the equations
    DS = term[0]-term[1]-term[2];
    DI = term[1]-term[3]-term[4];
    DR = term[3]-term[5];
    Dcases = term[3];		// accumulate the new I->R transitions
    DW = 0;			// no noise, so no noise accumulation"
  )
  ),
  rmeasure=Csnippet("
    double mean, sd;
    double rep;
    mean = cases*rho;
    sd = sqrt(cases*rho*(1-rho));
    rep = nearbyint(rnorm(mean,sd));
    reports = (rep > 0) ? rep : 0;"
  ),
  dmeasure=Csnippet("
    double mean, sd;
    double f;
    mean = cases*rho;
    sd = sqrt(cases*rho*(1-rho));
    if (reports > 0) {
      f = pnorm(reports+0.5,mean,sd,1,0)-pnorm(reports-0.5,mean,sd,1,0);
    } else {
      f = pnorm(reports+0.5,mean,sd,1,0);
    }
    lik = (give_log) ? log(f) : f;"
  ),
  fromEstimationScale=Csnippet("
    int k;
    const double *BETA = &beta1;
    double *TBETA = &Tbeta1;
    Tgamma = exp(gamma);
    Tmu = exp(mu);
    Tiota = exp(iota);
    for (k = 0; k < nbasis; k++)
      TBETA[k] = exp(BETA[k]);
    Tbeta_sd = exp(beta_sd);
    Trho = expit(rho);
    from_log_barycentric(&TS_0,&S_0,3);"
  ),
  toEstimationScale=Csnippet("
    int k;
    const double *BETA = &beta1;
    double *TBETA = &Tbeta1;
    Tgamma = log(gamma);
    Tmu = log(mu);
    Tiota = log(iota);
    for (k = 0; k < nbasis; k++) TBETA[k] = log(BETA[k]);
    Tbeta_sd = log(beta_sd);
    Trho = logit(rho);
    to_log_barycentric(&TS_0,&S_0,3);"
  ),
  statenames=c("S","I","R","cases","W"),
  paramnames=c(
    "gamma","mu","iota",
    "beta1","beta.sd","pop","rho",
    "S_0","I_0","R_0"
  ),
  zeronames=c("cases")
) -> euler.sir

## the following was originally used to generate the data
## simulate(po,nsim=1,seed=329343545L) -> euler.sir

c("euler.sir")
