clc
clear
close all
vMax=10000;
time=4;


load('position_4.mat');
load('C_10_leaking.mat');
for i=1:vMax*time/50
    concentration(i)=C(min(position(i,1)-1,100),min(position(i,2)-1,100));
end
figure
plot([1:i]/10*3,concentration)
set(gca,'FontSize',14)
xlabel('time (min)')
figure
plot([1:i]/10*3,cumsum(concentration))
set(gca,'FontSize',14)
xlabel('time (min)')
ylabel('C (ppm)')