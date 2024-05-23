function SaveSolutionAsFunctionFile(filename_properties,filename_coefficients,filename_new_function)
%SAVESOLUTIONASFUNCTIONFILE Summary of this function goes here
%   Detailed explanation goes here
  %   Detailed explanation goes here
  [pi_symfun,pi_properties,success_state] = symbolic_pde_solver.internal_utils.solver.load_known_solution_as_symfun(filename_properties,filename_coefficients);
  if success_state == false
    disp('Retrieving the function from the named files was not successful. The save files may be inconsistent.');
  else
    matlabFunction(pi_symfun,'vars',{pi_properties.inputs},'file',filename_new_function,'outputs',{'pi_approx_eval'});
  end
  
end

