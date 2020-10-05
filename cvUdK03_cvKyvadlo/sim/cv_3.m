clear;
close all;
cv_3_sim
Ts=0.1; %Perióda vıpoètu simulácie (nepodstatné)
Tsim=15; %Dåka trvania simulácie (nepodstatné)
%%
%parametre kyvalda
m=1; %hmotnos
l=1; %dåka závesu
g=9.81; %gravitaèné zrıchlenie 
beta=0.5*sqrt(g/l); %koeficient viskózneho trenia

%poèiatoèné podmienky
phi_0=0.25; %uhlová poloha
dphi_0=0; %uhlová rıchlos

%%
simout=sim('cv_3_sim'); %spustíme simuláciu

phi_nonlinear=simout.phi_nonlinear;
phi_linear=simout.phi_linear;
T_sim=simout.tout;

figure(1);
hold on;
plot(T_sim,phi_nonlinear,'-k','LineWidth',2);
plot(T_sim,phi_linear,'-.k','LineWidth',2);
title('Priebeh vıchylky kyvadla') 
xlabel('èas[s]')  %oznacime si osi grafov
ylabel('\phi [rad]')
grid on





