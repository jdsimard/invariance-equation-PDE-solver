function [fn_pi_approx,fn_properties,consistency_state] = load_known_solution_as_symfun(filename_properties,filename_coefficients)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
  %[s,ell,f,w,u,x,nu,m,n] = symbolic_pde_solver.internal_utils.file_io.load_functions_defining_pde(filename_symfuns);
  [fn_properties.size_input, fn_properties.m, fn_properties.size_output, fn_properties.known_degree, fn_properties.coeffs] = symbolic_pde_solver.internal_utils.file_io.load_solution_files(filename_properties,filename_coefficients);

  
  fn_properties.inputs = 0;
  consistency_state = true;
  if symbolic_pde_solver.internal_utils.input_verification.consistent_coeff_matrix_and_props(size(fn_properties.coeffs,1),size(fn_properties.coeffs,2),fn_properties.size_input,fn_properties.size_output,fn_properties.known_degree) == false
    %the contents of the solution file are inconsistent, return false
    fn_pi_approx = 0;
    consistency_state = false;
  elseif fn_properties.known_degree == 0
    % there is no solution to retrieve, return false
    fn_pi_approx = 0;
    consistency_state = false;
  else
    % generate input variables for pi
    fn_properties.inputs = sym('w',[fn_properties.size_input,1]);
    
    % generate the monomial terms for pi
    fn_properties.monomials = [fn_properties.inputs];
    for i1 = 2 : 1 : fn_properties.known_degree
      fn_properties.monomials = [fn_properties.monomials; symbolic_pde_solver.internal_utils.symbolic.get_monomial_terms_of_total_order(fn_properties.inputs,i1)];
    end
    
    % form the symbolic mapping pi
    fn_pi_approx(fn_properties.inputs) = fn_properties.coeffs*fn_properties.monomials;
  end
  
  

end