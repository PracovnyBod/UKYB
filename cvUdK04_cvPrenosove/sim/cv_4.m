
%% Systém prvého rádu bez dopravného oneskorenia
D=0;
B=[1];
A=[1,1];
%% Systém prvého rádu s dopravnım oneskorením
D=5;
B=[1];
A=[1,1];
%% Astatizmus prvého rádu - integrátor
D=0;
B=[0.1];
A=[1,0];
%% Astatizmus prvého rádu - integrátor s dopravnım oneskorením
D=3;
B=[0.1];
A=[1,0];
%% Systém prvého rádu so stabilnou nulou - minimálne fázovı
D=0;
B=[1,1];
A=[3 1];
%% Systém prvého rádu s nestabilnou nulou - neminimálne fázovı
D=0;
B=[1,-1];
A=[3 1];
%% Systém druhého rádu - dvojnásobnı reálny pól - aperiodickı priebeh
D=0; 
B=[0.5];
A=[1,2,1];
%% Systém druhého rádu - komplexne zdruené póly - periodickı priebeh (väèšie tlmenie = menšia kmitavos)
D=0;
B=[0.5];
A=[1,1,1];
%% Systém druhého rádu - komplexne zdruené póly - periodickı priebeh (menšie tlmenie = väèšia kmitavos)
D=0;
B=[0.5];
A=[1,0.2,1];

%% Systém druhého rádu - rıdzo imaginárne póly - periodickı priebeh bez tlmenia
D=0;
B=[0.5];
A=[1,0,1];
%% Systém prvého rádu s astatizmom prvého rádu 
D=0;
B=[0.2];
A=[1,1,0];
%% Astatizmus druhého rádu
D=0;
B=[0.2];
A=[1,0,0];
%% Astatizmus druhého rádu s dopravnım oneskorením
D=4;
B=[0.2];
A=[1,0,0];

%% Systém tretieho rádu s jednım reálnym a dvomi komplexne zdruenımi pólmi. Kombinácia periodického a aperiodického priebehu
D=0;
B=[1,2,2];
A=[1,0.3,4.03,0.401];
%% Systém tretieho rádu s jednım reálnym a dvomi komplexne zdruenımi pólmi. Kombinácia periodického a aperiodického priebehu a s dopravnım oneskorením
D=6;
B=[1,2,2];
A=[1,0.3,4.03,0.401];

%%
close all;
G=tf(B,A,'InputDelay',D);
poles=roots(A)
figure();
set(gcf,'Position',[50 50 1800 950])
subplot(2,2,1)
stepplot(G,'-k');
subplot(2,2,2)
pzmap(G,'-k');
subplot(2,2,3)
nyquist(G,'-k');
subplot(2,2,4)
bode(G,'-k');




