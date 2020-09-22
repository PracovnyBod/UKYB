close all;
clear;
cv_1_sim
Ts=0.1; %Perioda vypoctu simulacie (pre toto cvicenie nepodstatne)
Tsim=5; %Dlzka trvania simulacie (pre toto cvicenie nepodstatne)

R_vec=[1e6,1e6,0.1e6]; %vektor parametra R pre rozne experimenty [MOhm]
C_vec=[2e-6,0.5e-6,1e-6]; %vektor parametra C pre rozne experimenty [nF]
u_0_vec=[5,5,3]; %vektor parametra u_0 pre rozne experimenty [V]
%%
%otvorime si nove okna na vykreslovanie grafov
figure(1); %graf pre simulaciu
title('Numericka simulacia') 
xlabel('cas[s]')  %oznacime si osi grafov
ylabel('napatie [V]')
legend on
grid on
hold on

figure(2); %graf analytickeho riesenia
title('Analyticke riesenie')
xlabel('cas[s]') %oznacime si osi grafov
ylabel('napatie [V]')
legend on
grid on
hold on
%%
i=1; %aktualne cislo experimentu (1-3) - ovplyvnuje parametre R,C,u_0

u_0=u_0_vec(i); %pociatocne napatie (pociatocna podmienka integratora)
R=R_vec(i); %odpor rezistora (parameter - konstanta)
C=C_vec(i); %kapacita kondenzatora (parameter - konstanta)
Tc=R*C; % casova konstanta systemu (parameter - konstanta)
simout=sim('cv_1_sim'); %spustime simulaciu
u_sim=simout.u; %extrahujeme vysledok simulacie- vektor priebehu napatia
t_sim=simout.tout; %extrahujeme casovy vektor simulacie 

figure(1); %vyberieme okno 1
plot(t_sim,u_sim,'LineWidth',2); %vykreslime casovy priebeh napatia, (os x - cas, os y - napatie)

t_anal=t_sim; %analyticke riesenie chceme pre rovnaky casovy vektor ako numericke riesenie

figure(2);
u_anal=u_0*exp(-(1/(R*C))*t_anal);  %pre vypocet analytickeho riesenie priebehu napatia vyuzijeme rovnicu 14
plot(t_anal,u_anal,'LineWidth',2); %vykreslime casovy priebeh napatia, (os x - cas, os y - napatie)



