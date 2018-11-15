function notes2freq(song_file)

 fid =  fopen(song_file,'r');
 a =  fscanf(fid,'%s');
name_ext_cell = strsplit(song_file, '.');
%make filename string with coe extension
filename = sprintf('%s.keymap', string(name_ext_cell(1)));

%fid = fopen(filename,'wt');


for i = 1 : size(a,2)
    
    switch(a(i))
        
        case 'A'
            dlmwrite(filename,0,'-append');
        case 'B'
            dlmwrite(filename,2,'-append');
        case 'C'
                    dlmwrite(filename,3,'-append');
        case 'D'
                dlmwrite(filename,5,'-append');
        case 'E'
                   dlmwrite(filename,7,'-append');
        case 'F'
             dlmwrite(filename,8,'-append');
        case 'G'
            dlmwrite(filename,10,'-append');
        case 'b'
            sprintf('note %d is a flat',i-1)
          
    end
    
    
end

end


% 
% 	 0: clkdivider = 9'd511;//A
% 	 1: clkdivider = 9'd482;// A#/Bb
% 	 2: clkdivider = 9'd455;//B
% 	 3: clkdivider = 9'd430;//C
% 	 4: clkdivider = 9'd405;// C#/Db
% 	 5: clkdivider = 9'd383;//D
% 	 6: clkdivider = 9'd361;// D#/Eb
% 	 7: clkdivider = 9'd341;//E
% 	 8: clkdivider = 9'd322;//F
% 	 9: clkdivider = 9'd303;// F#/Gb
% 	10: clkdivider = 9'd286;//G
% 	11: clkdivider = 9'd270;// G#/Ab