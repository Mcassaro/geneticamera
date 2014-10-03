function [ ParMatrix ] = RandCameraPar()
%RANDCAMERAPAR Summary of this function goes here

global angleLimits
global side
global cameraNumber

ParMatrix=zeros(6,cameraNumber); %Pre-allocate ParMatrix

for i=1:1:cameraNumber

 ParMatrix(1,i)=rand; %Kaov (Angle of View Coefficient)
 ParMatrix(2,i)=5*side*rand; %Coordinate 1 parameter
 ParMatrix(3,i)=side*rand-side/2;  %Coordinate 2
 ParMatrix(4,i)=(angleLimits(1)-angleLimits(2))*(rand-1/2)+(angleLimits(1)+angleLimits(2))/2; %PAN
 ParMatrix(5,i)=(angleLimits(3)-angleLimits(4))*(rand-1/2)+(angleLimits(3)+angleLimits(4))/2; %TILT
 ParMatrix(6,i)=(angleLimits(5)-angleLimits(6))*(rand-1/2)+(angleLimits(5)+angleLimits(6))/2; %ROLL

end

end