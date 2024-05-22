# invariance-equation-PDE-solver

Construct a symbolic expression for an approximation of the mapping $\pi : \mathbb{R}^{\nu} \rightarrow \mathbb{R}^{n}$ defined as the solution to the partial differential equation (PDE) with boundary condition
$$\frac{\partial \pi}{\partial \omega} s(\omega) = f\big(\pi(\omega),\ell(\omega)\big), \ \pi(0) = 0,$$
where $s : \mathbb{R}^{\nu} \rightarrow \mathbb{R}^{\nu}$, $\ell : \mathbb{R}^{\nu} \rightarrow \mathbb{R}^{m}$, and $f : \mathbb{R}^{n} \times \mathbb{R}^{m} \rightarrow \mathbb{R}^{n}$ are given smooth mappings satisfying $s(0) = 0$, $\ell(0) = 0$, and $f(0,0) = 0$. The approximate solution is given in the form of a truncated Taylor series representation containing all monomial terms up to a specified maximum total degree.

PDEs of this form show up frequently in control theory as they are associated to invariant manifolds. See applications in immersion and invariance controller design, nonlinear model reduction by moment matching, nonlinear model reduction in the Loewner framework, the KKL observer, and the centre manifold theory.

While there are many approaches to determining the solution to a PDE numerically, sometimes it is useful to have a symbolic solution to the PDE (for example, the solution must be embedded into a model in model reduction, and having a lookup table instead could cause the model to act piecewise continuous rather than smooth if care is not taken). One approach is to numerically solve the PDE and then try to fit a linear combination of basis functions to the numerical data. In this package, the approach is simply to use symbolic computation to determine the coefficients of a Taylor series representation of the PDE solution.

#################

Currently this project is in a messy state as I originally wrote it with the simple intent of using it to come up with PDE solutions that I could use as examples in my dissertation on interpolation and model reduction. I think it could be a useful tool so I will update this and turn it into a more general and useable package when I have some time.

#################

A MATLAB project I wrote for determining approximate solutions to PDEs having a Taylor series ansatz. I wrote this because it was desirable to have a symbolic representation for the approximation of the PDE solution when building interpolants of nonlinear systems, rather than just a numerical approximation.

It works by using the symbolic toolbox to determine Taylor series representations of the differential equation, differentiating the symbolic Taylor series representation of the PDE in order to isolate the coefficient associated to each monomial in the representation, and then solving for the coefficients of the Taylor series representation of the PDE solution in particular.

It can require large amounts of memory for handling big systems of PDEs with many independent variables when determining the coefficients for higher order monomial terms (a particular issue for my work in nonlinear model reduction). To avoid having wasted computational effort if a memory issue arises, the scripts in their current form save the solved coefficients to a file every time a family of monomials of particular degree has had their coefficients determined. That is, for example, if terms of the form x^d have been determined, but MATLAB runs out of memory in the middle of determining coefficients for monomials of the form x^{d+1}, then the coefficient up to and including x^d are not lost.

The coefficients are saved in a file, and can be retrieved in either the form of a coefficient matrix, or in the form of a symbolic function that can be used to evaluate the approximate PDE solution in MATLAB.
