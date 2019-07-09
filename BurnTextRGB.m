function [BurntImage] = BurnTextRGBcl( RGBStack, CellText, upscale, TextPosition, Color, FontSize, PpM , FontName)
        
    AnchorPoint = 'TopLeft';
    
    AnchorPointY = 'Bottom';
    AnchorPointX = 'Left';
    
    
    if  round( TextPosition(1) ) == 1;    AnchorPointX = 'Right';    end;
    if round( TextPosition(2) ) == 0;    AnchorPointY = 'Top';      end;
    if (~exist('FontName')); FontName = 'Arial Bold'; end;
    
    AnchorPoint = [AnchorPointX AnchorPointY];
    
    
    if size(Color,1) == 1;   Color = repmat(Color,[size(RGBStack,4) ,1]); end;
    
    
        for FrameNum = 1:size(RGBStack,4)
            currFrame = RGBStack(:,:,:,FrameNum);
            
            FrameUP = imresize(  currFrame, upscale,'nearest');
            Label = char(CellText(FrameNum))
            pxlPos = TextPosition .* [size(FrameUP,2) size(FrameUP,1)];            
            FrameUPT = insertText(FrameUP, pxlPos , Label , 'TextColor', Color(FrameNum,:), 'BoxOpacity', 0 , 'Font', FontName  , 'FontSize' , FontSize .* upscale ,'AnchorPoint', AnchorPoint );
            BurntImage(:,:,:,FrameNum) = FrameUPT;

        end
    
        %% Scale Bar?
        if ( exist( 'PpM') && ~isempty(PpM) )
            MMs = 1;
            LineDim = [2 , PpM .* MMs];
            LinePosition = [0.70 0.05];

            pxlPosLine = LinePosition .* [size(FrameUP,2) size(FrameUP,1)];
            LineDimU = round(LineDim.*upscale);
            BurntImage([0:LineDimU(1)] + pxlPosLine(1) , [0:LineDimU(2)] + pxlPosLine(2),:,1) = 255;
        end
end