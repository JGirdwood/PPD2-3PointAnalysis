function [ scatter_fig ] = TriangleScatter( AR123_array, leg_labels )
%TRIANGLESCATTER Makes a scatter plot from AF data
%   outputs the figure object and uses AF data from multiple images of the 
%   same catagory (e.g. droplets). leg_labels are the legend labels.
%
% Author:           Joseph Girdwood
% Affiliation:      University of Hertfordshire
% email:            j.girdwood@herts.ac.uk

[r, c] = size(AR123_array);
fig = figure;
pax = polaraxes(fig);
AR123_arr_store = zeros(r, 2);

for i=1:c
    
    for j=1:r
        AR123_arr_store(j, 1) = AR123_array{j, i}(1);
        AR123_arr_store(j, 2) = AR123_array{j, i}(2);
    end
    
    funky_colour = rand(1, 3);
    marker_size = 30;

    Pscat(c) = polarscatter(pax, AR123_arr_store(:, 1), ...
        AR123_arr_store(:, 2), marker_size, funky_colour, 'x');
    hold on

end

[~, cl] = size(leg_labels);
name_store = cell(1, cl);
for i=1:cl
    name_store{i} = char(leg_labels(i));
end

legend(pax, name_store)

scatter_fig = fig;

end

