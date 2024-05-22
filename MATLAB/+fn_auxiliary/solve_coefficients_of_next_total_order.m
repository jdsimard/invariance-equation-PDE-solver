function [success_state] = solve_coefficients_of_next_total_order(filename_properties,filename_coefficients,filename_symfuns)
%SOLVE_COEFFICIENTS_OF_NEXT_TOTAL_ORDER Summary of this function goes here
%   Detailed explanation goes here


  [nu, m, n, known_degree, coeffs] = fn_auxiliary.load_solution_files(filename_properties,filename_coefficients);
  [s,ell,f,w,u,x,extra.nu,extra.m,extra.n] = fn_auxiliary.load_functions_defining_pde(filename_symfuns);

  % check consistency of coefficients: n rows, (sum_{1}^{d} d + nu - 1 choose d) total columns
  if fn_auxiliary.consistent_coeff_matrix_and_props(size(coeffs,1),size(coeffs,2),nu,n,known_degree) == false
    % the functions don't form a well-posed PDE, return false
    success_state = false;
    return;
  end

  % build the pi approximation from the new symbolic terms + the known terms
  num_new_monomials = nchoosek(length(w) + known_degree, known_degree + 1);
  new_monomial_coefficients = sym('Pi_', [n, num_new_monomials]);
  new_monomial_terms = fn_auxiliary.get_monomial_terms_of_total_order(w,known_degree+1);
  pi_new_terms(w) = new_monomial_coefficients*new_monomial_terms;

  % if we already know some terms, add them to the pi approximation
  pi_known = 0;
  if known_degree > 0
    known_monomials = [];
    for i1 = 1 : 1 : known_degree
      known_monomials = [known_monomials; fn_auxiliary.get_monomial_terms_of_total_order(w,i1)];
    end
    pi_known = coeffs*known_monomials;
  end
  pi_approx = pi_known + pi_new_terms;


  % turn this into function

  e = fn_auxiliary.get_pde_error_function(pi_approx,s,ell,f);
  %d_e = [fn_auxiliary.get_equation_for_coefficient(e,[1,0]), fn_auxiliary.get_equation_for_coefficient(e,[0,1])];
  sys_of_coeff_eqns = fn_auxiliary.get_equations_for_all_coefficients_of_total_order(e,known_degree+1);
  solved_coeffs_to_be_extracted = solve(sys_of_coeff_eqns == zeros(size(sys_of_coeff_eqns)));


  numeric_new_coeffs = fn_auxiliary.extract_solved_coefficients(solved_coeffs_to_be_extracted,new_monomial_coefficients);

  known_degree = known_degree + 1;

  new_known_coeffs = [coeffs, numeric_new_coeffs];
  if fn_auxiliary.save_solution_files(nu,m,n,known_degree,new_known_coeffs,filename_properties,filename_coefficients) == false
    % the determined solution is not consistent with the given functions,
    % return false
    success_state = false;
    return;
  end
  if fn_auxiliary.save_functions_defining_pde(s,ell,f,filename_symfuns) == false
    % the given functions don't form a well-posed PDE, return false
    success_state = false;
    return;
  end

  success_state = true;
end

