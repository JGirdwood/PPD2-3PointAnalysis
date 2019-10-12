function [ E1_xy, E2_xy, E3_xy ] = r2xy( rad, offset_xy, angle_offset )
%RA2XY Transforms a radius and angle offset on a PPD2 image to xy 
%coordinates
%   E*_xy is the outlut coordinates of the photodoides in pixels, r is the
%   radius in pixels, and angle offset is the offset in the angle of the
%   first doide (given equal spacing) in degrees. offset_xy is the centre
%   of the image from the lower left corner in [x, y] pixels.
%
% Author:           Joseph Girdwood
% Affiliation:      University of Hertfordshire
% email:            j.girdwood@herts.ac.uk

% Set offset to 0 if not set
if nargin<3
  angle_offset = 0;
end

% Convert to cartesian from polar coordinates
E1_xy = round([rad*sind(angle_offset) + offset_xy(1), ...
    rad*cosd(angle_offset) + offset_xy(2)]);

E2_xy = round([rad*sind(angle_offset+120) + offset_xy(1), ...
    rad*cosd(angle_offset+120) + offset_xy(2)]);

E3_xy = round([rad*sind(angle_offset+120*2) + offset_xy(1), ...
    rad*cosd(angle_offset+120*2) + offset_xy(2)]);

end
