# Centre_Manifold_PDE_Solver

Currently this project is in a messy state as I originally wrote it with the simple intent of using it to come up with PDE solutions that I could use as examples in my dissertation on interpolation and model reduction. I think it could be a useful tool so I will update this and turn it into a more general and useable package when I have some time.

#################

A MATLAB project I wrote for determining approximate solutions to PDEs having a Taylor series ansatz. I wrote this because it was desirable to have a symbolic representation for the approximation of the PDE solution when building interpolants of nonlinear systems, rather than just a numerical approximation.

It works by using the symbolic toolbox to determine Taylor series representations of the differential equation, differentiating the symbolic Taylor series representation of the PDE in order to isolate the coefficient associated to each monomial in the representation, and then solving for the coefficients of the Taylor series representation of the PDE solution in particular.

It can require large amounts of memory for handling big systems of PDEs with many independent variables when determining the coefficients for higher order monomial terms (a particular issue for my work in nonlinear model reduction). To avoid having wasted computational effort if a memory issue arises, the scripts in their current form save the solved coefficients to a file every time a family of monomials of particular degree has had their coefficients determined. That is, for example, if terms of the form x^d have been determined, but MATLAB runs out of memory in the middle of determining coefficients for monomials of the form x^{d+1}, then the coefficient up to and including x^d are not lost.

The coefficients are saved in a file, and can be retrieved in either the form of a coefficient matrix, or in the form of a symbolic function that can be used to evaluate the approximate PDE solution in MATLAB.
