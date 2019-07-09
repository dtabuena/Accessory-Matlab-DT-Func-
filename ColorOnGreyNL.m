function [FusedImage] = ColorOnGreyNL(GreyImage, IntensityData, ColorThresh, ColorMapping, MaxIntensity)
    
    if ~exist('MaxIntensity')
        MaxIntensity = max(IntensityData(:))
    end
    Scale = [ColorThresh MaxIntensity];
    IntensityData256 =  uint8( 255 * ( (IntensityData - ColorThresh) ./  ( MaxIntensity -  ColorThresh) ) );
    %%
    disp('ExpandGrey');
    RepGrey = permute( repmat( uint8(GreyImage), [1,1, size( IntensityData,3 ) ,3 ]), [1,2,4,3]);
    disp('ExpandIntensity');
    IntensityData4 = permute( IntensityData, [1,2,4,3]);
    UnderCut = IntensityData4 < ColorThresh;

    FusedImage = nan( [size( IntensityData,1 ),size( IntensityData,2),3,size( IntensityData,3 )]);
    
    disp('red')
    FusedImage(:,:,:,1) =  ( reshape( ColorMapping(IntensityData256+1,1), size(IntensityData)) );
    disp('green')
    FusedImage(:,:,:,2) =  ( reshape( ColorMapping(IntensityData256+1,2), size(IntensityData)) );
    disp('blue')
    FusedImage(:,:,:,3) =  ( reshape( ColorMapping(IntensityData256+1,3), size(IntensityData)) );
    %%    
    FusedImage(UnderCut) = RepGrey(UnderCut);
    implay(FusedImate,100);
end