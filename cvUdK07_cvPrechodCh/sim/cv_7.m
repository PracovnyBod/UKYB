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
beta=2.0*sqrt(g/l); %koeficient visk�zneho trenia

%po�iato�n� podmienky
omega_0=0; %uhlov� r�chlos�

%%
close all;

T_step=Tsim/5; %�as v ktorom d�jde k skoku vstupn�ho sign�lu z u1 na u2

y_pb_1=deg2rad(25); %hodnota v�chlylky v pracovnom bode 1
y_pb_2=deg2rad(75); %hodnota v�chlylky v pracovnom bode 2

phi_0=y_pb_1*1.0; %po�iato�n� podmienka v�chlylky (m��e by� rovnak� ako y_pb_1)

u_1=m*g*l*sin(y_pb_1); %hodnota vstupu syst�mu v pracovnom bode 1 (vypo��tan� z prevodovej charakteristiky)
u_2=m*g*l*sin(y_pb_2); %hodnota vstupu syst�mu v pracovnom bode 2 (vypo��tan� z prevodovej charakteristiky)

simout=sim('cv_7_sim'); %spust�me simul�ciu
phi_nonlinear=simout.phi_nonlinear; %extrakcia premennej v�chylky

window_size=10; %d�ka priemerovacieho okna

y_1=mean(phi_nonlinear(T_step/Ts-window_size:T_step/Ts)); %zmeran� hodnota ust�lenej v�chlylky v pracovnom bode 1 (mala by by� bl�ka y_pb_1)
y_2=mean(phi_nonlinear(end-window_size:end));   %zmeran� hodnota ust�lenej v�chlylky v pracovnom bode 1 (mala by by� bl�ka y_pb_1)

delta_u=u_2-u_1;    %ve�kos� zmeny vstupn�ho sign�lu medzi pracovn�mi bodmi
delta_y=y_2-y_1;    %ve�kos� zmeny v�stupn�ho sign�lu (v�chylky) medzi pracovn�mi bodmi

y=phi_nonlinear(T_step/Ts:end)-y_1;  %relat�vny posun v�chylky vo�i prv�mu pracovn�mu bodu
time=simout.tout(T_step/Ts:end);     %orezanie �asov�ho sign�lu
time=time-time(1);                   %posunutie �asov�ho sign�lu vo�i okamihu skoku

K=delta_y/delta_u;                   %v�po�et zosilnenia syst�mu
%K_anal=1/m/g/l/sqrt(1-(u_1/m/g/l)^2);
y_at_Tc=delta_y*(1-exp(-1)); %  o�ak�van� hodnota relat�vnej v�chylky v �ase zhodnom s �asovou kon�tantou Tc (63 percent hodnoty ust�lenej relat�vnej v�chylky )

[ans,Tc_idx]=min((y-y_at_Tc).^2); %n�jdenie indexu vektora v�chylky y s hodnotou najbli��ou k y_at_Tc
Tc=time(Tc_idx); %�asov� kon�tanta je hodnota �asu na tomto indexe

F=tf(K,[Tc,1]);  %objekt prenosovej funkcie prv�ho r�du F(s)=1/(Tc*s+1)
y_sim=lsim(F,delta_u*ones(size(time)),time); %numerick� rie�enie odozvy syst�mu F(s) na delta_u skok

figure(1);
hold on;
plot(time,y,'-k','LineWidth',2);
plot(time,y_sim,'.k','LineWidth',2)
plot(time,delta_u*K*ones(size(time)),'--r','LineWidth',2);
plot(Tc,y(Tc_idx),'+r','LineWidth',2);
text(Tc,y(Tc_idx),"'\leftarrow T_c="+Tc+"[s]");
text(0,delta_u*K,"'\leftarrow K="+K+"[rad/(kg m^2 s^{-2})]");

title('Prechodov� charakteristika kyvadla');
xlabel('�as[s]');
ylabel('y [rad]');
legend('y','y_{sim}','\Delta u K','T_c'),
grid on

set(gcf,'position',[0,0,1000,700])

