
%%
Tsim=20;
Ts=0.1;

K=2;
T=5;

P=2; 
I=1;
D=1.5;
N=5;

%%
F_s=tf(K,[T,1]);
%F_reg=tf(P,1)+tf(I,[1,0])+tf([D*N,0],[1,N]); %filtrovaná derivácia
F_reg=tf(P,1)+tf(I,[1,0])+tf([D,0],1); %nefiltrovaná derivácia
F_oro=F_s*F_reg;
F_uro=feedback(F_oro,1);
%%

out=sim('cv9_sim');
close all;
figure(1);
hold on;
grid on;
title('Riadenie prenosovej funkcie prvého rádu PID regulátorom')
xlabel('èas [s]')
yyaxis left;
plot(out.tout,out.y,'-','LineWidth',2);
plot(out.tout,out.w,'--','LineWidth',2);
ylabel('y,w');
yyaxis right;
plot(out.tout,out.u,'.','LineWidth',2);
ylabel('u');
legend('y','w','u');


%%
pzplot(F_uro,'r')
grid on;
a = findobj(gca,'type','line')
for i = 1:length(a)
    set(a(i),'markersize',7) %change marker size
    set(a(i), 'linewidth',2.0)  %change linewidth
end
set(gcf,'position',[0,0,550,500])


