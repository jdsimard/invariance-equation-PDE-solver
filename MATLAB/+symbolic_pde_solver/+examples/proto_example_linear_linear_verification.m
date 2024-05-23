

% Consider the solution of the PDE in the scenario where s(\omega),
% \ell(\omega), and f(x,u) are linear mappings, i.e. s(\omega) = S \omega, 
% \ell(\omega) = L \omega, and f(x,u) = A x + B u, where S is a \nu \times
% \nu matrix, L is a m \times \nu matrix, A is an n \times n matrix, and B
% is a n \times m matrix. In this case, the PDE takes the form
% \frac{\partial \pi}{\partial \omega} S \omega = A \pi(\omega) + B L \omega,
% and if the set of eigenvalues of S and the set of eigenvalues of A are
% disjoint, then the unique solution (in the space of analytic functions)
% to the PDE is also a linear mapping, \pi(\omega) = \Pi \omega, where \Pi
% is an n \times \nu matrix which is the unique solution to the Sylvester
% equation \Pi S = A \Pi + B L. Hence, this scenario provides a very simple
% first verification of the PDE solution approximator.

% Load the symbolic functions, symbolic variables, and associated
% dimensions
example_filepath = '+symbolic_pde_solver\+examples\proto_example_linear_linear.mat';
[fns.s,fns.ell,fns.f,vars.w,vars.u,vars.x,dim.nu,dim.m,dim.n] = symbolic_pde_solver.internal_utils.file_io.load_functions_defining_pde(example_filepath);





%%%%%%%%
% The following section calculates the exact solution to the PDE
%%%%%%%%

% We can collect the linear coefficients associated to a particular point
% (here, zero) of any differentiable mapping by finding the jacobian of the
% mapping and then evaluating it at the point. In this completely linear
% scenario, these linear coefficients completely determine the problem.
mats.S = double(subs(symbolic_pde_solver.internal_utils.symbolic.get_jacobian(fns.s), vars.w, zeros(size(vars.w,1),size(vars.w,2))));
mats.L = double(subs(symbolic_pde_solver.internal_utils.symbolic.get_jacobian(fns.ell), vars.w, zeros(size(vars.w,1),size(vars.w,2))));
mats.AandB = double(subs(symbolic_pde_solver.internal_utils.symbolic.get_jacobian(fns.f), vars.x, zeros(size(vars.x,1),size(vars.x,2))));
mats.A = mats.AandB(:,1:dim.n);
mats.B = mats.AandB(:,dim.n+1:dim.n+dim.m);

% Calculate the matrix \Pi as the solution to the Sylvester equation
mats.Pi = sylvester(-mats.A,mats.S,mats.B*mats.L);

% The exact solution to the PDE is \pi(\omega) = \Pi \omega
pi(vars.w) = mats.Pi*vars.w;






%%%%%%%%
% The following section uses the PDE solution approximator for comparison
%%%%%%%%
