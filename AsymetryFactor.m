function [ AF ] = AsymetryFactor( E1_xy, E2_xy, E3_xy, size, image )
%ASYMETRYFACTOR Computes an asymetry factor for the intensity across 3
%square regions at given coordinates and a size.
%   E*_xy is an array of [x, y] coordinates of the centroid of the square
%   query points. Size is the size of these squares (one side of a square)
%   in pixels. Image is an array of intensity in the PPD2 scattering image.
%   The equation for AF is given in Kaye et al 1996.

hs = size/2;            % Get half size for convinience

% Select the queried parts of the image covered by the "photodiodes"
E1_array = image((E1_xy(2)-hs):(E1_xy(2)+hs),(E1_xy(1)-hs):(E1_xy(1)+hs));
E2_array = image((E2_xy(2)-hs):(E2_xy(2)+hs),(E2_xy(1)-hs):(E2_xy(1)+hs));
E3_array = image((E3_xy(2)-hs):(E3_xy(2)+hs),(E3_xy(1)-hs):(E3_xy(1)+hs));

E1 = sum(E1_array);     % Sum array to get E1
E2 = sum(E2_array);     % Sum array to get E2
E3 = sum(E3_array);     % Sum array to get E3

Ebar = (E1+ E2+E3)/3;   % Find the average for the AF computation

% Compute AF from the equation in Kaye et al 1996 (centroid of a triangle)
AF = (sqrt((Ebar-E1)^2+(Ebar-E2)^2+(Ebar-E3)^2)/3)*40.8;

end

