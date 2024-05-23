function [s, ell, f, w, u, x, nu, m, n] = load_functions_defining_pde(filename)
%LOAD_FUNCTIONS_DEFINING_PDE Summary of this function goes here
%   Detailed explanation goes here

  matfile_workspace = load(filename);

  s = matfile_workspace.s;
  ell = matfile_workspace.ell;
  f = matfile_workspace.f;

  % check consistency of mappings
  if symbolic_pde_solver.internal_utils.input_verification.consistent_functions_defining_pde(s,ell,f) == false
    % this is a bad save file, return
    return;
  end

  % if the mappings are consistent, then all of what follows should be good
  % behaviour

  % recover the symbolic variables of the mappings, and their dimensions, if everything is consistent
  w = transpose(argnames(s));
  nu = length(w);
  m = length(subs(formula(ell),w,zeros(nu,1)));
  xu = transpose(argnames(f));
  n = length(xu) - m;
  x = xu(1:n);
  u = xu(n+1:n+m);
end

