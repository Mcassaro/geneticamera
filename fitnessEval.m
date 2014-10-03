function [ fitness ] = fitnessEval( ParVect )
%FITNESSEVAL Summary of this function goes here
%   Detailed explanation goes here

global validCam
global angleLimits
global cameraset
global cameraNumber
global MCpoints
global side

%Check on input values 
%Remember limit for p1 : p1=5*side*rand;...
%...and for c2: c2=side*rand-side/2; 
% where p1=ParMatrix(2,k)
%       c2=ParMatrix(3,k)

parMatrix=reshape(ParVect,6,[]);

 for k=1:1:cameraNumber
     validCam(k)= (...
     CheckPar(parMatrix(1,k),0,1) &&...
     CheckPar(parMatrix(2,k),0,side*5)&&...
     CheckPar(parMatrix(3,k),-side/2,+side/2)&&...
     CheckPar(parMatrix(4,k),angleLimits(2),angleLimits(1))&&...
     CheckPar(parMatrix(5,k),angleLimits(4),angleLimits(3))&&...
     CheckPar(parMatrix(6,k),angleLimits(6),angleLimits(5)));
 end
 
if (sum(validCam)==cameraNumber)
    
cameraset=CreateCamera(parMatrix);

[CamInt,CumulativeIntersection]=MontecarloVolume(cameraset);

W=100/MCpoints*[0 0.1 0.2 1 0.8 0.1 0.05 0.01 0.001];   %Weights vector

fitness=1/(W*CumulativeIntersection');      %FITNESS VALUE


%% Plots

% hold on
% grid on
% 
% for k=1:1:cameraNumber
%  ShowCamera(cameraset(k));
% end
% 
% ShowTrackingVolume(side);
% 
% xlabel('x');
% ylabel('y');
% zlabel('z');
% axis([-side side -side side -side side]);
% alpha(0.5);

% figure
% faceColor  = [0.6875 0.8750 0.8984];
% tetramesh(cameraset(1).mesh,'FaceColor', faceColor,'FaceAlpha',0.3);

else 
    fitness=NaN;
end

end

