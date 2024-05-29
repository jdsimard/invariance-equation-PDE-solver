function [consistency_state] = save_solution_files(nu,m,n,known_degree,coefficients_matrix,filename_properties,filename_coefficients)
%SAVE_SOLUTION_FILES Summary of this function goes here
%   Detailed explanation goes here
  % check consistency of the solution properties and coefficients
  if symbolic_pde_solver.internal_utils.input_verification.consistent_coeff_matrix_and_props(size(coefficients_matrix,1),size(coefficients_matrix,2),nu,n,known_degree) == false
    % the solution properties and coefficients are inconsistent, don't
    % write the files, return false
    consistency_state = false;
  else
    % the properties are consistent, write the files
    writecell(cat(1,{'nu',nu},{'m',m},{'n',n},{'known_degree',known_degree}),filename_properties);
    if known_degree == 0
      %ran into an issue found on MATLAB R2021a where writematrix of an
      %empty matrix caused an error. The intentional behaviour was that an
      %empty file would be created, so we accomplish this using a file
      %handle now instead
      fid = fopen(filename_coefficients, 'w');
      fclose(fid);
    else
      writematrix(coefficients_matrix,filename_coefficients);
    end
    consistency_state = true;
  end
end

