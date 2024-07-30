



% Define consistent (as in composable) mappings s, ell, and f such that
% s(0)=0, ell(0)=0, f(0,0)=0. These should be symbolic functions in
% particular, not symbolic variables or expressions (see
% https://uk.mathworks.com/help/symbolic/create-symbolic-functions.html)

% dimensions of the functions
n = 5;
m = 1;
nu = 2;

% symbolic variables for inputs to symbolic functions
w = sym('w', [nu, 1]);
u = sym('u', [m, 1]);
x = sym('x', [n, 1]);

% define s and ell
S = [0, 1; -1, 0];
L = [1, 0];
s(w) = S*w;
ell(w) = L*w;

% define f (note that the input u that ell is substituted into should
% follow the input x when defining f, as this is assumed in the solver, 
% i.e. f([x;u]), not f([u;x]))
A = diag(-2*ones(1,n)) + diag(ones(1,n-1),1) + diag(ones(1,n-1),-1);
B = zeros(n,m);
B(1,1) = 1;
f([x;u]) = A*x - ((x.^2)/2 + (x.^3)/3) + B*u;





% we can now begin to generate a symbolic PDE solution approximation

% the solver will generate three files, we give it a prefix to use in the
% filenames
filenames_prefix = 'new_solution';

% we will initially compute the solution up to a total monomial degree of
% 3, i.e. we will determine the coefficients for the Taylor series
% representation of pi for the monomial terms w1, w2, w1^2, w1*w2, w2^2,
% w1^3, w1^2*w2, w1*w2^2, and w2^3
approximation_order = 3;

% create the new solution files and start computing coefficients
[fname.props, fname.coeffs, fname.symfuns] = symbolic_pde_solver.ComputeNewSolution(s,ell,f,approximation_order,filenames_prefix);

% everything is saved to the files now, and to compute further coefficients
% we only need to tell the solver the filenames
clear n m nu w u x S L s ell A B f filenames_prefix approximation_order;





% given an existing solution, compute coefficients for monomials of more
% total degrees

% given that a solution has been computed already, we would like to compute
% two more total monomial degrees of coefficients, so we will generate the
% coefficients associated to monomials w1^4, w1^3*w2, ..., w2^4, w1^5,
% w1^4*w2, ... , w2^5
times_to_increase_known_order = 2;
symbolic_pde_solver.ComputeMoreCoeffs(fname.props,fname.coeffs,fname.symfuns,times_to_increase_known_order);





% having generated the solution, we can now retrieve it in various ways

% we can retrieve the solution as a symbolic object, along with its 
% properties, for further symbolic computation
[pi_symfun, pi_symfun_properties] = symbolic_pde_solver.GetSolutionAsSymbolicFunction(fname.props,fname.coeffs);

% we can retrieve the solution as a matlab function handle, along with its
% properties, for performing numerical computations or simulations (note
% that the input of the function is a vector, not a comma separated list of
% scalars)
[pi_handle, pi_handle_properties] = symbolic_pde_solver.GetSolutionAsFunctionHandle(fname.props,fname.coeffs);

% we can save the solution as a matlab function .m file with the given name
fname.new_mfile_name = 'new_solution_function.m';
symbolic_pde_solver.SaveSolutionAsFunctionFile(fname.props,fname.coeffs,fname.new_mfile_name);










% function to check the PDE error
[s, ell, f, w, u, x, nu, m, n] = symbolic_pde_solver.internal_utils.file_io.load_functions_defining_pde(fname.symfuns);
fn_e = symbolic_pde_solver.internal_utils.symbolic.get_pde_error_function(pi_symfun,s,ell,f);
[C,T] = coeffs([1 0 0 0 0]*fn_e,'All');
joinCT = [transpose(T), vpa(transpose(C))];

