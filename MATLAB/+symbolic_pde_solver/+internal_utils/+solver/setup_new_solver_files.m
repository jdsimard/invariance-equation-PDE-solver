function [consistency_state] = setup_new_solver_files(fn_s,fn_ell,fn_f,filename_properties,filename_coefficients,filename_symfuns)
%SETUP_NEW_SOLVER_FILES Summary of this function goes here
%   Detailed explanation goes here

  %filename_symfuns = strcat(filename_prefix,'_symfuns','.mat');
  %filename_properties = strcat(filename_prefix,'_props','.csv');
  %filename_coefficients = strcat(filename_prefix,'_coeffs','.csv');

  if symbolic_pde_solver.internal_utils.file_io.save_functions_defining_pde(fn_s,fn_ell,fn_f,filename_symfuns) == false
    % the functions are not consistent, don't save the files, return false
    consistency_state = false;
  else
    [s,ell,f,w,u,x,nu,m,n] = symbolic_pde_solver.internal_utils.file_io.load_functions_defining_pde(filename_symfuns);
    if symbolic_pde_solver.internal_utils.file_io.save_solution_files(nu,m,n,0,zeros(length(w),0),filename_properties,filename_coefficients) == false
      % this shouldn't happen because zeros(length(w),1) should be consistent
      % with nchoosek for known_degree = 0, but if it does happen for some
      % reason return false
      consistency_state = false;
    else
      consistency_state = true;
    end
  end

end

