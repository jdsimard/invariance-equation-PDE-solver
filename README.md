# symbolic-PDE-solver

# Purpose

Construct a symbolic expression for an approximation of the mapping $\pi : \mathbb{R}^{\nu} \rightarrow \mathbb{R}^{n}$ defined as the solution to the partial differential equation (PDE) with boundary condition
$$\frac{\partial \pi}{\partial \omega} s(\omega) = f\big(\pi(\omega),\ell(\omega)\big), \quad \pi(0) = 0,$$
where $s : \mathbb{R}^{\nu} \rightarrow \mathbb{R}^{\nu}$, $\ell : \mathbb{R}^{\nu} \rightarrow \mathbb{R}^{m}$, and $f : \mathbb{R}^{n} \times \mathbb{R}^{m} \rightarrow \mathbb{R}^{n}$ are given smooth mappings satisfying $s(0) = 0$, $\ell(0) = 0$, and $f(0,0) = 0$. The approximate solution is given in the form of a truncated Taylor series representation containing all monomial terms up to a specified maximum total degree.

# Motivation

PDEs of this form show up frequently in control theory as they are associated to invariant manifolds. This can be observed by considering the dynamic system given by the interconnection of the systems
$$\dot{\omega} = s(\omega), \quad v = \ell(\omega),$$
and
$$\dot{x} = f(x,u), \quad u = v,$$
or
$$\dot{\omega} = s(\omega), \quad \dot{x} = f\big(x,\ell(\omega)\big).$$
Assuming that there exists an invariant manifold associated to this interconnected system described by a differentiable mapping $x = \pi(\omega)$ (meaning that if $x(t_i) = \pi(\omega(t_i))$ for some $t_i \in \mathbb{R}$, then $x(t) = \pi(\omega(t))$ for all $t \in \mathbb{R}$), this mapping must satisfy
$$\dot{x} = \dot{\overbrace{\pi(\omega)}} = \frac{\partial \pi}{\partial \omega} \dot{\omega},$$
and substitution of the system dynamics for the time derivatives further implies
$$f\big(x,\ell(\omega)\big) = \frac{\partial \pi}{\partial \omega} s(\omega).$$
Finally, by assumption of invariance we substitute $\pi(\omega)$ for $x$, so
$$\frac{\partial \pi}{\partial \omega} s(\omega) = f\big(\pi(\omega),\ell(\omega)\big).$$
Substituting $\omega = 0$ into this equation yields
$$\left(\frac{\partial \pi}{\partial \omega} \circ 0\right) s(0) = f\big(\pi(0),\ell(0)\big) \Rightarrow 0 = f\big(\pi(0),0\big) \Rightarrow \pi(0) = 0.$$
If the origin $(\bar{\omega},\bar{x}) = (0,0)$ is not an equilibrium point, then so long as an equilibrium point somewhere in the state-space actually exists we can perform an affine coordinates transformation such that in the new coordinates the origin is an equilibrium point, and then the aforementioned analysis still holds. Note that the existence of other isolated equilibrium points $f(\bar{x},0) = 0, \bar{x} \neq 0,$ would allow the boundary condition $\pi(0)$ to take on other values, however we can restrict our analysis to a neighbourhood of the equilibrium point at $\bar{x} = 0$ that contains no other equilibrium points, hence, if a differentiable invariant manifold exists for the interconnected system in such a neighbourhood of the equilibrium point $(\bar{\omega},\bar{x}) = (0,0)$, then it must satisfy the PDE with boundary condition
$$\frac{\partial \pi}{\partial \omega} s(\omega) = f\big(\pi(\omega),\ell(\omega)\big), \quad \pi(0) = 0.$$
The notion of invariance is a powerful tool for analysis and design of nonlinear dynamic systems, so there is good reason to consider PDEs of this form. See applications in immersion and invariance controller design, nonlinear model reduction by moment matching, nonlinear model reduction in the Loewner framework, the KKL observer, and the centre manifold theory.

While there are many approaches to determining the solution to a PDE numerically, sometimes it is useful to have a symbolic solution to the PDE (for example, the solution must be embedded into a model in model reduction, and having a lookup table instead could cause the model to act piecewise continuous rather than smooth if care is not taken). One approach is to numerically solve the PDE and then try to fit a linear combination of basis functions to the numerical data. In this package, the approach is simply to use symbolic computation to determine the coefficients of a Taylor series representation of the PDE solution.

# Approach

Assuming that the mappings $s(\cdot)$, $\ell(\cdot)$, $f(\cdot,\cdot)$ are analytic, and assuming that the solution to the PDE $\pi(\cdot)$ is also analytic, then they can all be exactly represented by their multivariable Taylor series representations, i.e. in multi-index notation with $m = (m_1, m_2, \ldots, m_{\nu-1}, m_{\nu})$, $m_i \in \mathbb{N} \cup \{0\} \ \forall i \in \{1,\ldots,\nu\}$, such that
$$|m| = \sum_{i = 1}^{\nu} |m_i|,$$
then
$$\pi(\omega) = \Pi \omega + \sum_{i = 1}^{\infty} \sum_{|m| = i} \Pi_{m} \omega^m, \quad \Pi \in \mathbb{R}^{n \times \nu}, \quad \Pi_m \in \mathbb{R}^{n},$$
where
$$\omega^m := \prod_{i = 1}^{\nu} \omega_i^{m_i} = \omega_1^{m_1} \omega_2^{m_2} \ldots \omega_{\nu-1}^{m_{\nu-1}} \omega_{\nu}^{m_{\nu}},$$
and
$$\sum_{|m| = i},$$
is the summation over all multi-set indices $m$ such that the indices add up to the total $i$.

Now we define a new operator $e : C^{\omega}(\mathbb{R}^{\nu},\mathbb{R}^{n}) \times \mathbb{R}^{\nu} \rightarrow \mathbb{R}^{n}$, taking as inputs an analytic mapping of the same dimensions as $\pi(\cdot)$ and a vector in $\mathbb{R}^{\nu}$, via
$$e(\hat{\pi},\omega) := \frac{\partial \hat{\pi}}{\partial \omega} s(\omega) - f\big(\hat{\pi}(\omega),\ell(\omega)\big).$$
There are two important properties to note about this operator. The first is that if the mappings $s(\cdot)$, $\ell(\cdot)$, and $f(\cdot,\cdot)$ are analytic, then for any analytic $\hat{\pi}(\cdot)$ the mapping $e(\hat{\pi}(\omega),\omega)$ is also analytic in the variable $\omega$ and can be represented exactly by its Taylor series. The second important property to note is that, with $\pi(\cdot)$ the exact solution of the PDE, the mapping $e(\pi(\omega),\omega) = 0$ for all $\omega$, and if the solution to the PDE is unique, then $\pi(\cdot)$ is the only mapping that zeros the operator $e(\cdot,\cdot)$ for all $\omega$. These two points form the crux of the approach: for $\pi(\cdot)$ and $\hat{\pi}(\cdot) \neq \pi(\cdot)$ each composed with the operator $e(\cdot,\cdot)$ we have that
$$e(\pi(\omega),\omega) = E \omega + \sum_{i = 1}^{\infty} \sum_{|m| = i} E_{m} \omega^m = 0 \ \forall \omega \quad \Rightarrow \quad (E = 0) \land (E_m = 0) \ \forall \ m,$$
and
$$e(\hat{\pi}(\omega),\omega) = \hat{E} \omega + \sum_{i = 1}^{\infty} \sum_{|m| = i} \hat{E}_{m} \omega^m.$$
That is, the solution $\pi(\cdot)$ is the only mapping such that its composition with the operator $e(\cdot,\cdot)$ has a Taylor series representation with all coefficients equal to zero, and any other mapping composed with $e(\cdot,\cdot)$ has a Taylor series representation with some coefficients that are not zero.

The approach to building the solution in the symbolic toolbox is as follows:
- build a symbolic series representation of $\hat{\pi}(\cdot)$ up to the desired total order, $d$
- compose symbolic Taylor series representations of the mappings $\hat{\pi}(\cdot)$, $s(\cdot)$, $\ell(\cdot)$, and $f(\cdot,\cdot)$ to get a symbolic Taylor series representation of $e(\hat{\pi}(\cdot),\cdot)$
- take derivatives of $e(\hat{\pi}(\cdot),\cdot)$ to isolate a symbolic equation for each Taylor series coefficient of $e(\hat{\pi}(\cdot),\cdot)$ up to the desired total order to form a system of equations, denoted $C(\hat{\pi},s,\ell,f)$
- the exact solution has Taylor series coefficients such that each obtained equation evaluates to zero, hence to obtain an approximate solution up to the desired total order $d$ solve $C(\hat{\pi},s,\ell,f) = 0$ where the solution variables are the series coefficients of $\hat{\pi}(\cdot)$
- the resulting mappings have the property that $$\pi(\omega) - \hat{\pi}(\omega) = \sum_{i = d+1}^{\infty} \sum_{|m| = i} \Pi_m \omega^m,$$ so the solution approximation error is $\theta(|\omega|^{d+1})$ and can be improved with each increment in the desired total order of the approximation

Proof that, under certain nonresonance conditions, the system of equations $C(\hat{\pi},s,\ell,f) = 0$ is uniquely solvable in the coefficients of $\hat{\pi}(\cdot)$, and proof of my claim regarding the solution approximation error, can be found in my dissertation (put link) or the paper (put link). Furthermore, the proofs show that solutions for coefficients associated to monomials of total order $d$ only depend upon the solutions for other coefficients associated to monomials of total order $\bar{d} \leq d$, and for any order $d$ an explicit ordering in which to solve the coefficients can be given, hence we can build up the approximation inductively. That is, given all approximation coefficients up to and including total order $d-1$ we can uniquely determine the approximation coefficients of total order $d$. So we can begin first by solving then linear terms, then, given the linear terms, we solve the coefficients of order two terms, then, given the linear and order two terms, we solve the coefficients of order three terms, and so on...

# Technical Details

- generating a reperesentation of all combinations of multi-set indices for a particular total order
- generating a vector containing symbolic representations of all monomials of a particular total order
- isolating each coefficient of a total order by taking high-order multivariable partial derivatives and substituting zeros
- the procedure of loading a known solution approximation of total order $d$, using it to determine the approximation coefficients of total order $d+1$, combining them together, and saving the result as the new known solution approximation of total order $d+1$
- the structure of the solution properties (.csv), solution coefficients (.csv), and solution symfuns (.mat) files
- checking for consistency of the mappings given by the user; checking that the mappings form a well-posed and solvable PDE

# Project Organization

# Usage










# Old Notes

#################

Currently this project is in a messy state as I originally wrote it with the simple intent of using it to come up with PDE solutions that I could use as examples in my dissertation on interpolation and model reduction. I think it could be a useful tool so I will update this and turn it into a more general and useable package when I have some time.

#################

A MATLAB project I wrote for determining approximate solutions to PDEs having a Taylor series ansatz. I wrote this because it was desirable to have a symbolic representation for the approximation of the PDE solution when building interpolants of nonlinear systems, rather than just a numerical approximation.

It works by using the symbolic toolbox to determine Taylor series representations of the differential equation, differentiating the symbolic Taylor series representation of the PDE in order to isolate the coefficient associated to each monomial in the representation, and then solving for the coefficients of the Taylor series representation of the PDE solution in particular.

It can require large amounts of memory for handling big systems of PDEs with many independent variables when determining the coefficients for higher order monomial terms (a particular issue for my work in nonlinear model reduction). To avoid having wasted computational effort if a memory issue arises, the scripts in their current form save the solved coefficients to a file every time a family of monomials of particular degree has had their coefficients determined. That is, for example, if terms of the form x^d have been determined, but MATLAB runs out of memory in the middle of determining coefficients for monomials of the form x^{d+1}, then the coefficient up to and including x^d are not lost.

The coefficients are saved in a file, and can be retrieved in either the form of a coefficient matrix, or in the form of a symbolic function that can be used to evaluate the approximate PDE solution in MATLAB.
