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
beta=2.0*sqrt(g/l); %koeficient viskózneho trenia

%poèiatoèné podmienky
omega_0=0; %uhlová rıchlos

%%
close all;

T_step=Tsim/5; %èas v ktorom dôjde k skoku vstupného signálu z u1 na u2

y_pb_1=deg2rad(25); %hodnota vıchlylky v pracovnom bode 1
y_pb_2=deg2rad(75); %hodnota vıchlylky v pracovnom bode 2

phi_0=y_pb_1*1.0; %poèiatoèná podmienka vıchlylky (môe by rovnaká ako y_pb_1)

u_1=m*g*l*sin(y_pb_1); %hodnota vstupu systému v pracovnom bode 1 (vypoèítaná z prevodovej charakteristiky)
u_2=m*g*l*sin(y_pb_2); %hodnota vstupu systému v pracovnom bode 2 (vypoèítaná z prevodovej charakteristiky)

simout=sim('cv_7_sim'); %spustíme simuláciu
phi_nonlinear=simout.phi_nonlinear; %extrakcia premennej vıchylky

window_size=10; %dåka priemerovacieho okna

y_1=mean(phi_nonlinear(T_step/Ts-window_size:T_step/Ts)); %zmeraná hodnota ustálenej vıchlylky v pracovnom bode 1 (mala by by blíka y_pb_1)
y_2=mean(phi_nonlinear(end-window_size:end));   %zmeraná hodnota ustálenej vıchlylky v pracovnom bode 1 (mala by by blíka y_pb_1)

delta_u=u_2-u_1;    %ve¾kos zmeny vstupného signálu medzi pracovnımi bodmi
delta_y=y_2-y_1;    %ve¾kos zmeny vıstupného signálu (vıchylky) medzi pracovnımi bodmi

y=phi_nonlinear(T_step/Ts:end)-y_1;  %relatívny posun vıchylky voèi prvému pracovnému bodu
time=simout.tout(T_step/Ts:end);     %orezanie èasového signálu
time=time-time(1);                   %posunutie èasového signálu voèi okamihu skoku

K=delta_y/delta_u;                   %vıpoèet zosilnenia systému
%K_anal=1/m/g/l/sqrt(1-(u_1/m/g/l)^2);
y_at_Tc=delta_y*(1-exp(-1)); %  oèakávaná hodnota relatívnej vıchylky v èase zhodnom s èasovou konštantou Tc (63 percent hodnoty ustálenej relatívnej vıchylky )

[ans,Tc_idx]=min((y-y_at_Tc).^2); %nájdenie indexu vektora vıchylky y s hodnotou najblišou k y_at_Tc
Tc=time(Tc_idx); %èasová konštanta je hodnota èasu na tomto indexe

F=tf(K,[Tc,1]);  %objekt prenosovej funkcie prvého rádu F(s)=1/(Tc*s+1)
y_sim=lsim(F,delta_u*ones(size(time)),time); %numerické riešenie odozvy systému F(s) na delta_u skok

figure(1);
hold on;
plot(time,y,'-k','LineWidth',2);
plot(time,y_sim,'.k','LineWidth',2)
plot(time,delta_u*K*ones(size(time)),'--r','LineWidth',2);
plot(Tc,y(Tc_idx),'+r','LineWidth',2);
text(Tc,y(Tc_idx),"'\leftarrow T_c="+Tc+"[s]");
text(0,delta_u*K,"'\leftarrow K="+K+"[rad/(kg m^2 s^{-2})]");

title('Prechodová charakteristika kyvadla');
xlabel('èas[s]');
ylabel('y [rad]');
legend('y','y_{sim}','\Delta u K','T_c'),
grid on

set(gcf,'position',[0,0,1000,700])

