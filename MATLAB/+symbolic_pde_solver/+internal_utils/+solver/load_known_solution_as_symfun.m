function [fn_pi_approx,w,known_degree] = load_known_solution_as_symfun(filename_properties,filename_coefficients,filename_symfuns)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
  [s,ell,f,w,u,x,nu,m,n] = symbolic_pde_solver.internal_utils.file_io.load_functions_defining_pde(filename_symfuns);
  [nu, m, n, known_degree, coeffs] = symbolic_pde_solver.internal_utils.file_io.load_solution_files(filename_properties,filename_coefficients);

  
end