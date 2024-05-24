function num_monomials = num_monomials_of_degree_d(num_inputs, d)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
  
  % the total number of monomials of a given total degree is the same as
  % choosing d items from num_inputs options with replacement, and is the
  % same at the number of unique multisets of non-negative integers having
  % entries summing to d
  num_monomials = nchoosek(num_inputs + d - 1, d);
end