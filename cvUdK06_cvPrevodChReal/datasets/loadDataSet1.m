clear all;
load('dataset1.mat')
set(groot,'defaultLineLineWidth',1.5)
figure(1)
subplot(4,1,1)
plot(ds1_ventilator(:,1), ds1_ventilator(:,2),'-k')
xlabel('time[s]')
ylabel('u_{ventilator} [ ]')
title('Nastavenie ventilátora')
grid on;
subplot(4,1,2)
plot(ds1_spirala(:,1), ds1_spirala(:,2),'-k')
xlabel('time [s]')
ylabel('u_{spirala} [ ]')
title('Vstupný výkon špirály')
grid on;
subplot(4,1,3)
plot(ds1_snimac_1(:,1), ds1_snimac_1(:,2),'-k')
ylabel('T_1 [°C]')
xlabel('time [s]')
title('Meraná teplota 1')
grid on;
subplot(4,1,4)
plot(ds1_snimac_2(:,1), ds1_snimac_2(:,2),'-k')
xlabel('time[s]')
ylabel('T_2 [°C]')
title('Meraná teplota 2')
grid on;
set(gcf,'position',[50,50,1500,900])
