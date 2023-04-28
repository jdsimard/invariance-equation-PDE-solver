



addpath('./fn_fileIO');
addpath('./fn_helpers');
addpath('./fn_user');




% Generate file name based on current time
[fname_info, fname_soln] = SetupInfoAndSolnFiles(underlying.dim, sig_gen.dim, char(datetime('now','TimeZone','local','Format','y-MM-d_HH-mm-ss')));



% Determine coefficients up to degree 3 by calling IncrementKnownCoefficients 3 times
desired_soln_order = 3;
for i = 1 : 1 : desired_soln_order
    IncrementKnownCoefficients(fname_info, fname_soln, sig_gen, underlying);
    display("Finished degree d=" + string(i));
end
clear i;
clear desired_soln_order;



% To use the solution in Matlab, get it from the file
[pi.coeffs, pi.vars, pi.extended_vars, pi.fun] = GetKnownSolutionFromFile(fname_info, fname_soln);


%subs(pi.fun, pi.vars, [0.1; 0.1])


%Even if a solution is no longer in the workspace, you can still recover it from the data file
[pi_old.coeffs, pi_old.vars, pi_old.extended_vars, pi_old.fun] = GetKnownSolutionFromFile('test_info.txt', 'test_soln.txt');