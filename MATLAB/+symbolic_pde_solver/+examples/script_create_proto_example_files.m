


n = 5;
m = 1;
nu = 2;

w = sym('w', [nu, 1]);
u = sym('u', [m, 1]);
x = sym('x', [n, 1]);

example_linear_linear_file_name = '+symbolic_pde_solver\+examples\proto_example_linear_linear.mat';
example_linear_nonlinear_file_name = '+symbolic_pde_solver\+examples\proto_example_linear_nonlinear.mat';
example_nonlinear_linear_file_name = '+symbolic_pde_solver\+examples\proto_example_nonlinear_linear.mat';
example_nonlinear_nonlinear_file_name = '+symbolic_pde_solver\+examples\proto_example_nonlinear_nonlinear.mat';

% create the linear example functions

% s and ell
S = [0, 1; -1, 0];
L = [1, 0];
s_linear(w) = S*w;
ell_linear(w) = L*w;
% f
n = 5;
m = 1;
A = diag(-2*ones(1,n)) + diag(ones(1,n-1),1) + diag(ones(1,n-1),-1);
B = zeros(n,m);
B(1,1) = 1;
f_linear([x;u]) = A*x + B*u;

% create the nonlinear example functions

% s and ell
mu = 1;
s_vdp(w) = [w(2); mu*(1 - w(1)^2)*w(2) - w(1)];
ell_vdp(w) = w(2)/4;
% f
f_nonlinear([x;u]) = A*x - ((x.^2)/2 + (x.^3)/3) + B*u;

% save the mappings to the various files
symbolic_pde_solver.internal_utils.file_io.save_functions_defining_pde(s_linear,ell_linear,f_linear,example_linear_linear_file_name);
symbolic_pde_solver.internal_utils.file_io.save_functions_defining_pde(s_linear,ell_linear,f_nonlinear,example_linear_nonlinear_file_name);
symbolic_pde_solver.internal_utils.file_io.save_functions_defining_pde(s_vdp,ell_vdp,f_linear,example_nonlinear_linear_file_name);
symbolic_pde_solver.internal_utils.file_io.save_functions_defining_pde(s_vdp,ell_vdp,f_nonlinear,example_nonlinear_nonlinear_file_name);


clear all;
