function IncrementKnownCoefficients(fname_info, fname_soln, sig_gen, underlying)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
       
    [n_f, rho_f, d_f] = ReadInfoFile(fname_info);
    pi_f_known = 0;
    z_vec_known = [];
    %d_f = 1;
    %Build known solution from coefficients in the data file
    [pi_f_known, z_vec_known, known_coeffs] = BuildKnownSolution(n_f, rho_f, d_f, fname_soln, sig_gen.states);
    
    
    
    
    %setup symbolic terms of the order to be solved
    curr_degree = d_f + 1;
    %build symbolic coefficients of size n times choose(curr_degree + rho - 1, curr_degree)
    new_coeffs = sym('pr', [n_f, nchoosek(curr_degree + rho_f - 1, curr_degree)]);
    %update the z_vec
    MSet_curr_degree = BuildMSet(rho_f, curr_degree);
    z_vec_new = [];
    z_vec_new = BuildNewTerms(MSet_curr_degree, rho_f, sig_gen.states);
    
    pi_f = pi_f_known + new_coeffs*z_vec_new;
    
    %get partial derivative of pi_f
    dpi_f = [];
    for i = 1 : 1 : rho_f
        dpi_f = [dpi_f, diff(pi_f, sig_gen.states(i))];
    end
    
    
    
    %build the PDE with the new symbolic terms and the known terms
    pde = zeros(n_f,1) == dpi_f*sig_gen.dynamics - subs(underlying.dynamics, [underlying.states; underlying.constants.u], [pi_f; sig_gen.output]);
    
    %determine an equation for each coefficient of degree curr_degree by taking derivatives of the PDE
    coeff_eqns = [];
    for i = 1 : 1 : size(MSet_curr_degree)*[1; 0]
        m_current = MSet_curr_degree(i,:);
        pde_derivative = pde;
        for j = 1 : 1 : rho_f
            if m_current(j) > 0
                pde_derivative = diff(pde_derivative, sig_gen.states(j), m_current(j));
            end
        end
        coeff_eqns = [coeff_eqns; subs(pde_derivative, sig_gen.states, zeros(rho_f,1))];
    end
    
    
    
    
    
    
    
    
    %determine the new coefficients
    coeff_solved = solve(vpa(coeff_eqns));
    coeff_names = fieldnames(coeff_solved);
    final_coeffs = new_coeffs;
    for i = 1 : 1 : numel(coeff_names)
        final_coeffs = subs(final_coeffs, coeff_names{i}, coeff_solved.(coeff_names{i}));
    end
    coeffs_to_write = [known_coeffs, final_coeffs];
    
    WriteInfoFile(fname_info, n_f, rho_f, d_f+1);
    WriteSolnFile(fname_soln, double(coeffs_to_write));
    
    pi_f_update = pi_f_known + double(final_coeffs)*z_vec_new;
    
    
    
    
end