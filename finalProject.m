clc
clear
close all

mapSetup
vMax=10000;
time=0.75;
load('C_all_leaking.mat');

realPath=zeros(100);
C(C==0)=0.01;

for i=0:4
    realPath(:,1+i*20)=C(:,i*20+1);
end


realPath(1,:)=C(1,:);
realPath(21,41:end)=C(21,41:end);
realPath(51,21:41)=C(51,21:41);
realPath(81,21:end)=C(81,21:end);
realPath(100,:)=C(100,:);
realPath1=zeros(102);
realPath1(2:end-1,2:end-1)=realPath;
realPath2=realPath1;


% mean(mean(realPath))
% sum(sum(realPath~=0))
% mean(mean(realPath(realPath~=0)))
position(1,:)=[2 2];
count=0;
figure;hold on
plot([100 100],[0 5000],'k','LineWidth',1)
plot([100 5100],[5000 5000],'k','LineWidth',1)
plot([100 5100],[50 50],'k','LineWidth',1)
plot([1100 1100],[0 5000],'k','LineWidth',1)
plot([2100 2100],[0 5000],'k','LineWidth',1)
plot([3100 3100],[0 5000],'k','LineWidth',1)
plot([4100 4100],[0 5000],'k','LineWidth',1)
plot([2100 5100],[4000 4000],'k','LineWidth',1)
plot([1100 5100],[1000 1000],'k','LineWidth',1)
plot([1100 2100],[2500 2500],'k','LineWidth',1)


xlim([0,5200])
ylim([0,5200])
for i=1:vMax*time/50
    if i <536
        down=mean(realPath1(position(i,1)+1:end,position(i,2)));
        right=mean(realPath1(position(i,1),position(i,2)+1:end));
        up=mean(realPath1(1:position(i,1)-1,position(i,2)));
        left=mean(realPath1(position(i,1),1:position(i,2)-1));
        if max([down,right,up,left])==down&&realPath2(position(i,1)+1,position(i,2))~=0
            position(i+1,:)=[position(i,1)+1,position(i,2)];
        elseif max([right,up,left])==right&&realPath2(position(i,1),position(i,2)+1)~=0
            position(i+1,:)=[position(i,1),position(i,2)+1];
        elseif max([up,left])==up&&realPath2(position(i,1)-1,position(i,2))~=0
            position(i+1,:)=[position(i,1)-1,position(i,2)];
        elseif realPath2(position(i,1),position(i,2)-1)~=0
            position(i+1,:)=[position(i,1),position(i,2)-1];
        else
            count=count+1;
            position(i+1,:)=position(i-count,:);
            count=count+1;
        end
        realPath1(position(i,1),position(i,2))=0;
%     elseif i
    elseif i>707
        position(i+1,:)=[position(i,1)-1,position(i,2)];
    elseif i>687
        position(i+1,:)=[position(i,1),position(i,2)-1];
    elseif i>668
        position(i+1,:)=[position(i,1)+1,position(i,2)];
        
    elseif i>587
        position(i+1,:)=[position(i,1),position(i,2)-1];   
    else
        position(i+1,:)=[position(i,1),position(i,2)+1];        
    end        
        plot(position(i,2)*50,(102-position(i,1))*50+5000,'r.','MarkerSize',9)
        concentration(i)=C(min(position(i,1)-1,100),min(position(i,2)-1,100));
        
end
set(gca,'FontSize',14)
xlabel('X (m)')
ylabel('Y (m)')
figure
plot([1:i]/10*3,concentration)
set(gca,'FontSize',14)
xlabel('time (min)')
figure
plot([1:i]/10*3,cumsum(concentration))
set(gca,'FontSize',14)
xlabel('time (min)')
ylabel('C (ppm)')

figure;hold on
plot([100 100],[0 5000],'k','LineWidth',1)
plot([100 5100],[5000 5000],'k','LineWidth',1)
plot([100 5100],[50 50],'k','LineWidth',1)
plot([1100 1100],[0 5000],'k','LineWidth',1)
plot([2100 2100],[0 5000],'k','LineWidth',1)
plot([3100 3100],[0 5000],'k','LineWidth',1)
plot([4100 4100],[0 5000],'k','LineWidth',1)
plot([2100 5100],[4000 4000],'k','LineWidth',1)
plot([1100 5100],[1000 1000],'k','LineWidth',1)
plot([1100 2100],[2500 2500],'k','LineWidth',1)


xlim([0,5200])
ylim([0,5200])

% position=zeros(vMax*time/50+1,2);
position1(1,:)=[2 2];

for i=1:vMax*time/50
    down=rand;
	right=rand;
	up=rand;
	left=rand;
    if max([down,right,up,left])==down&&realPath2(position1(i,1)+1,position1(i,2))~=0
        position1(i+1,:)=[position1(i,1)+1,position1(i,2)];
	elseif max([right,up,left])==right&&realPath2(position1(i,1),position1(i,2)+1)~=0
        position1(i+1,:)=[position1(i,1),position(i,2)+1];
	elseif max([up,left])==up&&realPath2(position1(i,1)-1,position1(i,2))~=0
        position1(i+1,:)=[position1(i,1)-1,position1(i,2)];
	elseif realPath2(position1(i,1),position1(i,2)-1)~=0
        position1(i+1,:)=[position1(i,1),position1(i,2)-1];
    elseif realPath2(position1(i,1)+1,position1(i,2))~=0
        position1(i+1,:)=[position1(i,1)+1,position1(i,2)];
    elseif realPath2(position1(i,1),position1(i,2)+1)~=0
        position1(i+1,:)=[position1(i,1),position(i,2)+1];        
    end
    plot(position1(i,2)*50,102-position1(i,1)*50+5000,'r.','MarkerSize',9)
    concentration1(i)=C(min(position1(i,1)-1,100),min(position1(i,2)-1,100));
end

set(gca,'FontSize',14)
xlabel('X (m)')
ylabel('Y (m)')
figure
plot([1:i]/10*3,concentration1)
set(gca,'FontSize',14)
xlabel('time (min)')
figure
plot([1:i]/10*3,cumsum(concentration1))
set(gca,'FontSize',14)
xlabel('time (min)')
ylabel('C (ppm)')


