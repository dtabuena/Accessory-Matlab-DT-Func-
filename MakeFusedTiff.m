
function [FuseRGB, CaDataRGBFu] = MakeFusedTiff(Still, CaData, ColorMin, ColorMax, ColorThresh)

    % Still = BackgroundImage (Grey Scale)
    % CaData = DFoF Data (Grey Scale)
    % ColorMin = Bottom of Color Scale DFoF Color 
    % ColorMax = Top of Color Scale DFoF Color 
    % ColorThresh = percentDF to start Coloring;
    % FuseRGB = and RGB matrix of tif values where under threshold is grey scale but above is colormapped.
    % CaDataRGBFu = an RGB matrix in the matlab 'movie' format ( use implay() );
        
    Still256 = uint8( 255 * ( (Still - min(Still(:)))  ./  ( max(Still(:)) -  min(Still(:)) ) ) );
    CaData256d3 =  uint8( 255 * (CaData - ColorMin ) ./  (ColorMax  -  ColorMin ) ) ;



    %

    CustMap = pmkmp(256 , 'CubicL');
    STA256d4= permute( CaData256d3 , [1,2,4,3]);
    %


    CaDataRGB = immovie(STA256d4, CustMap);
    %
    
    for i = 1:length(CaDataRGB)
        Logical = repmat(CaData(:,:,i) > ColorThresh, [1,1,3]); 
        CaDataRGBFu(i).cdata = repmat(Still256, [1,1,3]);
        CaDataRGBFu(i).cdata(Logical) = CaDataRGB(i).cdata(Logical);
        CaDataRGBFu(i).colormap =  CaDataRGB(i).colormap;
    end



    % implay(CaDataRGBFu)

    for i = 1:length(CaDataRGBFu)
        FuseRGB(:,:,:,i) = CaDataRGBFu(i).cdata;
    end
    
%     WriteTiffRGB(ImageData, 'TestRGB.ome.tif', 'H:\_Macros\In Vivo StimMatch\_SpontDetect');

end






