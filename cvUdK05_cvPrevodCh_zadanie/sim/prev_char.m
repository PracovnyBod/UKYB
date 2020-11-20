clear;
close all;
prev_char_sim
Ts=0.1; %Peri�da v�po�tu simul�cie (nepodstatn�)
Tsim=110; %D�ka trvania simul�cie (nepodstatn�)
%%
%parametre kyvalda
m=1; %hmotnos�
l=1; %d�ka z�vesu
g=9.81; %gravita�n� zr�chlenie 
beta=0.5*sqrt(g/l); %koeficient visk�zneho trenia

%po�iato�n� podmienky
phi_0=0; %uhlov� poloha
omega_0=0; %uhlov� r�chlos�

%%
T_step=10;
u_prevod=[0,1,2,3,4,5,6,7,8,9,9.5];

simout=sim('prev_char_sim'); %spust�me simul�ciu

phi=simout.phi;
time=simout.tout;
idx=T_step/Ts*(1:length(u_prevod));
phi_prevod=zeros(size(idx));
window_size=20;

figure(1)
yyaxis right
stairs((0:length(u_prevod)-1)*T_step,u_prevod,'--','LineWidth',1);
ylabel('u [kg m^2 s^{-2}]')

yyaxis left
plot(time,phi,'-','LineWidth',1);
grid on;
xlabel('t [s]');
ylabel('\phi [rad]');
hold on
for i=1:length(idx)
 phi_prevod(i)=mean(phi(idx(i)-window_size+1:idx(i)));
 plot(time(idx(i)-window_size+1:idx(i)),ones(window_size,1)*phi_prevod(i),'-r','LineWidth',2)
end
title('Odozva syst�mu na vstupn� sign�l');
legend('\phi','\phi_{mean}');

figure(2)
hold on
plot(u_prevod,phi_prevod,'+r','LineWidth',1.5);
plot(u_prevod,asin(u_prevod/(m*g*l)),'og','LineWidth',1.5);
legend('zmeran�','analyticky')
grid on;
xlabel('u [kg m^2 s^{-2}]')
ylabel('\phi [rad]')
title('Prevodov� charakteristika');

