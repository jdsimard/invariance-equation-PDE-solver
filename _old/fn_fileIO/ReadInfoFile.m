function [num_soln_outputs, num_soln_inputs, order_completed] = ReadInfoFile(fname)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    info_matrix = readmatrix(fname);
    num_soln_outputs = info_matrix(1);
    num_soln_inputs = info_matrix(2);
    order_completed = info_matrix(3);
end