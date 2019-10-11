function [ AR123 ] = E123toPolar( E123 )
%E123TOPOLAR Convert the 3 detector energies to a polar vetcor centroid.
%   AR123 is the radius and angle of the point and E123 is the 3 detector
%   energies in the following format [E1, E2, E3].

[X1, Y1] = pol2cart(0, E123(1));
[X2, Y2] = pol2cart(120*pi/180, E123(2));
[X3, Y3] = pol2cart(240*pi/180, E123(3));

X123 = (X1 + X2 + X3)/3;
Y123 = (Y1 + Y2 + Y3)/3;

AR123 = cart2pol(X123, Y123);

end

