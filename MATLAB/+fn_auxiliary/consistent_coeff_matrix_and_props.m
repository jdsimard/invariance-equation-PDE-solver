function [consistency_state] = consistent_coeff_matrix_and_props(num_rows_coeffs_mat,num_cols_coeffs_mat,nu,n,known_degree)
%UNTITLED7 Summary of this function goes here
%   % check consistency of coefficients: n rows, (sum_{1}^{d} d + nu - 1 choose d) total columns

  % based upon the number of independent variables nu and the known
  % monomial total degree known_degree, calculate the expected number of
  % columns in the coefficients matrix
  expected_cols_in_coeffs_mat = 0;
  for i1 = 1 : 1 : abs(known_degree) %abs to prevent some infinite loop in case of negative argument
    expected_cols_in_coeffs_mat = expected_cols_in_coeffs_mat + nchoosek(nu + known_degree - 1, known_degree);
  end

  % check consistency of coefficients matrix and dimensions nu, n, and
  % known_degree
  if expected_cols_in_coeffs_mat ~= num_cols_coeffs_mat
    % the number of coefficient matrix columns is not consistent with the
    % number of variables nu and the known monomial total degree
    % known_degree, return false
    consistency_state = false;
  elseif n ~= num_rows_coeffs_mat
    % the number of coefficient matrix rows is not consistent with the
    % number of rows in the properties file, return false
    consistency_state = false;
  else
    % sizes are consistent, return true
    consistency_state = true;
  end

end