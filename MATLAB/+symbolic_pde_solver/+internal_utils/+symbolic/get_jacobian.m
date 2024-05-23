function d_sym_fun = get_jacobian(sym_fun)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
  sym_vars = argnames(sym_fun);
  d_sym_fun = cell2sym(arrayfun(@(index) diff(sym_fun, sym_vars(index), 1), linspace(1,length(sym_vars),length(sym_vars)), UniformOutput=false));
end