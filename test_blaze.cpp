// [[Rcpp::depends(BH)]]
// [[Rcpp::plugins(cpp11)]]
#include <Rcpp.h>
#include <iostream>
#include <blaze/Math.h>

//[[Rcpp::export]]
Rcpp::NumericVector test_blaze1(Rcpp::NumericVector X){
  blaze::CustomVector<double, blaze::unaligned, blaze::unpadded> v( &X[0], X.size() );
  Rcpp::Rcout << v[0] << std::endl;
  Rcpp::Rcout << v[1] << std::endl;
  Rcpp::Rcout << v[2] << std::endl;
  Rcpp::Rcout << v[3] << std::endl;
  Rcpp::Rcout << v[4] << std::endl;
  return X;
}

//[[Rcpp::export]]
Rcpp::NumericMatrix test_blaze2(Rcpp::NumericMatrix X){
  blaze::CustomMatrix<double, blaze::unaligned, blaze::unpadded, blaze::columnMajor> v( &X[0], X.nrow(), X.ncol() );
  Rcpp::Rcout << v(0, 0) << std::endl;
  Rcpp::Rcout << v(0, 1) << std::endl;
  Rcpp::Rcout << v(0, 2) << std::endl;
  Rcpp::Rcout << v(1, 0) << std::endl;
  Rcpp::Rcout << v(1, 1) << std::endl;
  Rcpp::Rcout << v(1, 2) << std::endl;
  return X;
}

//[[Rcpp::export]]
Rcpp::NumericVector test_blaze3(Rcpp::NumericMatrix X, Rcpp::NumericVector y){
  blaze::CustomMatrix<double, blaze::unaligned, blaze::unpadded, blaze::columnMajor> a( &X[0], X.nrow(), X.ncol() );
  blaze::CustomVector<double, blaze::unaligned, blaze::unpadded> b( &y[0], y.size() );
  
  blaze::DynamicVector<double> c = a * b;
  Rcpp::NumericVector out(c.size());
  for (auto i = 0; i < c.size(); ++i) 
    out[i] = c[i];
  return out;
}
