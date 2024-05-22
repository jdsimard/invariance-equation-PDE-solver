function [nu,m,n,known_degree,solution_coefficients] = load_solution_files(filename_properties,filename_coefficients)
%LOAD_SOLUTION_FILES Summary of this function goes here
%   Detailed explanation goes here

  solution_properties = readcell(filename_properties);
  nu = solution_properties{1,2};
  m = solution_properties{2,2};
  n = solution_properties{3,2};
  known_degree = solution_properties{4,2};
  solution_coefficients = readmatrix(filename_coefficients);
end

