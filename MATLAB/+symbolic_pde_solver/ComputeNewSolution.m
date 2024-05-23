function [filename_properties,filename_coefficients,filename_symfuns] = ComputeNewSolution(symfun_s,symfun_ell,symfun_f,desired_total_order,filenames_prefix)
%COMPUTENEWSOLUTION Summary of this function goes here
%   Detailed explanation goes here

  filename_symfuns = strcat(filenames_prefix,'_symfuns','.mat');
  filename_properties = strcat(filenames_prefix,'_props','.csv');
  filename_coefficients = strcat(filenames_prefix,'_coeffs','.csv');

  disp(['--- Making the new solution files: ',filename_symfuns,', ',filename_properties,', ',filename_coefficients,'.']);

  if symbolic_pde_solver.internal_utils.solver.setup_new_solver_files(symfun_s,symfun_ell,symfun_f,filename_properties,filename_coefficients,filename_symfuns) == false
    % the file initialization was unsuccessful, check that the provided
    % functions are consistent
    error('--- Failed to create the initial solution files.');
  elseif desired_total_order > 0
    % before beginning to solve, loading our symfuns back in gives us
    % everything we need to generate solutions
    %[s,ell,f,w,u,x,nu,m,n] = symbolic_pde_solver.internal_utils.file_io.load_functions_defining_pde(filename_fns_defining_pde);

    for i1 = 1 : 1 : desired_total_order
      if symbolic_pde_solver.internal_utils.solver.solve_coefficients_of_next_total_order(filename_properties,filename_coefficients,filename_symfuns) == false
        % the coefficients were not successfully determined for some reason,
        % exit
        return;
      end
      disp('--- Determined coefficients for all monomials of a total degree.');
    end
    disp('--- Finished.');
  else
    disp('--- Finished.');
    % don't do anything more, just stop at creating the initialization
    % files
  end

end

