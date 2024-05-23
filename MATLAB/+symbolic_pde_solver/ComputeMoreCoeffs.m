function ComputeMoreCoeffs(filename_properties,filename_coefficients,filename_symfuns,num_to_increase_total_order)
%COMPUTEMORECOEFFS Summary of this function goes here
%   Detailed explanation goes here

  for i1 = 1 : num_to_increase_total_order
    if symbolic_pde_solver.internal_utils.solver.solve_coefficients_of_next_total_order(filename_properties,filename_coefficients,filename_symfuns) == false
      % solution generation failed
      error('--- Failed to calculate more coefficients for the solution.')
      %return;
    end
    disp('--- Determined coefficients for all monomials of a total degree.');
  end
  disp('--- Finished.');
end

