function dp = sh2dewpoint(sh, p, t)
%SH2DEWPOINT Calculate dewpoint temperature based on specific humidity
%
% dp = sh2dewpoint(sh, p, t)
%
% Calculations are as follows:
%
%   pH20 = SH * mr                      <-- relationship between mole
%                                           fraction and partial pressure 
%   es = A * exp(beta * T)              <-- simplified Clausius-Clapeyron
%   RH = pH20/es * 100                  <-- definition of relative humidity  
%   gamma = a.*T./(b + T) + log(RH);
%   Td = (b .* gamma)./(a - gamma);     <-- August-Roche-Magnus
%                                           approximation 
%
% where pH20 = partial pressure of water vapor
%       SH   = specific humidity
%       mr   = mole ratio of water to dry air (18.015/28.97)
%       es   = staturation vapor pressure (Pa)
%       A    = 611 Pa
%       beta = 0.067 deg C
%       RH   = relative humidity
%       T    = temperature (deg C)
%       a    = 17.271
%       b    = 237.7 deg C
%       Td   = dewpoint temperature (deg C)
%       
% Valid for 0 degC < T < 60 degC, 1% < RH < 100%, 0 degC < Td < 50 degC 
%
% Input variables:
%
%   sh: specific humidity (g H20/g air)
%
%   p:  pressure (Pa)
%
%   t:  temperature (deg C)
%
% Output variables:
%
%   dp: dewpoint temperature (deg C)

molfrac = sh * (28.97/18.015);
pp = molfrac .* p;              % Pa
satp = 611 .* exp(0.067 .* t);  % Pa
rh = pp./satp;

a = 17.271;
b = 237.7;  % deg C

gamma = a.*t./(b + t) + log(rh);

dp = (b .* gamma)./(a - gamma);




