clc;

% CHE221A COMPUTATIONAL ASSIGNMENT-1
% MANEESH P M
% 180404
% CODE FOR GENERATION OF THE SATURATION REGION DOME


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

p=3370.9237; % Critical pressure from literature
fplot(p);

% Saturation Pressure for various pressures from literature
sp(1)=2512.86;
sp(2)=2641.03613;
sp(3)=2774.07585;
sp(4)=2912.18183;
sp(5)=3055.5567;
sp(6)=3204.40312;
sp(7)=3370.9237;

% X axis vector for plotting
p=[2512.86 2512.86 2641.03613 2641.03613 2774.07585 2774.07585 2912.18183 2912.18183 3055.5567 3055.5567 3204.40312 3204.40312 3358.9237 3358.9237];


for T=120.2:1:126.2     %to iterate over temperature
i=T-119.2;              %loop counter
hold on

syms v;                 %plotting bwr for the temp
fplot(Ru*T/v+(B0*Ru*T-A0-C0/(T^2))/(v^2)+(b*Ru*T-a)/(v^3)+a*al/(v^6)+c*(1+gam/(v^2))*exp(-gam/(v^2))/((v^3)*(T^2)), [0.001 1]);
xlim([0 0.4])
ylim([1500 5000])

v = linspace(0.05,0.25);               % Interval To Evaluate Over, by inspection

%converting the equation to a function and using a guessed value approach
f = @(v) (Ru .* T./v + (B0.*Ru.*T - A0 - C0./(T.^2))./(v.^2) + (b.*Ru.*T - a)./(v.^3) + a.*al./(v.^6) + c.*(1+gam./(v.^2)).*exp(-gam./(v.^2))./((v.^3).*(T.^2))-sp(i))  ;                  % Function
fx = f(v);                          % Function Evaluated Over ‘x’
cs = fx.*circshift(fx,-1,2);        % Product Negative At Zero-Crossings
xc = v(cs <= 0);                    % Values Of ‘x’ Near Zero Crossings
for k1 = 1:length(xc)
    fz(k1) = fzero(f, xc(k1));      % Use ‘xc’ As Initial Zero Estimate
end


sv(i*2-1)=fz(1); %saving the first and third root in the saturation region
sv(i*2)=fz(3);

end
sv(14) = [];
p(14) = [];

% plotting the saved values using a cubic spline
y=p;
x=sv;
plot(sv,p,'o');
xx = 0.05:.001:0.25;
yy = spline(x,y,xx);
p=plot(x,y,'o',xx,yy);
p(2).LineWidth=3;
hold on


