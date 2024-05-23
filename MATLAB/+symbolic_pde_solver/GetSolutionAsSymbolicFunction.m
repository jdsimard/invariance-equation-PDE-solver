function [pi_symfun, pi_properties] = GetSolutionAsSymbolicFunction(filename_properties,filename_coefficients)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
  [pi_symfun,pi_properties,success_state] = symbolic_pde_solver.internal_utils.solver.load_known_solution_as_symfun(filename_properties,filename_coefficients);
  if success_state == false
    disp('Retrieving the function from the named files was not successful. The save files may be inconsistent. Returning -1.');
    pi_symfun = -1;
  end

end