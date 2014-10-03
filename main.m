%main
%BONITA CAMERA properties
%Wide 82.7° x 66.85° 8m range
%Narrow 32.7° x 24.81° 12m range

% INCLUDED POINTS NELLA STRUCT CAMERA NON VIENE AGGIORNATO
% PERCHE' LA FITNESS E' INF SE TUTTE LE CAMERE COINCIDONO ?:
% Perchè la cumulative intersection riporta solo i punti visti da i camere 
% senza comprendere all'interno di essi quelli visti da i-1, i-2... camere.

clc
clear all
close all

%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
% WARNING: U IS NOT PROPORTIONAL TO 1/AOV 
% FIX IT BEFORE FINAL RELEASE
%!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

global MCpoints
global opticLimits
global angleLimits
global side
global cameraNumber
global cameraset
global validCam

%% Parameters

% Angle of views and range limits
opticLimits=[82.7,...           %Horizontal AOV Max
             66.85,...          %Vertical AOV Max
             12,...             %Range of view Max % Bonita=12m
             32.7,...           %Horizontal AOV min
             26.43,...          %Vertical AOV min % Bonita=24.81 from datasheet but we assume 26.43 to take the same ratio of Haov_M/Vaov_M
             8];                %Range of view min % Bonita=8m

% Camera attitude limits         
angleLimits=[90,...             %Pan Angle Max
             -90,...            %Pan Angle min
             90,...             %Tilt Angle Max
             -90,...            %Tilt Angle min
             180,...            %Roll Angle Max %we start considering 0 roll
             -180];             %Roll Angle min

side=9;             %Tracking facility (cube) dimension
MCpoints=100000;    %Montecarlo Random points number

cameraNumber=8;     %Number of cameras

ParMAT = RandCameraPar; %Create a random parameters matrix
ParVET = reshape(ParMAT,6*cameraNumber,[]);

ParCol = [0.5 5*side/2 side/2 0 0 0]';
ParVET = ParCol;
for num=1:1:cameraNumber-1
 ParVET=[ParVET;ParCol];
end


sigma= [1/3,5*side/3,side/3,180/3,180/3,360/3]';
S=sigma;
for num=1:1:cameraNumber-1
 S=[S;sigma];
end

%% Fitness Evaluation

[XMIN, FMIN, COUNTEVAL, STOPFLAG, OUT, BESTEVER]=cmaes('fitnessEval',ParVET,S);
%FIT=fitnessEval(ParVET)






