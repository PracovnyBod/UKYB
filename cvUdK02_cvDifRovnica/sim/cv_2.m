clear;
close all;
cv_2_sim
Ts=0.1; %Perióda výpoètu simulácie (nepodstatné)
Tsim=5; %Dåžka trvania simulácie (nepodstatné)
%%
a_0=10; %zvolíme konštantné koeficienty diferenciálnej rovnice - komplexne združené korene
a_1=2; 
%%
a_0=2; %zvolíme konštantné koeficienty diferenciálnej rovnice - rôzne reálne korene
a_1=3;
%%
a_0=9; %zvolíme konštantné koeficienty diferenciálnej rovnice - dvojnásobný reálny koreò
a_1=6;
%%

y_0=4; %zvolíme poèiatoèné podmienky - výstup
dy_0=3; %zvolíme poèiatoèné podmienky - derivácia výstupu

%charakteristická rovnica nech je v tvare lambda^2+a_1*lambda+a_0
D=sqrt(a_1^2-4*a_0); % diskriminant charakteristickej rovnice 
lambda=[(-a_1+D),(-a_1-D)]/(2); % korene charakteristickej rovnice

T_anal=0:Ts:Tsim;

if lambda(1)==lambda(2) % dvojnásobný reálny koreò
c=[1,0;lambda(1),1]\[y_0;dy_0];     %výpoèet koeficientov c na základe poèiatoèných podmienok
y_anal=c'*[exp(lambda(1)*T_anal);T_anal.*exp(lambda(2)*T_anal)]; %výpoèet analytického riešenia y(t)
elseif imag(lambda(1))==0  % rôzne reálne korene
c=[1,1;lambda(1),lambda(2)]\[y_0;dy_0]; %výpoèet koeficientov c na základe poèiatoèných podmienok
y_anal=c'*[exp(lambda(1)*T_anal);exp(lambda(2)*T_anal)];  %výpoèet analytického riešenia y(t)
else  % komplexne združené korene
c=[1,0;real(lambda(1)),imag(lambda(1))]\[y_0;dy_0]; %výpoèet koeficientov c na základe poèiatoèných podmienok
y_anal=c'*[exp(real(lambda(1))*T_anal).*cos(imag(lambda(1))*T_anal);exp(real(lambda(1))*T_anal).*sin(imag(lambda(1))*T_anal)];  %výpoèet analytického riešenia y(t)
end        

simout=sim('cv_2_sim'); %spustíme simuláciu
y_sim=simout.y;
T_sim=simout.tout;

figure(1);
plot(T_sim,y_sim,'-k','LineWidth',2);

title('Numerická simulácia') 
xlabel('èas[s]')  %oznacime si osi grafov
ylabel('y')
grid on

figure(2);
plot(T_anal,y_anal,'-k','LineWidth',2);

title('Analytické riešenie')
xlabel('èas[s]') %oznacime si osi grafov
ylabel('y')
grid on



