function [ err_fig ] = PlotClassError( class_err_arr, rad_arr, size_arr )
%PLOTCLASSERROR Summary of this function goes here
%   Detailed explanation goes here

fig = figure;
ax = axes(fig);
contourf(ax, size_arr, rad_arr, class_err_arr)
contourcbar(ax)

err_fig = fig;

end

