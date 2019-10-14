function [ err_fig ] = PlotClassError( class_err_arr )
%PLOTCLASSERROR Summary of this function goes here
%   Detailed explanation goes here

fig = figure;
ax = axes(fig);
contourf(ax, class_err_arr)

err_fig = fig;

end

