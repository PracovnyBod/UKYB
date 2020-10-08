clear;
close all;
cv_3_sim
Ts=0.1; %Peri�da v�po�tu simul�cie (nepodstatn�)
Tsim=15; %D�ka trvania simul�cie (nepodstatn�)
%%
%parametre kyvalda
m=1; %hmotnos�
l=1; %d�ka z�vesu
g=9.81; %gravita�n� zr�chlenie 
beta=0.5*sqrt(g/l); %koeficient visk�zneho trenia

%po�iato�n� podmienky
phi_0=0.25; %uhlov� poloha
omega_0=0; %uhlov� r�chlos�

%%
simout=sim('cv_3_sim'); %spust�me simul�ciu

phi_nonlinear=simout.phi_nonlinear;
phi_linear=simout.phi_linear;
T_sim=simout.tout;

figure(1);
hold on;
plot(T_sim,phi_nonlinear,'-k','LineWidth',2); %vykresl�me sign�l uhlovej polohy neline�rneho modelu
plot(T_sim,phi_linear,'-.k','LineWidth',2); %vykresl�me sign�l uhlovej polohy line�rneho modelu
title('Priebeh v�chylky kyvadla') 
xlabel('�as[s]')  %oznacime si osi grafov
ylabel('\phi [rad]')
legend('Neline�rny model kyvadla','Linearizovan� model kyvadla'),
grid on





