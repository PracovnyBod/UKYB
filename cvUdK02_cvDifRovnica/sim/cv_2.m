clear;
close all;
cv_2_sim
Ts=0.1; %Peri�da v�po�tu simul�cie (nepodstatn�)
Tsim=5; %D�ka trvania simul�cie (nepodstatn�)
%%
a_0=10; %zvol�me kon�tantn� koeficienty diferenci�lnej rovnice - komplexne zdru�en� korene
a_1=2; 
%%
a_0=2; %zvol�me kon�tantn� koeficienty diferenci�lnej rovnice - r�zne re�lne korene
a_1=3;
%%
a_0=9; %zvol�me kon�tantn� koeficienty diferenci�lnej rovnice - dvojn�sobn� re�lny kore�
a_1=6;
%%

y_0=4; %zvol�me po�iato�n� podmienky - v�stup
dy_0=3; %zvol�me po�iato�n� podmienky - deriv�cia v�stupu

%charakteristick� rovnica nech je v tvare lambda^2+a_1*lambda+a_0
D=sqrt(a_1^2-4*a_0); % diskriminant charakteristickej rovnice 
lambda=[(-a_1+D),(-a_1-D)]/(2); % korene charakteristickej rovnice

T_anal=0:Ts:Tsim;

if lambda(1)==lambda(2) % dvojn�sobn� re�lny kore�
c=[1,0;lambda(1),1]\[y_0;dy_0];     %v�po�et koeficientov c na z�klade po�iato�n�ch podmienok
y_anal=c'*[exp(lambda(1)*T_anal);T_anal.*exp(lambda(2)*T_anal)]; %v�po�et analytick�ho rie�enia y(t)
elseif imag(lambda(1))==0  % r�zne re�lne korene
c=[1,1;lambda(1),lambda(2)]\[y_0;dy_0]; %v�po�et koeficientov c na z�klade po�iato�n�ch podmienok
y_anal=c'*[exp(lambda(1)*T_anal);exp(lambda(2)*T_anal)];  %v�po�et analytick�ho rie�enia y(t)
else  % komplexne zdru�en� korene
c=[1,0;real(lambda(1)),imag(lambda(1))]\[y_0;dy_0]; %v�po�et koeficientov c na z�klade po�iato�n�ch podmienok
y_anal=c'*[exp(real(lambda(1))*T_anal).*cos(imag(lambda(1))*T_anal);exp(real(lambda(1))*T_anal).*sin(imag(lambda(1))*T_anal)];  %v�po�et analytick�ho rie�enia y(t)
end        

simout=sim('cv_2_sim'); %spust�me simul�ciu
y_sim=simout.y;
T_sim=simout.tout;

figure(1);
plot(T_sim,y_sim,'-k','LineWidth',2);

title('Numerick� simul�cia') 
xlabel('�as[s]')  %oznacime si osi grafov
ylabel('y')
grid on

figure(2);
plot(T_anal,y_anal,'-k','LineWidth',2);

title('Analytick� rie�enie')
xlabel('�as[s]') %oznacime si osi grafov
ylabel('y')
grid on



