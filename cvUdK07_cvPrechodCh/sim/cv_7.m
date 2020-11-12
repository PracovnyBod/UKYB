clear;
close all;
cv_7_sim
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
omega_0=0; %uhlová rıchlos

%%
simout=sim('cv_7_sim'); %spustíme simuláciu

phi_nonlinear=simout.phi_nonlinear;

T_sim=simout.tout;






