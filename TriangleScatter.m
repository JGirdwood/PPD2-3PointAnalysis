function [ scatter_fig ] = TriangleScatter( AR123_array )
%TRIANGLESCATTER Makes a scatter plot from AF data
%   outputs the figure object and uses AF data from multiple images of the 
%   same catagory (e.g. droplets).

[r, c] = size(AR123_array);
fig = figure;
pax = polaraxes(fig);
for i=1:c
    funky_colour = rand(1, 3);
    marker_size = 30;
    for j=1:r
        polarscatter(pax, AR123_array{j, i}(1), AR123_array{j, i}(2), ...
            marker_size, funky_colour, 'x');
        hold on
    end
end

scatter_fig = fig;

end

