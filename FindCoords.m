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
close, clear, clc           % blank slate
error = false;              % Error indicator, set to false at beginning

% Parameter for choosing loop: 0 if radius, 1 if image, 2 if class error
loop = 2;

% Parameters for choosing radii
compare_droplet_rad = 1;    % Compare radii of drops or solids
compare_solid_rad = 1 - compare_droplet_rad;
radius_step = 50;           % Step in radius for loopiness

% Parameters for the image loop
particle_types = 2;         % Number of different particle types

% Parameters for the class error loop
PMT_size_min = 10;          % Min PMT size in pixels
PMT_size_max = 150;         % Max PMT size in pixels
PMT_size_step = 10;         % Step in PMT size loop in pixels

% Parameters for the camera area
PMT_size = 70;              % Detector size in pixels (default)
image_radius = 279;         % Radius of image in pixels
beamstop_radius = 50;       % Radius of centre beamstop in pixels
default_radius = 150;       % Radius for the image loop

% ********Specify cm to pixel conversions here when known********

% Specify the file paths for various different aerosol types (droplet and
% solid defined). 
droplet_path = 'C:\Users\jg17acv\Documents\DevelopmentEngineer\UH-PPD-LC\PPD2-sorted\Droplets';
solid_path = 'C:\Users\jg17acv\Documents\DevelopmentEngineer\UH-PPD-LC\PPD2-sorted\Unclassified-Solid';

% Set to true if plots are needed
plot = false;

% Variables for the classification of particles
AF_droplet = 20;            % Below this AF, particle is droplet
AF_solid = 20;              % Above this AF, particle is solid
AF_scale = 1/1800;          % Scaling factor in AF calculation

%%  Pre-Loop computation
jpeg_cell_droplet = Importer(droplet_path); % Import droplet images
jpeg_cell_solid = Importer(solid_path);     % Import solid images

[dy, dx] = size(jpeg_cell_droplet{1});      % Get image size pixels
offset_xy = [round(dx/2), round(dy/2)];     % Get image centre pixels
[rd, ~] = size(jpeg_cell_droplet);          % Get amount of droplets
[rs, ~] = size(jpeg_cell_solid);            % Get amount of solids

% Ensure number of images is equal for fair comparison
if rd ~= rs
    loop = -1;
    error = true;
end

%%  Loops
% 1) Image loop
if loop == 0
    
    % Get radius upper and low limits (and specify step)
    rad_ulim = image_radius;
    rad_step = radius_step;
    rad_llim = beamstop_radius;
    
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
                ( E1_xy, E2_xy, E3_xy, PMT_size, jpeg_cell{i}, AF_scale );
            [ A123, R123 ] = E123toPolar( E123 );
            AR123_store{i, AF_index} = [ A123, R123 ];

        end

        AF_index = AF_index + 1;

    end
    
    if plot == true
        tri_fig = TriangleScatter(AR123_store, 1:rad_step:rad_ulim-rad_llim);
    end

% 2) Image loop
elseif loop == 1
    
    fixed_rad = default_radius;
    num_types = particle_types;
    [ E1_xy, E2_xy, E3_xy ] = r2xy( fixed_rad, offset_xy );
    
    % Pre-allocate storage variables for asymetry factor (AF) and centroid
    % angle radius for the 3 combined detectors (AR123)
    AF_store = zeros(rd, num_types);
    AR123_store = cell(rd, num_types);
    
    jpeg_cell = {jpeg_cell_droplet, jpeg_cell_solid};
    
    for j=1:num_types
        
        for i=1:rd
            
            [AF_store(i, j), E123] = AsymetryFactor ...
                ( E1_xy, E2_xy, E3_xy, PMT_size, jpeg_cell{j}{i}, AF_scale );
            [ A123, R123 ] = E123toPolar( E123 );
            AR123_store{i, j} = [ A123, R123 ];
            
        end
        
    end
    
    if plot == true
        tri_fig = TriangleScatter(AR123_store, {'Droplets', 'Solids'});
    end
    
    class_store = cell(1, num_types);
    class_store{1, 1} = AF_store(:, 1) > AF_droplet;
    class_store{1, 2} = AF_store(:, 2) < AF_solid;
    
    percent_error_droplet = sum(class_store{1, 1})/rd*100;
    percent_error_solid = sum(class_store{1, 2})/rd*100;

% 3) Classification error loop and plotting
elseif loop == 2
    
    % Get radius upper and low limits (and specify step)
    rad_ulim = image_radius;
    rad_step = radius_step;
    rad_llim = beamstop_radius;
    
    % Get PMT size upper and low limits (and specify step)
    size_ulim = PMT_size_max;
    size_llim = PMT_size_min;
    size_step = PMT_size_step;
    
    num_types = particle_types;
    
    % Pre-allocate storage variables for asymetry factor (AF) and centroid
    % angle radius for the 3 combined detectors (AR123)
    AF_store = zeros(rd, ceil((rad_ulim - rad_llim)/rad_step), ...
        ceil((size_ulim - size_llim)/size_step), num_types);
    AR123_store = cell(rd, ceil((rad_ulim - rad_llim)/rad_step), ...
        ceil((size_ulim - size_llim)/size_step), num_types);

    AF_index_rad = 1;       % Index for storage variables in loop
    AF_index_size = 1;
    
    jpeg_cell = {jpeg_cell_droplet, jpeg_cell_solid};
    
    for l=1:rad_step:rad_ulim-rad_llim
        
        [ E1_xy, E2_xy, E3_xy ] = r2xy( l, offset_xy );
        
        for k=1:size_step:size_ulim-size_llim
            
            for j=1:rd
                
                for i=1:num_types
                    
                    [AF_store(j, l, k, i), E123] = AsymetryFactor ...
                        ( E1_xy, E2_xy, E3_xy, k, jpeg_cell{i}{j}, AF_scale );
                    [ A123, R123 ] = E123toPolar( E123 );
                    AR123_store{j, l, k, i} = [ A123, R123 ];
                    
                end
                
            end
            
            AF_index_size = AF_index_size + 1;
            
        end
        
        AF_index_rad = AF_index_rad + 1;
        
    end
    
end

if error == true
    "Errors were encountered";
end























