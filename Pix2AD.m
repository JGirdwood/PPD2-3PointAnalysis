function [ half_angle, rad_mm ] = Pix2AD( rad_pix )
%PIX2AD Converts pixels to angle and distance for the PPD2 camera.
%   Converts radial distance in pixels to radial distance in mm and
%   scattering angle.

[~, c] = size(rad_pix);
half_angle = zeros(1, c);
rad_mm = zeros(1, c);

PPD2_max_pix = 780/2;           % Number of pixels at the max angle
LUT = load("ppd2angles.mat");   % Lookup table for angle and mm
LUT = LUT.ppd2angles;
[r, ~] = size(LUT);
pixel_arr = 0:PPD2_max_pix/r:PPD2_max_pix;
pixel_arr = pixel_arr';
LUT = [[[0,0];LUT], pixel_arr];
HA_interp = griddedInterpolant(LUT(:,end), LUT(:,1));
rad_interp = griddedInterpolant(LUT(:,end), LUT(:,2));

for i=1:c
    half_angle(1, i) = HA_interp(rad_pix(i));
    rad_mm(1, i) = rad_interp(rad_pix(i));
end

end

