function [fn_e] = get_pde_error_function(fn_pi,fn_s,fn_ell,fn_f)
%GET_PDE_ERROR_FUNCTION Build the error function used for determining the
%PDE solution coefficients
%   Builds the function
%   e(w) = \frac{\partial \pi}{\partial w}s(w) - f(\pi(w),\ell(w)),
%   which is exactly equal to zero for all w if \pi is the exact solution
%   to the PDE. Choosing coefficients of the approximation to make the
%   leading coefficients of e(w) zero, and hence minimize the value of
%   e(w), is how the solution approximation is generated.
%
%   fn_s, fn_ell, fn_f: the consistent mappings defining the PDE
%   fn_pi: the solution (or approximated solution) to the PDE
%
%   return: fn_e, the error function
  
  % get the jacobian of pi, required for building the PDE
  d_pi = symbolic_pde_solver.internal_utils.symbolic.get_jacobian(fn_pi);
  
  % directly assign the symfun e(w) by converting symfuns of d_pi, pi, s,
  % ell, and f to sym equations and performing symbolic composition
  w = argnames(fn_s);
  xu = transpose(argnames(fn_f));
  fn_e(w) = formula(d_pi)*formula(fn_s) - subs(formula(fn_f), xu, [formula(fn_pi); formula(fn_ell)]);
end

