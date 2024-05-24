function num_monomials = num_monomials_of_order_one_to_d(num_inputs,d)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

  % the sum of the number of monomials of each total degree up to, and
  % including, d

  num_monomials = sum(arrayfun(@(order) symbolic_pde_solver.internal_utils.multiset.num_monomials_of_order_d(num_inputs, order), 1 : d));
end