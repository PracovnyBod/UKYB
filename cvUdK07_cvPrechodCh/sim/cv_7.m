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

T_step=Tsim/2; %�as v ktorom d�jde k skoku vstupn�ho sign�lu z u_pb na u_pb_h

y_pb_prevod=deg2rad(25); %hodnota v�chlylky v pracovnom bode
y_pb_h_prevod=deg2rad(30); %hodnota v�chlylky v okol� pracovn�ho bodu

phi_0=y_pb_prevod*0.0; %po�iato�n� podmienka v�chlylky (m��e by� rovnak� ako y_pb, ale ide�lne in�)

u_pb=m*g*l*sin(y_pb_prevod); %hodnota vstupu syst�mu v pracovnom bode (vypo��tan� z prevodovej charakteristiky)
u_pb_h=m*g*l*sin(y_pb_h_prevod); %hodnota vstupu syst�mu v okol� pracovn�ho bodu (vypo��tan� z prevodovej charakteristiky)
%POZOR tu je vyu��t� analytick� rie�enie prevodovej charakteristiky%
%Pre ur�enie p�rov u_pb a u_pb_h respekt�ve y_pb_prevod a y_pb_h_prevod je potrebn� pou�i� prevodov� charaktristiku zmeran� v zadan� 1.%

simout=sim('cv_7_sim'); %spust�me simul�ciu
phi_nonlinear=simout.phi_nonlinear; %extrakcia premennej v�chylky

window_size=10; %d�ka priemerovacieho okna

y_pb_meas=mean(phi_nonlinear(T_step/Ts-window_size:T_step/Ts)); %zmeran� hodnota ust�lenej v�chlylky v pracovnom bode (mala by by� bl�zka y_pb)
y_pb_h_meas=mean(phi_nonlinear(end-window_size:end));   %zmeran� hodnota ust�lenej v�chlylky v okol� pracovn�ho bodu (mala by by� bl�ka y_pb_h)

delta_u=u_pb_h-u_pb;    %ve�kos� zmeny vstupn�ho skokov�ho sign�lu medzi pracovn�m bodom a jeho okol�m
delta_y=y_pb_h_meas-y_pb_meas;    %ve�kos� zmeny v�stupn�ho sign�lu (v�chylky) medzi pracovn�m bodom a jeho okol�m)
delta_y_prevod=y_pb_h_prevod-y_pb_prevod; 

y=phi_nonlinear(T_step/Ts:end)-y_pb_meas;  %relat�vny posun v�chylky vo�i pracovn�mu bodu
time=simout.tout(T_step/Ts:end);     %orezanie �asov�ho sign�lu
time=time-time(1);                   %posunutie �asov�ho sign�lu vo�i okamihu skoku

K_prechod=delta_y/delta_u;                   %v�po�et zosilnenia syst�mu z prechodovej charakteristiky
K_prevod=delta_y_prevod/delta_u;     %v�po�et zosilnenia syst�mu z prevodovej charakteristiky

y_at_Tc=delta_y*0.6321; %o�ak�van� hodnota relat�vnej v�chylky v �ase zhodnom s �asovou kon�tantou Tc (63 percent hodnoty ust�lenej relat�vnej v�chylky )
%y_at_Tc=delta_y*(1-exp(-1)); %Presnej�ia mo�nos� v�po�tu, nako�ko plat�
%y(t)=delta_y*(1-e^(-t/Tc))~0.6321
[ans,Tc_idx]=min((y-y_at_Tc).^2); %n�jdenie indexu vektora v�chylky y s hodnotou najbli��ou k y_at_Tc
Tc=time(Tc_idx); %�asov� kon�tanta je hodnota �asu na tomto indexe

F=tf(K_prechod,[Tc,1]);  %objekt prenosovej funkcie prv�ho r�du F(s)=1/(Tc*s+1)
y_sim=lsim(F,delta_u*ones(size(time)),time); %numerick� rie�enie odozvy syst�mu F(s) na delta_u skok

figure(1);
hold on;
plot(time,y,'-k','LineWidth',2);
plot(time,y_sim,'.k','LineWidth',2)
plot(time,delta_u*K_prechod*ones(size(time)),'--r','LineWidth',2);
plot(time,delta_u*K_prevod*ones(size(time)),'--g','LineWidth',2);
plot(Tc,y(Tc_idx),'+r','LineWidth',2);
text(Tc,y(Tc_idx),"'\leftarrow T="+Tc+"[s]");
text(0,0.09,"'K="+K_prechod+"[rad/(kg m^2 s^{-2})]");

title('Prechodov� charakteristika kyvadla');
xlabel('�as[s]');
ylabel('y [rad]');
legend('y_{zmeran�}','y_{line�rny model}','\Delta u * K_{prechod}','\Delta u * K_{prevod}','T'),
grid on

set(gcf,'position',[0,0,1000,700])

