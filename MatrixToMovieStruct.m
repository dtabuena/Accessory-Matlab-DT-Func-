function [MovieStruct] = MatrixToMovieStruct(CaData, ColorMin, ColorMax, ColorThresh)


    % Still = BackgroundImage (Grey Scale)
    % CaData = DFoF Data (Grey Scale)
    % ColorMin = Bottom of Color Scale DFoF Color 
    % ColorMax = Top of Color Scale DFoF Color 
    % ColorThresh = percentDF to start Coloring;
    % FuseRGB = and RGB matrix of tif values where under threshold is grey scale but above is colormapped.
    % CaDataRGBFu = an RGB matrix in the matlab 'movie' format ( use implay() );
        
    CaData256d3 =  uint8( 255 * (CaData - ColorMin ) ./  (ColorMax  -  ColorMin ) ) ;

    CustMap = pmkmp(256 , 'CubicL');
    CaData256d4= permute( CaData256d3 , [1,2,4,3]);

    MovieStruct = immovie(CaData256d4, CustMap);

end






