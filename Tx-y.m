clc;

% CHE221A COMPUTATIONAL ASSIGNMENT-2
% MANEESH P M
% 180404

% 1 REFERS TO BUTYL ACETATE
% 2 REFERS TO CYCLOHEXANOL

%DECLARING CONSTANTS
A1=7.02845;
B1=1368.500;
C1=204.000;

A2=6.80369;
B2=1199.100;
C2=145.000;

A12=894.2132;
A21=-477.0153;
ALPHA12=0.2985;
GAMMA1inf=1.23;
GAMMA2inf=1.50;

R=1.98721 % cal/mol K
P=730 % mm Hg

t1=(B1/(A1-log(P)))-C1;
t2=(B2/(A2-log(P)))-C2;

DELTAT=0.5;

for i=1:21
    x1(i)=(i-1)/20;
    x2(i)=1-x1(i);
    
    T=t1*x1(i)+t2*x2(i); % GUESSED VALUE
    DELTA=1;
    while(DELTA>0.0001)
        P1sat=10^(A1-B1/(T+C1));
        P2sat=10^(A2-B2/(T+C2));
        
        TAU12=A12/(R*T);
        TAU21=A21/(R*T);
        G12=exp(-ALPHA12*TAU12);
        G12=exp(-ALPHA12*TAU21);
        
        GAMMA1=exp(TAU21*((G21/(x1(i)+x2(i)G21))^2) + (TAU12*G12/((x2(i)+x1(i)*G12)^2)));
        
        GAMMA2=exp(TAU12*((G12/(x2(i)+x1(i)G12))^2) + (TAU21*G21/((x1(i)+x2(i)*G21)^2)));
        
        Y1(i)=(P1sat*x1(i)*GAMMA1)/P;
        Y2(i)=(P2sat*x2(i)*GAMMA2)/P;
        
        DELTA=(abs(Y1(i)+Y2(i)-1));
        if(DELTA>0.0001)
            if((Y1(i)+Y2(i))>1)
                T=T-DELTAT;
            elseif((Y1(i)+Y2(i))<1)
                T=T+DELTAT;
            end
        end
    end
    T(i)=T;
end


    