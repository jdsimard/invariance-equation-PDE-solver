function [extracted_coeff_matrix] = extract_solved_coefficients(solution_struct,sym_coeff_matrix)
%EXTRACT_SOLVED_COEFFICIENTS Convert the solved coefficient structure into
%a numeric coefficient matrix with the correct shape
%
%   solution_struct: a solution structure with fieldnames associated to the
%   symbolic coefficients of pi and the associated values (solution_struct
%   does not retain the original shape of the coefficient matrix)
%
%   sym_coeff_matrix: the symbolic coefficient matrix associated to pi,
%   which is necessary for extracting the fields of solution_struct while
%   also maintaining the correct matrix shape
%
%   return: extracted_coeff_matrix, the numeric matrix containing all the
%   solved coefficient values

  % get the names of the solved symbolic variables in the solution
  % structure
  names_of_coeffs = fieldnames(solution_struct);

  % we will build the numeric coefficient matrix by substituting solutions
  % into sym_coeff_matrix one element at a time
  partially_extracted_coeffs = sym_coeff_matrix;
  for i1 = 1 : 1 : numel(names_of_coeffs)
    % get the next symbolic variable from the list of solved names, then
    % substitute the value associated to that fieldname in the solution
    % struct into the symbolic matrix
    partially_extracted_coeffs = subs(partially_extracted_coeffs, names_of_coeffs{i1}, solution_struct.(names_of_coeffs{i1}));
  end
  % once all fieldnames in the solution struct have been considered, we can
  % get the full numeric coefficient matrix
  extracted_coeff_matrix = double(partially_extracted_coeffs);
end

