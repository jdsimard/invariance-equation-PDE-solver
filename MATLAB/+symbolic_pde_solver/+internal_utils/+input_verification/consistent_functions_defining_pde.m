function [consistency_state] = consistent_functions_defining_pde(s_fn, ell_fn, f_fn)
%CONSISTENT_FUNCTIONS_DEFINING_PDES Check that the assumed
%conditions on the mappings s_fn, ell_fn, and f_fn actually hold.
%   s_fn, ell_fn, f_fn: symfuns
%
%   s_fn should have the same (non-zero) number of rows as inputs
%
%   s_fn and ell_fn should have the same (non-zero) number of inputs
%   
%   the (non-zero) number of rows of ell_fn should be equal to the number
%   of inputs to f_fn minus the (non-zero) number of rows of f_fn 
%
%   the mappings should satisfy s(0) = 0, ell(0) = 0, f(0,0) = 0
%
%   return: true if all conditions hold
%           false if a condition does not hold


  % s_fn should be a nu times 1 function with nu variables
  w_s = transpose(argnames(s_fn));
  s_nu_variables = length(w_s);
  s_formula = formula(s_fn);
  s_at_zeros = double(subs(s_formula, w_s, zeros(s_nu_variables,1)));
  [num_s_rows, num_s_cols] = size(s_at_zeros);
  if num_s_cols ~= 1
    % the mapping s(w) is not a column vector
    consistency_state = false;
    return;
  end
  if num_s_rows ~= s_nu_variables
    % the mapping s(w) does not have the same number of rows as inputs
    consistency_state = false;
    return;
  end
  if num_s_rows == 0
    % this is pathological, s is an empty object
    consistency_state = false;
    return;
  end
  if prod(s_at_zeros == zeros(s_nu_variables,1)) == 0
    % the mapping s(w) does not satisfy the condition s(0) = 0
    consistency_state = false;
    return;
  end
  
  % s is consistent up to this point, so rename for clarity
  nu = s_nu_variables;
  w = w_s;


  % to replace input variables
  % w_ell = argnames(ell_fn)
  % p = sym('p',[1 2])
  % ell(p) = subs(formula(ell_fn), w_ell, p)

  % ell_fn should be a m times 1 function with nu variables
  w_ell = transpose(argnames(ell_fn));
  ell_nu_variables = length(w_ell);
  ell_formula = formula(ell_fn);
  ell_at_zeros = double(subs(ell_formula, w_ell, zeros(ell_nu_variables,1)));
  [num_ell_rows, num_ell_cols] = size(ell_at_zeros);
  if num_ell_cols ~= 1
    % the mapping ell(w) is not a column vector
    consistency_state = false;
    return;
  end
  if ell_nu_variables ~= nu
    % the mapping ell(w) does not have the same number of inputs at s(w)
    consistency_state = false;
    return;
  end
  if num_ell_rows == 0
    % this is pathological, ell is an empty object
    consistency_state = false;
    return;
  end
  if prod(ell_at_zeros == zeros(ell_nu_variables,1)) == 0
    % the mapping ell(w) does not satisfy the condition ell(0) = 0
    consistency_state = false;
    return;
  end

  % s is consistent up to this point, so rename for clarity
  m_ell = num_ell_rows;
  

  % f_fn should be a n times 1 function with n+m variables; the first n
  % variables are assumed to be x, the last m variables are assumed to be u
  xu_f = transpose(argnames(f_fn));
  f_xu_variables = length(xu_f);
  f_formula = formula(f_fn);
  f_at_zeros = double(subs(f_formula, xu_f, zeros(f_xu_variables,1)));
  [num_f_rows, num_f_cols] = size(f_at_zeros);
  n_f = num_f_rows; % number of state variables to f
  m_f = f_xu_variables - n_f; %number of inputs to f
  if num_f_cols ~= 1
    % the mapping f(x,u) is not a column vector
    consistency_state = false;
    return;
  end
  if m_ell ~= m_f
    % the number of outputs of ell(w) and the number of inputs u to f(x,u)
    % are not the same
    consistency_state = false;
    return;
  end
  if n_f == 0
    % this is pathological, f is an empty object
    consistency_state = false;
    return;
  end
  if prod(f_at_zeros == zeros(n_f,1)) == 0
    % the mapping f(x,u) does not satisfy the condition f(0,0) = 0
    consistency_state = false;
    return;
  end

  % all seems to be good, return true
  consistency_state = true;
end