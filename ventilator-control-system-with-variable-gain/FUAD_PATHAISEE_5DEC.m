clc;
clear all;
close all;
%% task 1 for the plant system 
% arbitrary variables taken from table 1 
s=tf('s');
R_lung = 5/1000;
C_lung = 20;
R_leak = 60/1000;
R_hose = 4.5/1000;
W  = 2*pi*30;
zeta = 1;
controller_default = 1/s;
% variables from equations 9
A_h = (-1)*((1/R_hose)+(1/R_leak))/(R_lung*C_lung*(1/R_lung + 1/R_hose + 1/R_leak));
B_h = (1/R_hose)/(R_lung*C_lung*(1/R_lung + 1/R_hose + 1/R_leak));
C_h = transpose([(1/R_lung)/(1/R_lung + 1/R_hose + 1/R_leak) , (-1/R_hose -1/R_leak)/(R_lung*(1/R_lung + 1/R_hose + 1/R_leak))]);
D_h = transpose([(1/R_hose)/(1/R_lung + 1/R_hose + 1/R_leak),(1/R_hose)/(R_lung*(1/R_lung + 1/R_hose + 1/R_leak))]);

% variable from equation 11
B= (W^2)/(s^2+2*zeta*W*s+W^2);
%Patient hose transfer function 

H = C_h*((s*eye(1)-A_h)^-1)*B_h + D_h;
P = B*H;
%% task 2, transfer function for plants 
T1 = minreal((P(1)+P(1)/s)/(1+P(1)/s));
T2 = minreal((P(2)+P(2)/s)/(1+P(1)/s));
G1 = minreal(T1/(1-T1));
G2 = minreal(T2/(1-T2));
% rlocus(P(1)/s)
% sgrid(1,0)
% [k poles]=rlocfind(P(1))
% figure(1); grid on; title('root locus for Paw');
% rlocus(G1,'y--')
% figure(2); grid on; title('root locus for Paw');
% rlocus(G2,'b')
%% task 3 -- graph for the transfer function 
rlocus(P(1)/s);
%% task 4
% controller_1 = 0.0001/s;
% controller_2 = 0.4/s;
% controller_3 = 10/s;
% P_set = (5/s)+ (63.158*(exp(-s)-exp(-1.2375*s))/(s*s)) - ((15/s)*exp(-5*s));
% plot(impulse(P_set));
% % for ki = 0
% T1_1 = minreal((P(1)+P(1)*controller_1)/(1+P(1)*controller_1));
% T2_1 = minreal((P(2)+P(2)*controller_1)/(1+P(1)*controller_1));
% Paw_1 = T1_1*P_set; 
% Qpat_1 = T2_1 * P_set;
% plot(impulse(Paw_1),'y--',impulse(P_set),'r');
% %plot(Qpat_1);
