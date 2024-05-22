addpath('proto-examples\');

filename_fns_defining_pde = 'proto-examples\proto_example_linear_linear.mat';
S = [0, 1; -1, 0];
L = [1, 0];
A = diag(-2*ones(1,5)) + diag(ones(1,4),1) + diag(ones(1,4),-1);
B = zeros(5,1);
B(1) = 1;
PI = sylvester(-A,S,B*L);
%PI*S - A*PI - B*L

[symobs.s,symobs.ell,symobs.f,symobs.w,symobs.u,symobs.x,symobs.nu,symobs.m,symobs.n] = fn_auxiliary.load_functions_defining_pde(filename_fns_defining_pde);






% if there is no existing solution approximation, create the symbolic linear
% starting point
known_degree = 0;
current_degree = known_degree + 1;
new_coefficients = sym('Pi_', [symobs.n, symobs.nu]);
new_monomials = symobs.w;
pi_approx(symobs.w) = new_coefficients*new_monomials;
d_pi_approx = fn_auxiliary.get_jacobian(pi_approx);

% if there is an existing solution approximation, build up the known terms
% and create the symbolic terms for the next degree










% turn this into function
% need to ensure that all the inputs/outputs of each mappings are
% consistent
%form e
e(symobs.w) = formula(d_pi_approx)*formula(symobs.s) - subs(formula(symobs.f), [symobs.x; symobs.u], [formula(pi_approx); formula(symobs.ell)]);
d_e = fn_auxiliary.get_jacobian(e);
solved_coeffs_to_be_extracted = solve(d_e == zeros(size(d_e)));
names_new_coeffs = fieldnames(solved_coeffs_to_be_extracted);




% turn this into function
extracted_coeffs = new_coefficients;
for i1 = 1 : 1 : numel(names_new_coeffs)
  extracted_coeffs = subs(extracted_coeffs, names_new_coeffs{i1}, solved_coeffs_to_be_extracted.(names_new_coeffs{i1}));
end
numeric_new_coeffs = double(extracted_coeffs);
d = 1;
nu = symobs.nu;
m = symobs.m;
n = symobs.n;


% save solved coefficients and solution properties
filenames.prefix = 'solution';
filenames.properties = strcat(filenames.prefix,'_properties.','csv');
filenames.coefficients = strcat(filenames.prefix,'_coefficients.','csv');
filenames.symfuns = strcat(filenames.prefix,'_symfuns.','mat');
fn_auxiliary.save_solution_files(nu,m,n,d,numeric_new_coeffs,filenames.properties,filenames.coefficients);
fn_auxiliary.save_functions_defining_pde(symobs.s,symobs.ell,symobs.f,filenames.symfuns);

clear all;





filenames.prefix = 'solution';
filenames.properties = strcat(filenames.prefix,'_properties.','csv');
filenames.coefficients = strcat(filenames.prefix,'_coefficients.','csv');
filenames.symfuns = strcat(filenames.prefix,'_symfuns.','mat');

% load solved coefficients and solution properties
[read.nu, read.m, read.n, read.known_degree, read.coeffs] = fn_auxiliary.load_solution_files(filenames.properties,filenames.coefficients);
[readsym.s,readsym.ell,readsym.f,readsym.w,readsym.u,readsym.x,readsym.nu,readsym.m,readsym.n] = fn_auxiliary.load_functions_defining_pde(filenames.symfuns);

% check consistency of coefficients: n rows, (sum_{1}^{d} d + nu - 1 choose d) total columns
fn_auxiliary.consistent_coeff_matrix_and_props(size(read.coeffs,1),size(read.coeffs,2),read.nu,read.n,read.known_degree)

% build monomials associated to known coefficients of each degree