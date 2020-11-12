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

T_step=Tsim/5;

y_pb_1=deg2rad(25);
y_pb_2=deg2rad(75);

phi_0=y_pb_1*1.0;

u_1=m*g*l*sin(y_pb_1);
u_2=m*g*l*sin(y_pb_2);


simout=sim('cv_7_sim'); %spustíme simuláciu

phi_nonlinear=simout.phi_nonlinear;

window_size=10;

y_1=mean(phi_nonlinear(T_step/Ts-window_size:T_step/Ts));
y_2=mean(phi_nonlinear(end-window_size:end));

delta_u=u_2-u_1;
delta_y=y_2-y_1;

y=phi_nonlinear(T_step/Ts:end)-y_1;
time=simout.tout(T_step/Ts:end);
time=time-time(1);

K=delta_y/delta_u;
%K_anal=1/m/g/l/sqrt(1-(u_1/m/g/l)^2);
y_at_Tc=delta_u*K*(1-exp(-1)); % 63 percent

[ans,Tc_idx]=min((y-y_at_Tc).^2);
Tc=time(Tc_idx);

F=tf(K,[Tc,1]);
y_sim=lsim(F,delta_u*ones(size(time)),time);

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

