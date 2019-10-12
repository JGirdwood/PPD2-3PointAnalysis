function [ jpeg_cell ] = Importer( data_dir )
%IMPORTER imports jpegs in a folder to a cell for analysis
%   Each cell element of 'jpeg_cell' is intensity in arbitrary units, the
%   index is pixel number (X,Y). 'data_dir' is the directory containing the
%   jpegs to be analysed.
%
% Author:           Joseph Girdwood
% Affiliation:      University of Hertfordshire
% email:            j.girdwood@herts.ac.uk

%%  Find all the files with .jpg extension in the data directory
search_string = char([data_dir, '\*jpg']);
list = dir(search_string);
[files, ~] = size(list);    % Get number of fiels for loop
jpegs = cell(files, 1);     % Pre-allocate jpeg cell for speediness!

%%  Cycle thoguh files and extract data using imread
for i=1:files
    path = char([list(i).folder, '\', list(i).name]);
    intensity_au = imread(path);    % Read file
    jpegs{i, 1} = intensity_au;     % Assign file to array
end
jpeg_cell = jpegs;                  % Assign output from function

end


