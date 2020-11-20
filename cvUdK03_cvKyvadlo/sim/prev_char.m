clear;
close all;
prev_char_sim
Ts=0.1; %Perióda vıpoètu simulácie (nepodstatné)
Tsim=110; %Dåka trvania simulácie (nepodstatné)
%%
%parametre kyvalda
m=1; %hmotnos
l=1; %dåka závesu
g=9.81; %gravitaèné zrıchlenie 
beta=0.5*sqrt(g/l); %koeficient viskózneho trenia

%poèiatoèné podmienky
phi_0=0; %uhlová poloha
omega_0=0; %uhlová rıchlos

%%
T_step=10;
u_prevod=[0,1,2,3,4,5,6,7,8,9,9.5];

simout=sim('prev_char_sim'); %spustíme simuláciu

phi=simout.phi;
time=simout.tout;
idx=T_step/Ts*(1:length(u_prevod));

phi_prevod=zeros(size(idx));
window_size=20;

figure(1)
plot(time,phi,'-k','LineWidth',1);
grid on;
xlabel('t [s]')
ylabel('\phi [rad]')
hold on
for i=1:length(idx)
 phi_prevod(i)=mean(phi(idx(i)-window_size+1:idx(i)));
 plot(time(idx(i)-window_size+1:idx(i)),ones(window_size,1)*phi_prevod(i),'-r','LineWidth',2)
end    
figure(2)
hold on
plot(u_prevod,phi_prevod,'+r','LineWidth',2);
plot(u_prevod,phi_prevod,'-k','LineWidth',2);

grid on;
xlabel('u [ ]')
ylabel('\phi [rad]')
title('Prevodová charakteristika');

