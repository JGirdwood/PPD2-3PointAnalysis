%close, clear, clc

jpeg_cell_au = Importer('C:\Users\jg17acv\Documents\DevelopmentEngineer\UH-PPD-LC\PPD2\SID3-PPD2\NetworkTest\[150091716]');

[py, px] = size(jpeg_cell_au{1});
offset_xy = [round(px/2), round(py/2)];
[r, ~] = size(jpeg_cell_au);
PMT_size = 20;

rad_ulim = round((py-25)/2);
rad_llim = 50;

AF_store = zeros(r, rad_ulim - rad_llim);
AR123_store = cell(r, rad_ulim - rad_llim);

AF_index = 1;
for j=1:rad_ulim-rad_llim
    
    [ E1_xy, E2_xy, E3_xy ] = r2xy( j, offset_xy );
    
    for i=1:r
        
        [AF_store(i, AF_index), E123] = AsymetryFactor ...
            ( E1_xy, E2_xy, E3_xy, PMT_size, jpeg_cell_au{i} );
         [ A123, R123 ] = E123toPolar( E123 );
         AR123_store{i, AF_index} = [ A123, R123 ];
        
    end
    
    AF_index = AF_index + 1;
    
end
