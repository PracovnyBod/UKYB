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
ylabel('T_1 [ ]')
xlabel('time [s]')
title('Meraná teplota 1')
grid on;
subplot(4,1,4)
plot(ds1_snimac_2(:,1), ds1_snimac_2(:,2),'-k')
xlabel('time[s]')
ylabel('T_2 [ ]')
title('Meraná teplota 2')
grid on;
set(gcf,'position',[50,50,1500,900])
%%
idx_vent=find([diff(ds1_ventilator(:,2));false]);

idx=diff(ds1_spirala(:,2))~=0;
idx=[idx;false];
idx_1=find(idx(1:idx_vent));
idx_2=find(idx(idx_vent+1:end))+idx_vent;

u_prevod_1=ds1_spirala(idx_1,2);
T_prevod_1=ds1_snimac_1(idx_1,2);

u_prevod_2=ds1_spirala(idx_2,2);
T_prevod_2=ds1_snimac_1(idx_2,2);

subplot(4,1,2)
hold on
plot(ds1_spirala(idx,1), ds1_spirala(idx,2),'+r')

subplot(4,1,3)
hold on
plot(ds1_snimac_1(idx,1), ds1_snimac_1(idx,2),'+r')

subplot(4,1,4)
hold on
plot(ds1_snimac_2(idx,1), ds1_snimac_2(idx,2),'+r')

figure(2);
hold on
plot(u_prevod_1,T_prevod_1,'+k');
plot(u_prevod_2,T_prevod_2,'ok');
grid on;
xlabel('u_{spirala} [ ]')
ylabel('T [ ]')
title('Prevodová charakteristika');

