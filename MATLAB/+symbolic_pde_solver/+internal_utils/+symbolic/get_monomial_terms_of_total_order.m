function [vec_monomial_terms] = get_monomial_terms_of_total_order(var_w,total_degree)
%GET_MONOMIAL_TERMS_OF_TOTAL_ORDER Summary of this function goes here
%   Detailed explanation goes here

  % construct a matrix containing, in rows, every possible combination of
  % non-negative integer powers summing to the total degree
  multi_set = symbolic_pde_solver.internal_utils.multiset.get_multiset_combinations(length(var_w),total_degree);

  % the total number of monomial terms that need to be constructed
  num_new_monomials = nchoosek(length(var_w) + total_degree - 1, total_degree);

  %ensure that var_w is a row, otherwise the elementwise power
  %var_w.^multi_set(row,:) yields a bad result
  if prod(size(var_w) == size(multi_set(1,:))) == 0
    var_w = transpose(var_w);
  end
  
  % for each row in multi_set, evaluate the corresponding power of each
  % element of var_w, then take the product of the powers to get the
  % monomial term, with total degree equal to total_degree, corresponding
  % to the multi_set row
  % the result is a properly ordered vector containing all the monomial
  % terms
  vec_monomial_terms = arrayfun(@(row) prod(var_w.^multi_set(row,:)), transpose(linspace(1,num_new_monomials,num_new_monomials)));
end

