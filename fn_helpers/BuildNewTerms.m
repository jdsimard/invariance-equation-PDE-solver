function [var_vec_new] = BuildNewTerms(MSet_curr_degree,rho_f,z)
%UNTITLED6 Summary of this function goes here
%   Detailed explanation goes here
    var_vec_new = [];
    for i = 1 : 1 : size(MSet_curr_degree)*[1; 0]
        m_current = MSet_curr_degree(i,:);
        z_elem = 1;
        for j = 1 : 1 : rho_f
            z_elem = z_elem * z(j)^(m_current(j));
        end
        var_vec_new = [var_vec_new; z_elem];
    end
end