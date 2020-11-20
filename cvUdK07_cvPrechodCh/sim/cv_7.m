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

T_step=Tsim/2; %èas v ktorom dôjde k skoku vstupného signálu z u_pb na u_pb_h

y_pb_prevod=deg2rad(25); %hodnota vıchlylky v pracovnom bode
y_pb_h_prevod=deg2rad(30); %hodnota vıchlylky v okolí pracovného bodu

phi_0=y_pb_prevod*0.0; %poèiatoèná podmienka vıchlylky (môe by rovnaká ako y_pb, ale ideálne iná)

u_pb=m*g*l*sin(y_pb_prevod); %hodnota vstupu systému v pracovnom bode (vypoèítaná z prevodovej charakteristiky)
u_pb_h=m*g*l*sin(y_pb_h_prevod); %hodnota vstupu systému v okolí pracovného bodu (vypoèítaná z prevodovej charakteristiky)
%POZOR tu je vyuíté analytické riešenie prevodovej charakteristiky%
%Pre urèenie párov u_pb a u_pb_h respektíve y_pb_prevod a y_pb_h_prevod je potrebné poui prevodovú charaktristiku zmeranú v zadaní 1.%

simout=sim('cv_7_sim'); %spustíme simuláciu
phi_nonlinear=simout.phi_nonlinear; %extrakcia premennej vıchylky

window_size=10; %dåka priemerovacieho okna

y_pb_meas=mean(phi_nonlinear(T_step/Ts-window_size:T_step/Ts)); %zmeraná hodnota ustálenej vıchlylky v pracovnom bode (mala by by blízka y_pb)
y_pb_h_meas=mean(phi_nonlinear(end-window_size:end));   %zmeraná hodnota ustálenej vıchlylky v okolí pracovného bodu (mala by by blíka y_pb_h)

delta_u=u_pb_h-u_pb;    %ve¾kos zmeny vstupného skokového signálu medzi pracovnım bodom a jeho okolím
delta_y=y_pb_h_meas-y_pb_meas;    %ve¾kos zmeny vıstupného signálu (vıchylky) medzi pracovnım bodom a jeho okolím)
delta_y_prevod=y_pb_h_prevod-y_pb_prevod; 

y=phi_nonlinear(T_step/Ts:end)-y_pb_meas;  %relatívny posun vıchylky voèi pracovnému bodu
time=simout.tout(T_step/Ts:end);     %orezanie èasového signálu
time=time-time(1);                   %posunutie èasového signálu voèi okamihu skoku

K_prechod=delta_y/delta_u;                   %vıpoèet zosilnenia systému z prechodovej charakteristiky
K_prevod=delta_y_prevod/delta_u;     %vıpoèet zosilnenia systému z prevodovej charakteristiky

y_at_Tc=delta_y*0.6321; %oèakávaná hodnota relatívnej vıchylky v èase zhodnom s èasovou konštantou Tc (63 percent hodnoty ustálenej relatívnej vıchylky )
%y_at_Tc=delta_y*(1-exp(-1)); %Presnejšia monos vıpoètu, nako¾ko platí
%y(t)=delta_y*(1-e^(-t/Tc))~0.6321
[ans,Tc_idx]=min((y-y_at_Tc).^2); %nájdenie indexu vektora vıchylky y s hodnotou najblišou k y_at_Tc
Tc=time(Tc_idx); %èasová konštanta je hodnota èasu na tomto indexe

F=tf(K_prechod,[Tc,1]);  %objekt prenosovej funkcie prvého rádu F(s)=1/(Tc*s+1)
y_sim=lsim(F,delta_u*ones(size(time)),time); %numerické riešenie odozvy systému F(s) na delta_u skok

figure(1);
hold on;
plot(time,y,'-k','LineWidth',2);
plot(time,y_sim,'.k','LineWidth',2)
plot(time,delta_u*K_prechod*ones(size(time)),'--r','LineWidth',2);
plot(time,delta_u*K_prevod*ones(size(time)),'--g','LineWidth',2);
plot(Tc,y(Tc_idx),'+r','LineWidth',2);
text(Tc,y(Tc_idx),"'\leftarrow T="+Tc+"[s]");
text(0,0.09,"'K="+K_prechod+"[rad/(kg m^2 s^{-2})]");

title('Prechodová charakteristika kyvadla');
xlabel('èas[s]');
ylabel('y [rad]');
legend('y_{zmerané}','y_{lineárny model}','\Delta u * K_{prechod}','\Delta u * K_{prevod}','T'),
grid on

set(gcf,'position',[0,0,1000,700])

