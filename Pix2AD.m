function [ half_angle, rad_mm ] = Pix2AD( rad_pix )
%PIX2AD Converts pixels to angle and distance for the PPD2 camera.
%   Converts radial distance in pixels to radial distance in mm and
%   scattering angle.

PPD2_max_pix = 780/2;           % Number of pixels at the max half angle
LUT = load("ppd2angles.mat");   % Lookup table for angle and mm
LUT = LUT.ppd2angles;
[r, ~] = size(LUT);
pixel_arr = 0:PPD2_max_pix/r:PPD2_max_pix;
pixel_arr = pixel_arr';
LUT = [[[0,0];LUT], pixel_arr];
HA_interp = griddedInterpolant(LUT(:,end), LUT(:,1));
rad_interp = griddedInterpolant(LUT(:,end), LUT(:,2));

half_angle = HA_interp(rad_pix);
rad_mm = rad_interp(rad_pix);

end
