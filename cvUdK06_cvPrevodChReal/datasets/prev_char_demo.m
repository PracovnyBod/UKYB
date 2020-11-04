
loadDataSet1;
idx_vent=find([diff(ds1_ventilator(:,2));false]);

idx=diff(ds1_spirala(:,2))~=0;
idx=[idx;false];
idx_1=find(idx(1:idx_vent));
idx_2=find(idx(idx_vent+1:end))+idx_vent;

nb=150;

u_prevod_1=ds1_spirala(idx_1,2);
u_prevod_2=ds1_spirala(idx_2,2);

subplot(4,1,3)
hold on
for i=1:length(idx_1)
    T_prevod_11(i)=mean(ds1_snimac_1(idx_1(i)-nb:idx_1(i),2));
    plot(ds1_snimac_1(idx_1(i)-nb:idx_1(i),1), T_prevod_11(i)*ones(nb+1,1),'-r')
end

for i=1:length(idx_2)
    T_prevod_12(i)=mean(ds1_snimac_1(idx_2(i)-nb:idx_2(i),2));
    plot(ds1_snimac_1(idx_2(i)-nb:idx_2(i),1), T_prevod_12(i)*ones(nb+1,1),'-r')
end
subplot(4,1,4)
hold on
for i=1:length(idx_1)
    T_prevod_21(i)=mean(ds1_snimac_2(idx_1(i)-nb:idx_1(i),2));
    plot(ds1_snimac_2(idx_1(i)-nb:idx_1(i),1), T_prevod_21(i)*ones(nb+1,1),'-r')
end

for i=1:length(idx_2)
    T_prevod_22(i)=mean(ds1_snimac_2(idx_2(i)-nb:idx_2(i),2));
    plot(ds1_snimac_2(idx_2(i)-nb:idx_2(i),1), T_prevod_22(i)*ones(nb+1,1),'-r')
end

subplot(4,1,2)
hold on
plot(ds1_spirala(idx,1), ds1_spirala(idx,2),'+r')

figure(2);
hold on
plot(u_prevod_1,T_prevod_11,'+r');
plot(u_prevod_2,T_prevod_12,'or');
plot(u_prevod_1,T_prevod_21,'+b');
plot(u_prevod_2,T_prevod_22,'ob');
grid on;
xlabel('u_{spirala} [ ]')
ylabel('T [ ]')
legend('snímaè_1 vent_1','snímaè_1 vent_2','snímaè_2 vent_1','snímaè_2 vent_2');
title('Prevodová charakteristika');