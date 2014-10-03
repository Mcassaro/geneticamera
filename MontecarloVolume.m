function [intersection,comint] = MontecarloVolume( cameraset )
%MONTECARLO Summary of this function goes here
%   Detailed explanation goes here

global MCpoints
global side

cameranumber=length(cameraset);
points=side*rand(MCpoints,3)-side/2;

score=zeros(MCpoints,length(cameranumber));

%for every camera...
for j=1:1:cameranumber

    check=pointLocation(cameraset(j).mesh,points);
    score(:,j)=~isnan(check); 
      
end

sumscore=sum(score);       %tells how many points the i-th camera sees
intersection=sum(score,2); %tells how many cameras see the i-th point

for m=1:1:cameranumber
    cameraset(m).includedPts=sumscore(m);
end

comint=zeros(1,cameranumber+1);
for n=1:1:length(comint)
    for k=1:1:MCpoints
     if intersection(k)==(n-1);
         comint(n)=comint(n)+1; % 1st el: points not seen at all, 
                                % 2nd el: points seen by 1 camera; 
                                % 3rd el: points seen by 2 cameras...
     end
    end
end
         
%*** UNCOMMENT FOR DEBUG PURPOSE:
% DO NOT RUN TOGETHER WITH THE EVOLUTIONARY STRATEGY !!

%*** Plot the random points cloud contained in one camera 
% j=3;  %Select here the number of the camera
% hold on
%  for i=1:1:MCpoints
%     if score(i,j)==1
%        plot3(points(i,1),points(i,2),points(i,3),'k+');
%     end
%  end

%*** Plot the random points that are contained in the intersection of two or more cameras 

% IntN=3;  %Search points contained in the intersection or IntN or more cameras.
% hold on
%  for i=1:1:MCpoints
%     if intersection(i)>=IntN;
%        plot3(points(i,1),points(i,2),points(i,3),'k+');
%     end
%  end

 
end
