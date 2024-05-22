function [eqns] = get_equations_for_all_coefficients_of_total_order(fn_e,desired_total_order)
%GET_EQUATIONS_FOR_ALL_COEFFICIENTS_OF_TOTAL_ORDER Summary of this function goes here
%   Detailed explanation goes here

  % in order to collect all the coefficient equations for a particular
  % total degree, we must first get a representation of all nonnegative
  % integer multisets of with elements summing to that degree
  w = argnames(fn_e);
  multiset_combos = fn_auxiliary.get_multiset_combinations(length(w),desired_total_order);

  % each row of multiset_combos uniquely represents a coefficient of fn_e
  % with total monomial order desired_total_order, so for each row of
  % multiset_combos get an equation
  %num_equations_to_get = size(multiset_combos,1);

  % This approach can made much more time efficient by grouping partial
  % derivatives with some common differentiation indices together, i.e. for
  % (2,1,1) and (2,0,2), first calculate the partial derivative associated
  % to (2,0,1) and then use it to calculate (2,1,1) and (2,0,2) with one
  % more partial derivative each without repeating operations. This would
  % use more space, less time.
  eqns = [];
  for i1 = 1 : 1 : size(multiset_combos,1)
    eqns = [eqns, fn_auxiliary.get_equation_for_coefficient(fn_e,multiset_combos(i1,:))];
  end

end

