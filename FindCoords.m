close, clear, clc

jpeg_cell_au = Importer('C:\Users\jg17acv\Documents\DevelopmentEngineer\UH-PPD-LC\PPD2\SID3-PPD2\NetworkTest\[150091716]');
[ E1_xy, E2_xy, E3_xy ] = r2xy( 200 );
[r, ~] = size(jpeg_cell_au);
PMT_size = 20;
for i=1:r
    AF = AsymetryFactor( E1_xy, E2_xy, E3_xy, PMT_size, jpeg_cell_au{i} );
end

