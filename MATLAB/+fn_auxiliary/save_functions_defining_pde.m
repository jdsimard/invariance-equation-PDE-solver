function [consistency_state] = save_functions_defining_pde(s_fn, ell_fn,f_fn,filename)
%SAVE_FUNCTIONS_DEFINING_PDE Given the mappings s_fn, ell_fn, f_fn, if the
%mappings define a well-posed PDE then the are saved to the .mat file
%filename
%   s_fn, ell_fn, f_fn: consistent symfuns
%   filename: valid filename to save the symfuns to
%
%   the mappings are checked consistency in terms of dimensions and the
%   fixed point s(0) = 0, ell(0) = 0, and f(0,0) = 0, see the function
%   check_consistency_of_functions_defining_pde
%
%   return: true, if the mappings are consistent then the file has been
%           saved
%           false, if the mappings are not consistent then the file has not
%           been saved
  
  % check the consistency of the functions
  if fn_auxiliary.consistent_functions_defining_pde(s_fn,ell_fn,f_fn) == false
    % the functions don't form a well-posed PDE, return false
    consistency_state = false;
    return;
  end
  
  % check the filename is good TODO

  % save symbolic functions to the .mat file using the canonical function
  % names
  s = s_fn;
  ell = ell_fn;
  f = f_fn;
  save(filename, 's', 'ell', 'f','-mat');
  consistency_state = true;
end