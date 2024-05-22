function [eqn_for_coeff] = get_equation_for_coefficient(fn_e,coeff_multiset)
%GET_EQUATION_FOR_COEFFICIENT Given a function fn_e, get the high-order
%mixed partial derivative of fn_e associated to the indices given by the
%vector of nonnegative integers coeff_multiset = [m_{1},...,m_{\nu}].
%   fn_e: symbolic function
%   coeff_multiset: vector of nonnegative integers
%
%   return: eqn_for_coeff, obtained by taking the partial derivative of
%   fn_e with respect to each input w(i) coeff_multiset(i) times and then
%   substituting zero into the partial derivative to get rid of
%   higher order terms

  % given the row vector coeff_multiset = [m_1,...,m_v], we can extract 
  % from fn_e the coefficient associated to the monomial term
  % w_{1}^{m_1} * w_{2}^{m_2} * ... * w_{\nu}^{m_{\nu}} by taking partial
  % derivatives of fn_e associated to coeff_multiset and substituting zero
  % into the resulting high-order derivative

  w = argnames(fn_e);
  partial_e = fn_e;
  for i1 = 1 : 1 : length(w)
    partial_e = diff(partial_e, w(i1), coeff_multiset(i1));
  end
  eqn_for_coeff = subs(partial_e, w, zeros(size(w,1),size(w,2)));
end

