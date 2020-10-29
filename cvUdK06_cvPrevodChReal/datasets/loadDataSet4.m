clear all;
load('dataset4.mat')
set(groot,'defaultLineLineWidth',1.5)
figure(1)
subplot(4,1,1)
plot(ds4_ventilator(:,1), ds4_ventilator(:,2),'-k')
xlabel('time[s]')
ylabel('u_{ventilator} [ ]')
title('Nastavenie ventil�tora')
grid on;
subplot(4,1,2)
plot(ds4_spirala(:,1), ds4_spirala(:,2),'-k')
xlabel('time [s]')
ylabel('u_{spirala} [ ]')
title('Vstupn� v�kon �pir�ly')
grid on;
subplot(4,1,3)
plot(ds4_snimac_1(:,1), ds4_snimac_1(:,2),'-k')
ylabel('T_1 [�C]')
xlabel('time [s]')
title('Meran� teplota 1')
grid on;
subplot(4,1,4)
plot(ds4_snimac_2(:,1), ds4_snimac_2(:,2),'-k')
xlabel('time[s]')
ylabel('T_2 [�C]')
title('Meran� teplota 2')
grid on;
set(gcf,'position',[50,50,1500,900])