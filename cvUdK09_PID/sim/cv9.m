
%%
Tsim=20;
Ts=0.1;

K=2;
T=5;

P=2; 
I=0;
D=0;

N=5;

%%
use_filt=false;
F_s=tf(K,[T,1]);
if use_filt
F_reg=tf(P,1)+tf(I,[1,0])+tf([D*N,0],[1,N]); %filtrovan� deriv�cia
else
F_reg=tf(P,1)+tf(I,[1,0])+tf([D,0],1); %nefiltrovan� deriv�cia
end
F_oro=F_s*F_reg;
F_uro=feedback(F_oro,1);
%%

out=sim('cv9_sim');
close all;
figure(1);
hold on;
grid on;
title('Riadenie prenosovej funkcie prv�ho r�du PID regul�torom')
xlabel('�as [s]')
yyaxis left;
plot(out.tout,out.y,'-','LineWidth',2);
plot(out.tout,out.w,'--','LineWidth',2);
ylabel('y,w');
yyaxis right;
plot(out.tout,out.u,'.','LineWidth',2);
ylabel('u');
legend('y','w','u');


figure(2)
pzplot(F_uro,'r')
grid on;
a = findobj(gca,'type','line')
for i = 1:length(a)
    set(a(i),'markersize',7) 
    set(a(i), 'linewidth',2.0) 
end
set(gcf,'position',[0,0,550,500])

