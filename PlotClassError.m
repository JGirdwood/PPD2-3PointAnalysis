function [ err_fig ] = PlotClassError( class_err_arr, rad_arr, size_arr )
%PLOTCLASSERROR Makes a surface plot of class error
%   Y axis of the plot is radius, and the X axis is detector size. Specify
%   the error array with class_err_arr along with two coordinates vectors
%   for radius and size.
%
% Author:           Joseph Girdwood
% Affiliation:      University of Hertfordshire
% email:            j.girdwood@herts.ac.uk

fig = figure;
ax = axes(fig);
contourf(ax, size_arr, rad_arr, class_err_arr);
contourcbar(ax);

xlabel(ax, 'Detector Size (mm)');
ylabel(ax, 'Detector Radius (mm)');
title(ax, 'Misclassification Error (MCE) With Detector Size and Radius');

err_fig = fig;

end

