function [] = ShowTrackingVolume(s)
%ShowTrackingVolume plot the edges of the tracking volume in a 3-D plot.

x = [-s/2  s/2  s/2  -s/2  -s/2  -s/2  s/2  s/2  -s/2  -s/2  s/2  s/2  s/2  s/2  -s/2  -s/2];
y = [-s/2  -s/2  s/2  s/2  -s/2  -s/2  -s/2  s/2  s/2  -s/2  -s/2  -s/2  s/2  s/2  s/2  s/2];
z = [-s/2  -s/2  -s/2  -s/2  -s/2  s/2  s/2  s/2  s/2  s/2  s/2  -s/2  -s/2  s/2  s/2  -s/2];

plot3(x,y,z);

end

