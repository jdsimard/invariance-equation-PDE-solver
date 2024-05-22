function [multiset_combinations_matrix] = get_multiset_combinations(num_vars,total_degree)
%GET_MULTISET_COMBINATIONS Summary of this function goes here
%   Detailed explanation goes here

  %Use recursion to generate the set of all m such that |m| = d
	%setM = BuildMSet(rho,d)
	%rho: dimension of state-space
	%d: total order (sum of powers) in a polynomial term
	
    %Note: the number of m's is equivalent to choosing with replacement, so choose(rho + d - 1, d) = (rho + d - 1)! / ( d! (rho - 1)!)
    %
    
	multiset_combinations_matrix = [];
	if num_vars == 1
		multiset_combinations_matrix = [multiset_combinations_matrix; total_degree];
	else
		for i1 = total_degree : -1 : 0
			tail = fn_auxiliary.get_multiset_combinations(num_vars-1,total_degree-i1);
			for i2 = 1 : 1 : size(tail,1)
				multiset_combinations_matrix = [multiset_combinations_matrix; [i1, tail(i2,:)]];
			end
		end
	end
end

