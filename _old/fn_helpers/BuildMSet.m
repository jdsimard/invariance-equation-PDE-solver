function [setM] = BuildMSet(rho,d)
	%Use recursion to generate the set of all m such that |m| = d
	%setM = BuildMSet(rho,d)
	%rho: dimension of state-space
	%d: total order (sum of powers) in a polynomial term
	
    %Note: the number of m's is equivalent to choosing with replacement, so choose(rho + d - 1, d) = (rho + d - 1)! / ( d! (rho - 1)!)
    %
    
	setM = [];
	if rho == 1
		setM = [setM; d];
	else
		for i = d : -1 : 0
			tail = BuildMSet(rho-1,d-i);
			for j = 1 : 1 : size(tail)*[1;0]
				setM = [setM; [i, tail(j,:)]];
			end
		end
	end
end

