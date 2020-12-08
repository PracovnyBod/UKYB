
%%
close all
Tsim=20;
Ts=0.1;

figure(1);
F=zpk([],[-2,-1,-0.5],100);


epsilon=0.05;

g_F=dcgain(F);
K=(1-epsilon)/epsilon/g_F;

bode(F*K);
grid on;
hold on;

phi_z=pi/4;
phi_0= -0.2618;

phi_m=phi_z-phi_0;
a=(1+sin(phi_m))/(1-sin(phi_m));

d=-10*log10(a);
omega_m=3.8;
T=1/(omega_m*sqrt(a));

C=tf([a*T,1],[T,1]);
bode(C);

F_ORO=F*C*K;
bode(F_ORO);

legend('Systém','Korekèný èlen','Otvorený regulaèný obvod')

figure(2);
F_uro=feedback(F_ORO,1);
step(F_uro);
grid on;
