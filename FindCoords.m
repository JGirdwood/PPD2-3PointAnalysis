%close, clear, clc

%jpeg_cell_au = Importer('C:\Users\jg17acv\Documents\DevelopmentEngineer\UH-PPD-LC\PPD2\SID3-PPD2\NetworkTest\[150091716]');
[py, px] = size(jpeg_cell_au{1});
offset_xy = [round(px/2), round(py/2)];
[ E1_xy, E2_xy, E3_xy ] = r2xy( 200, offset_xy );
[r, ~] = size(jpeg_cell_au);
PMT_size = 20;
AF_store = zeros(r, 1);
for i=1:r
    AF_store(i) = AsymetryFactor ...
        ( E1_xy, E2_xy, E3_xy, PMT_size, jpeg_cell_au{i} );
end

