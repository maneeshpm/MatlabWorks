clc;

% CHE221A COMPUTATIONAL ASSIGNMENT-1
% MANEESH P M
% 180404
% CODE FOR GENERATION OF THE ISOTHERMS ABOVE Tc
% Declaring constants for Nitrogen
a=2.54;
A0=106.73;
b=0.002328;
B0=0.04074;
c=73790;
C0=816400;
al=0.0001272;
gam=0.0053;
Ru=8.31434;

for T=127.2:1:131.2     %to iterate over temperature
    hold on

    syms v;                 %plotting bwr for the temp
    fplot(Ru*T/v+(B0*Ru*T-A0-C0/(T^2))/(v^2)+(b*Ru*T-a)/(v^3)+a*al/(v^6)+c*(1+gam/(v^2))*exp(-gam/(v^2))/((v^3)*(T^2)), [0.001 1]);
    xlim([0 0.4])
    ylim([1500 5000])

end


