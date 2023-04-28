function WriteInfoFile(fname, num_soln_outputs, num_soln_inputs, order_completed)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    %format: [n, rho, d]
    info_matrix = [num_soln_outputs, num_soln_inputs, order_completed];
    writematrix(info_matrix, fname);
end