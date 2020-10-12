
%% Syst�m prv�ho r�du bez dopravn�ho oneskorenia
D=0;
B=[1];
A=[1,1];
%% Syst�m prv�ho r�du s dopravn�m oneskoren�m
D=5;
B=[1];
A=[1,1];
%% Astatizmus prv�ho r�du - integr�tor
D=0;
B=[0.1];
A=[1,0];
%% Astatizmus prv�ho r�du - integr�tor s dopravn�m oneskoren�m
D=3;
B=[0.1];
A=[1,0];
%% Syst�m prv�ho r�du so stabilnou nulou - minim�lne f�zov�
D=0;
B=[1,1];
A=[3 1];
%% Syst�m prv�ho r�du s nestabilnou nulou - neminim�lne f�zov�
D=0;
B=[1,-1];
A=[3 1];
%% Syst�m druh�ho r�du - dvojn�sobn� re�lny p�l - aperiodick� priebeh
D=0; 
B=[0.5];
A=[1,2,1];
%% Syst�m druh�ho r�du - komplexne zdru�en� p�ly - periodick� priebeh (v��ie tlmenie = men�ia kmitavos�)
D=0;
B=[0.5];
A=[1,1,1];
%% Syst�m druh�ho r�du - komplexne zdru�en� p�ly - periodick� priebeh (men�ie tlmenie = v��ia kmitavos�)
D=0;
B=[0.5];
A=[1,0.2,1];

%% Syst�m druh�ho r�du - r�dzo imagin�rne p�ly - periodick� priebeh bez tlmenia
D=0;
B=[0.5];
A=[1,0,1];
%% Syst�m prv�ho r�du s astatizmom prv�ho r�du 
D=0;
B=[0.2];
A=[1,1,0];
%% Astatizmus druh�ho r�du
D=0;
B=[0.2];
A=[1,0,0];
%% Astatizmus druh�ho r�du s dopravn�m oneskoren�m
D=4;
B=[0.2];
A=[1,0,0];

%% Syst�m tretieho r�du s jedn�m re�lnym a dvomi komplexne zdru�en�mi p�lmi. Kombin�cia periodick�ho a aperiodick�ho priebehu
D=0;
B=[1,2,2];
A=[1,0.3,4.03,0.401];
%% Syst�m tretieho r�du s jedn�m re�lnym a dvomi komplexne zdru�en�mi p�lmi. Kombin�cia periodick�ho a aperiodick�ho priebehu a s dopravn�m oneskoren�m
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




