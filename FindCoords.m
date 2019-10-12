%%  FindCoords
% A script to find and compare 3 virtual 'detectors' in PPD2 data. This has
% the intention to become the basis for creating an instrument similar to
% Kaye et al 1996, except with much lower cost.
%
% Author:           Joseph Girdwood
% Affiliation:      University of Hertfordshire
% email:            j.girdwood@herts.ac.uk

%%  User specified variables
% All the variables to alter the behaviour of the script are specified here
% for usability.
close, clear, clc

rad_loop = 0;               % Loop through radii or images
image_loop = 1 - rad_loop;

compare_droplet_rad = 1;    % Compare radii of drops or solids
compare_solid_rad = 1 - compare_droplet_rad;

% ******Specify cm to pixel conversions here when known********

% Specify the file paths for various different aerosol types (droplet and
% solid defined). 
droplet_path = 'C:\Users\jg17acv\Documents\DevelopmentEngineer\UH-PPD-LC\PPD2-sorted\Droplets';
solid_path = 'C:\Users\jg17acv\Documents\DevelopmentEngineer\UH-PPD-LC\PPD2-sorted\Unclassified-Solid';

%%  Pre-Loop computation
jpeg_cell_droplet = Importer(droplet_path); % Import droplet images
jpeg_cell_solid = Importer(solid_path);     % Import solid images

[dy, dx] = size(jpeg_cell_droplet{1});      % Get image size pixels
offset_xy = [round(dx/2), round(dy/2)];     % Get image centre pixels
[rd, ~] = size(jpeg_cell_droplet);          % Get amount of droplets
[rs, ~] = size(jpeg_cell_solid);            % Get amount of solids
PMT_size = 20;                              % Detector size in pixels

%%  Loops
% 1) Image loop
if rad_loop == 1
    
    % Get radius upper and low limits (and specify step)
    rad_ulim = round((dy-25)/2);
    rad_step = 50;
    rad_llim = 50;
    
    % Pre-allocate storage variables for asumetry factor (AF) and centroid
    % angle radius for the 3 combined detectors (AR123)
    AF_store = zeros(rd, ceil((rad_ulim - rad_llim)/rad_step));
    AR123_store = cell(rd, ceil((rad_ulim - rad_llim)/rad_step));

    AF_index = 1;   % Index for storage variables in loop
    
    if compare_droplet_rad == 1
        jpeg_cell = jpeg_cell_droplet;
    elseif compare_solid_rad == 1
        jpeg_cell = jpeg_cell_solid;
    end

    for j=1:rad_step:rad_ulim-rad_llim      % Loop through radii
        
        % Get the pixel coordinates of the 3 detectors from radius and the
        % centre point of the image.
        [ E1_xy, E2_xy, E3_xy ] = r2xy( j, offset_xy );

        for i=1:rd                          % Loop through images

            [AF_store(i, AF_index), E123] = AsymetryFactor ...
                ( E1_xy, E2_xy, E3_xy, PMT_size, jpeg_cell{i} );
            [ A123, R123 ] = E123toPolar( E123 );
            AR123_store{i, AF_index} = [ A123, R123 ];

        end

        AF_index = AF_index + 1;

    end
    
    tri_fig = TriangleScatter(AR123_store, 1:rad_step:rad_ulim-rad_llim);

% 2) Image loop
elseif image_loop == 1
    
    
    
end

