function [fname_info, fname_soln] = SetupInfoAndSolnFiles(soln_num_outputs, soln_num_inputs, fname_prefix)
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
    fname_info = [fname_prefix, '_info.txt'];
    fname_soln = [fname_prefix, '_soln.txt'];
    known_degree = 0;
    WriteInfoFile(fname_info, soln_num_outputs, soln_num_inputs, known_degree);
    WriteSolnFile(fname_soln, []);
end