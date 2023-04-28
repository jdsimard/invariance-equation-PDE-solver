function [soln, var_vec, known_coeffs] = BuildKnownSolution(n_f, rho_f, d_f, fname_soln, z)
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    var_vec = [];
    pi_f = 0;
    known_coeffs = [];
    if d_f > 0
        %build partial solution from known coefficients
        %z_vec = [];
        for i = 1 : 1 : d_f
            MSet_i = BuildMSet(rho_f,i);
            for j = 1 : 1 : size(MSet_i)*[1; 0]
                m_current = MSet_i(j,:);
                z_elem = 1;
                for k = 1 : 1 : rho_f
                    z_elem = z_elem * z(k)^(m_current(k));
                end
                var_vec = [var_vec; z_elem];
            end
        end
        known_coeffs = ReadSolnFile(fname_soln);
        pi_f = pi_f + known_coeffs*var_vec;
    end
    soln = pi_f;
end