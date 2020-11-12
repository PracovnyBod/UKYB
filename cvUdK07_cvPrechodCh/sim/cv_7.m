clear;
close all;
cv_7_sim
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
simout=sim('cv_7_sim'); %spust�me simul�ciu

phi_nonlinear=simout.phi_nonlinear;

T_sim=simout.tout;






