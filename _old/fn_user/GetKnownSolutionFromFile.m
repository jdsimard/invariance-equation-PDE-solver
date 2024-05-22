function [coeffs, sym_vars, sym_extended_vars, sym_fun] = GetKnownSolutionFromFile(fname_info, fname_soln)
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here
    [n_file, rho_file, d_file] = ReadInfoFile(fname_info);
    z_file = sym('zr', [rho_file, 1]);
    sym_vars = z_file;
    [sym_fun, sym_extended_vars, coeffs] = BuildKnownSolution(n_file, rho_file, d_file, fname_soln, z_file);
end