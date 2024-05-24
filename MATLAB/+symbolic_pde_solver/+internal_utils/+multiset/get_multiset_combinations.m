function [multiset_combinations_matrix] = get_multiset_combinations(num_vars,total_degree)
%GET_MULTISET_COMBINATIONS Summary of this function goes here
%   Detailed explanation goes here

  %Use recursion to generate a matrix with rows containing all multisets m 
  % having entries that are non-negative integers such that the entries sum
  % to the total degree
	%
	%num_vars: the number of indices for the multiset
	%total_degree: total degree (sum of powers) in a monomial term
	
  %Note: the number of m's is equivalent to choosing with replacement, so 
  % nchoosek(num_vars + total_degree - 1, total_degree) = (num_vars + total_degree - 1)! / ( total_degree! (num_vars - 1)!)

  num_multisets = symbolic_pde_solver.internal_utils.multiset.num_monomials_of_order_d(num_vars,total_degree);
  multiset_combinations_matrix = zeros(num_multisets,num_vars);
	if num_vars == 1
    % if there is only one variable, there is only one multiset combination
    % of the total degree
    multiset_combinations_matrix = total_degree;
  else
    row_count = 0;
		for i1 = total_degree : -1 : 0
      % the set of multisets of with num_vars indices and total order d is
      % the union, for all i1 in {1,...,d}, of the set of multisets where
      % the first element is i1 and remaining elements are the sets of
      % multisets of the remaining num_var-1 indices and total order d-i1,
      % hence we can get the desired result recursively
			tail = symbolic_pde_solver.internal_utils.multiset.get_multiset_combinations(num_vars-1,total_degree-i1);
      num_rows_to_add = size(tail,1);
      multiset_combinations_matrix(row_count+1:row_count+num_rows_to_add,:) = [i1*ones(size(tail,1),1),tail];
      row_count = row_count + num_rows_to_add;
		end
	end
end

