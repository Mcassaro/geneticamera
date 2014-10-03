function [ bool ] = CheckPar( x, min, max )
%CHECKPAR Summary of this function goes here
%   Detailed explanation goes here

if ((x>=min) && (x<=max))
    bool=1;
else
    bool=0;
end


end

