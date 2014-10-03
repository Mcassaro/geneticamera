function [cameraset] = CreateCamera(ParMatrix)
%[camera] = CreateCamera(Haov,Vaov,u,t,ptr) defines a camera object. Taking
% in input:
%   Haov: Horizontal angle of view
%   Vaov: Vertical angle of view
%   u: camera height
%   t = [tx,ty,tz] vertex coordinates
%   ptr = [p, t, r] pan, tilt and roll angles (in degrees).
%
%       Angle Convention:
%       Pan-Tilt-Roll with
%           PAN: positive rotation around the axis going from the BOTTOM of
%                the camera to the TOP one (Z).
%           TILT: positive rotation around the axis going from the RIGHT 
%                 side of the camera to the LEFT one (Y).
%           ROLL: positive rotation around the axis going from the REAR of
%                 the camera to the FRONT side (X). 
%
% ROTATIONS MATRICES are applied in P*T*R order

global opticLimits
global cameraNumber
global side

for k=cameraNumber:-1:1

% X Y Z Camera Position

p1=ParMatrix(2,k);
c2=ParMatrix(3,k);
  
cf=(fix(p1/side)); %cube face
c1=p1-cf*side-side/2; %coordinate 1


 switch cf
    case 0
        x=c1;
        y=-side/2;
        z=c2;
        pan=ParMatrix(4,k)+90;
        tilt=ParMatrix(5,k);
        roll=ParMatrix(6,k);
        
    case 1
        x=side/2;
        y=c1;
        z=c2;
        pan=ParMatrix(4,k)+180;
        tilt=ParMatrix(5,k);
        roll=ParMatrix(6,k);
    case 2
        x=c1;
        y=side/2;
        z=c2;
        pan=ParMatrix(4,k)-90;
        tilt=ParMatrix(5,k);
        roll=ParMatrix(6,k);
    case 3
        x=-side/2;
        y=c1;
        z=c2;
        pan=ParMatrix(4,k);
        tilt=ParMatrix(5,k);
        roll=ParMatrix(6,k);
    case 4
        x=c1;
        y=c2;
        z=side/2;
        pan=ParMatrix(4,k);
        tilt=ParMatrix(5,k)+90;
        roll=ParMatrix(6,k);
        
    otherwise
        x=0;
        y=0;
        z=0;
        
  end
 
 
Haov=(opticLimits(1)-opticLimits(4))*(ParMatrix(1,k))+opticLimits(4); %Haov
Vaov=(opticLimits(2)-opticLimits(5))*(ParMatrix(1,k))+opticLimits(5); %Vaov
Urange=opticLimits(3)-(opticLimits(3)-opticLimits(6))*ParMatrix(1,k); %U range (adjust with nonlinear dependence)


%Pan-Tilt-Roll angles
a = deg2rad(pan);%deg2rad(ParMatrix(4,k)); %alfa 
b = deg2rad(tilt);%deg2rad(ParMatrix(5,k)); %beta
g = deg2rad(roll);%deg2rad(ParMatrix(6,k)); %gamma

% P Rotation
P = [cos(a) -sin(a) 0; sin(a) cos(a) 0; 0 0 1];
% T Rotation
T = [cos(b) 0 sin(b); 0 1 0; -sin(b) 0 cos(b)];
% R Rotation
R = [1 0 0; 0 cos(g) -sin(g); 0 sin(g) cos(g)];

% Translation Matrix
Tr = [ 1 0 0 x; 0 1 0 y; 0 0 1 z; 0 0 0 1];
% Rotation Matrix
M=P*T*R;
M=[M(1,:) 0; M(2,:) 0; M(3,:) 0; 0 0 0 1];
% Rototranslation Matrix
RT=Tr*M;

Th = deg2rad(Haov);  %theta horizontal 
Tv = deg2rad(Vaov);  %theta vertical 

h=Urange*tan(Th/2);
v=Urange*tan(Tv/2);

cam=camera;

cam.vertex = RT*[0,0,0,1]';
cam.base = [RT*[Urange,h,-v,1]', RT*[Urange,h,v,1]', RT*[Urange,-h,-v,1]', RT*[Urange,-h,v,1]'];
cam.aov=[Haov,Vaov]';
%Delaunay Triangulation 
cam.mesh = DelaunayTri([cam.vertex(1:3)';cam.base(1:3,:)']);

cam.angles=ParMatrix(4:6,k);
cam.range=Urange;

cameraset(k)=cam;

end

end