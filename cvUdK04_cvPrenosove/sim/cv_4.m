
%%
D=0;
B=[1];
A=[1,1];
%%
D=5;
B=[1];
A=[1,1];
%%
D=0;
B=[0.1];
A=[1,0];
%%
D=3;
B=[0.1];
A=[1,0];
%%
D=0;
B=[1 ,1];
A=[3 1];
%%
D=0;
B=[1,-1];
A=[3 1];
%%
D=0;
B=[0.5];
A=[1,2,1];
%%
D=0;
B=[0.5];
A=[1,1,1];
%%
D=0;
B=[0.5];
A=[1,0.2,1];

%%
D=0;
B=[0.5];
A=[1,0,1];
%%
D=0;
B=[0.2];
A=[1,1,0];
%%
D=0;
B=[0.2];
A=[1,0,0];
%%
D=4;
B=[0.2];
A=[1,0,0];

%%
D=0;
B=[1,2,2];
A=[1,0.3,4.03,0.401];
%%
D=6;
B=[1,2,2];
A=[1,0.3,4.03,0.401];

%%
close all;
G=tf(B,A,'InputDelay',D);
poles=roots(A);
figure();
stepplot(G);
movegui(gcf,[400,50])
figure();
pzmap(G);
movegui(gcf,[1000,50])
figure();
nyquist(G);
movegui(gcf,[400,550])
figure();
bode(G);
movegui(gcf,[1000,550])



