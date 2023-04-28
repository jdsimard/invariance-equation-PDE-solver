


%%
% Signal generator
%%

%Van der Pol oscillator in diagonal form
sig_gen.constants.mu = 4;
sig_gen.constants.c1 = sig_gen.constants.mu/2 + sqrt((sig_gen.constants.mu - 2)*(sig_gen.constants.mu + 2))/2;
sig_gen.constants.c2 = sig_gen.constants.mu/2 - sqrt((sig_gen.constants.mu - 2)*(sig_gen.constants.mu + 2))/2;
sig_gen.constants.k1 = inv(sig_gen.constants.c1 - sig_gen.constants.c2)*sig_gen.constants.mu*sig_gen.constants.c1*sig_gen.constants.c1;
sig_gen.constants.k2 = inv(sig_gen.constants.c1 - sig_gen.constants.c2)*sig_gen.constants.mu*sig_gen.constants.c1*(sig_gen.constants.c1 + 2*sig_gen.constants.c2);
sig_gen.constants.k3 = inv(sig_gen.constants.c1 - sig_gen.constants.c2)*sig_gen.constants.mu*sig_gen.constants.c2*(sig_gen.constants.c2 + 2*sig_gen.constants.c1);
sig_gen.constants.k4 = inv(sig_gen.constants.c1 - sig_gen.constants.c2)*sig_gen.constants.mu*sig_gen.constants.c2*sig_gen.constants.c2;
sig_gen.constants.C = [sig_gen.constants.c2, 0; 0, sig_gen.constants.c1];
sig_gen.constants.K1b = sig_gen.constants.k1*[sig_gen.constants.c2; -sig_gen.constants.c1];
sig_gen.constants.K2b = sig_gen.constants.k2*[sig_gen.constants.c2; -sig_gen.constants.c1];
sig_gen.constants.K3b = sig_gen.constants.k3*[sig_gen.constants.c2; -sig_gen.constants.c1];
sig_gen.constants.K4b = sig_gen.constants.k4*[sig_gen.constants.c2; -sig_gen.constants.c1];

%syms z1 z2;
sig_gen.dim = 2;
sig_gen.states = sym('zr', [sig_gen.dim,1]);
sig_gen.dynamics = sig_gen.constants.C*[sig_gen.states(1); sig_gen.states(2)] + sig_gen.constants.K1b*sig_gen.states(1)^3 + sig_gen.constants.K2b*sig_gen.states(1)*sig_gen.states(1)*sig_gen.states(2) + sig_gen.constants.K3b*sig_gen.states(1)*sig_gen.states(2)*sig_gen.states(2) + sig_gen.constants.K4b*sig_gen.states(2)^3;
sig_gen.output = sig_gen.states(1) + sig_gen.states(2);









%%
% Underlying system
%%

%circuit
underlying.dim = 10;
underlying.states = sym('xr', [underlying.dim,1]);
underlying.constants.u = sym('u');

underlying.constants.e1 = zeros(underlying.dim,1);
underlying.constants.e1(1) = 1;
underlying.dynamics = (-2*diag(ones(underlying.dim,1)) + diag(ones(underlying.dim-1,1),1) + diag(ones(underlying.dim-1,1),-1))*underlying.states + underlying.states.^2/2 + underlying.states.^3/3 + underlying.constants.e1*underlying.constants.u;
underlying.output = underlying.states(1);



















