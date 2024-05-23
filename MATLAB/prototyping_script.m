

filename_fns_defining_pde = '+symbolic_pde_solver\+examples\proto_example_linear_linear.mat';
[s,ell,f,w,u,x,nu,m,n] = symbolic_pde_solver.internal_utils.file_io.load_functions_defining_pde(filename_fns_defining_pde);
symbolic_pde_solver.internal_utils.solver.setup_new_solver_files(s,ell,f,'solution_proto_example_linear_linear');

clear all;

filenames.prefix = 'solution_proto_example_linear_linear';
filenames.properties = strcat(filenames.prefix,'_properties.','csv');
filenames.coefficients = strcat(filenames.prefix,'_coefficients.','csv');
filenames.symfuns = strcat(filenames.prefix,'_symfuns.','mat');

desired_total_order = 5;
for i1 = 1 : 1 : desired_total_order
  if symbolic_pde_solver.internal_utils.solver.solve_coefficients_of_next_total_order(filenames.properties,filenames.coefficients,filenames.symfuns) == false
    % the coefficients were not successfully determined for some reason,
    % exit
    return;
  end
  disp(['determined coefficients of total order ', num2str(i1)]);
end
disp('success!');
clear all;




% function to recover a known solution

% function to check the PDE error

