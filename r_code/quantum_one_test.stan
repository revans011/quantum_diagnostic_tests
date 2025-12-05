
data {
  int<lower=0> N;
  int<lower=0, upper=N> y;
  real<lower=0> a_pi;
  real<lower=0> b_pi;
  real<lower=0> a_Se;
  real<lower=0> b_Se;
  real<lower=0> a_Sp;
  real<lower=0> b_Sp;
  real<lower=0> a_kappa;
  real<lower=0> b_kappa;
}

parameters {
  real<lower=0,upper=1> pi;
  real<lower=0,upper=1> Se;
  real<lower=0,upper=1> Sp;
  real<lower=0,upper=1> kappa;
  real<lower=-1,upper=1> eta;
}

transformed parameters {
  real gamma;
  real<lower=0,upper=1> p_pos;

  gamma = eta * sqrt( (1 - Sp) * Se );

  p_pos = (1 - Sp) * (1 - pi)
          + Se * pi;
}

model {
  pi    ~ beta(a_pi,    b_pi);
  Se    ~ beta(a_Se,    b_Se);
  Sp    ~ beta(a_Sp,    b_Sp);
  kappa ~ beta(a_kappa, b_kappa);
  eta   ~ normal(0, 0.3);

  y ~ binomial(N, p_pos);
}

