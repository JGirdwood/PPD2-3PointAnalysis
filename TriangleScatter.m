function [ scatter_fig ] = TriangleScatter( AR123_array, leg_labels )
%TRIANGLESCATTER Makes a scatter plot from AF data
%   outputs the figure object and uses AF data from multiple images of the 
%   same catagory (e.g. droplets). Radii is usd to make the legend only.
%
% Author:           Joseph Girdwood
% Affiliation:      University of Hertfordshire
% email:            j.girdwood@herts.ac.uk

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

[~, cl] = size(leg_labels);
name_store = cell(1, cl);
for i=1:cl
    name_store{i} = char(leg_labels(i));
end

legend(pax, name_store)

scatter_fig = fig;

end

