function [ err_fig ] = PlotClassError( class_err_arr, rad_arr, size_arr )
%PLOTCLASSERROR Makes a surface plot of class error
%   Y axis of the plot is radius, and the X axis is detector size. Specify
%   the error array with class_err_arr along with two coordinates vectors
%   for radius and size.

fig = figure;
ax = axes(fig);
contourf(ax, size_arr, rad_arr, class_err_arr)
contourcbar(ax)

err_fig = fig;

end

