clear all;
load('dataset2.mat')
set(groot,'defaultLineLineWidth',1.5)
figure(1)
subplot(4,1,1)
plot(ds2_ventilator(:,1), ds2_ventilator(:,2),'-k')
xlabel('time[s]')
ylabel('u_{ventilator} [ ]')
title('Nastavenie ventil�tora')
grid on;
subplot(4,1,2)
plot(ds2_spirala(:,1), ds2_spirala(:,2),'-k')
xlabel('time [s]')
ylabel('u_{spirala} [ ]')
title('Vstupn� v�kon �pir�ly')
grid on;
subplot(4,1,3)
plot(ds2_snimac_1(:,1), ds2_snimac_1(:,2),'-k')
ylabel('T_1 [ ]')
xlabel('time [s]')
title('Meran� teplota 1')
grid on;
subplot(4,1,4)
plot(ds2_snimac_2(:,1), ds2_snimac_2(:,2),'-k')
xlabel('time[s]')
ylabel('T_2 [ ]')
title('Meran� teplota 2')
grid on;
set(gcf,'position',[50,50,1500,900])
