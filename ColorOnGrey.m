function [FusedImage, Scale] = ColorOnGrey(GreyImage, IntensityData, ColorThresh, ColorMapping, MaxIntensity)
    % Combines a single greyscale frame with one or more thresholded color
    % mapped inensity while presierving 256 bit depth for both the grey and
    % colored images. To display or save single images or frames use
    % imwrite()/imshow(). To save avi's requires immovie() using additional
    % processing.

        % GreyImage: A background m*n image;
        % IntensityData: A 'm*n(*t)' insensity image trace;
        % ColorThresh: a value at which to cut off low intensity.
        %    eg: ColorThresh = 0.10; % Pixels where Intensity Data < 0.10 will show the reference image only
        %     or:  ColorThresh = 'prctile(IntensityData(:),10)' to clip to theshold the colormapping to +10%
        % ColorMapping: a 256*3 RGB color map
        % MaxIntensity: a cap on the color mapping

    if ~exist('MaxIntensity')
        MaxIntensity = max(IntensityData(:))
    end
     
    Scale = [ColorThresh MaxIntensity];
    
    frameNums = size(IntensityData,3);
    
    
    if size(GreyImage,3) == 1;
        GreyImage256 = uint8( 255 * ( (GreyImage - min(GreyImage(:)))  ./  ( max(GreyImage(:)) -  min(GreyImage(:)) ) ) );
        GreyImage256 = repmat(GreyImage256,[1,1,frameNums]);
    else
        GreyImage256 = uint8( 255 * GreyImage);
    end
        
    IntensityData256 =  uint8( 255 * ( (IntensityData - ColorThresh) ./  ( MaxIntensity -  ColorThresh) ) ) ;
    
    ColorLogical = IntensityData >= ColorThresh;
    
    for n = 1:frameNums
        clc;
        disp(['Frame: ' num2str(n)])
        ColorFrame = uint8(255.*ind2rgb(IntensityData256(:,:,n),ColorMapping));
        GreyFrame = repmat(GreyImage256(:,:,n), [1,1,3]);
        ColorLogical = repmat( (IntensityData(:,:,n) > ColorThresh) ,[1,3]);
        FuseFrame = GreyFrame;
        FuseFrame(ColorLogical == 1) = ColorFrame(ColorLogical == 1);
        FusedImage(:,:,:,n) = FuseFrame;
    end
    
end