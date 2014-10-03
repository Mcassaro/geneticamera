function [] = ShowCamera(Pcamera)
%ShowCamera Create a pyramid showing the field of view of the defined
%camera.
%ShowCamera(Pcamera) takes as input a camera object:
% Pcamera.vertex = [p1'] is the vertex of the pyramid;
% Pcamera.base = [p2' p3' p4' p5'] contains the remaining points coordinates,
% arranged in the way shown below:
%
% p5._______.p3
%   |\     /|
%   | \   / | 
%   |  \./p1|
%   |  / \  |
%   | /   \ |
%   |/_____\|
% p4'       'p2


x = [Pcamera.vertex(1) Pcamera.vertex(1) Pcamera.vertex(1) Pcamera.vertex(1); Pcamera.base(1,1) Pcamera.base(1,1) Pcamera.base(1,3) Pcamera.base(1,4); Pcamera.base(1,2) Pcamera.base(1,3) Pcamera.base(1,4) Pcamera.base(1,2)];
y = [Pcamera.vertex(2) Pcamera.vertex(2) Pcamera.vertex(2) Pcamera.vertex(2); Pcamera.base(2,1) Pcamera.base(2,1) Pcamera.base(2,3) Pcamera.base(2,4); Pcamera.base(2,2) Pcamera.base(2,3) Pcamera.base(2,4) Pcamera.base(2,2)];
z = [Pcamera.vertex(3) Pcamera.vertex(3) Pcamera.vertex(3) Pcamera.vertex(3); Pcamera.base(3,1) Pcamera.base(3,1) Pcamera.base(3,3) Pcamera.base(3,4); Pcamera.base(3,2) Pcamera.base(3,3) Pcamera.base(3,4) Pcamera.base(3,2)];

fill3(x,y,z,'r')

end