function [Montage] = makeMontage(Stack, Border, Ratio, BorderVal)
%     BorderVal = 0-1 (later converted to grayscale)

    numFrame = size(Stack,4);
    SubDim = CalcSubPlotSize( numFrame , Ratio)
    Bordered = uint8( ((ones( size(Stack) + ( [2,2,0,0] .* Border) )).*255 ).* BorderVal);
    OgHit = size( Stack,1);
    OgWid = size( Stack,2);
    Bordered( (Border+1 : (Border+OgHit)) , (Border+1 : (Border + OgWid)) ,:,:) = Stack(:,:,:,:);

    Width = size(Bordered,2);
    Height = size(Bordered,1);
    
    PosMap = reshape(1:prod(SubDim), [SubDim(2)  SubDim(1)])';
    Montage = uint8(ones( Height.*(SubDim(1)), Width.*(SubDim(2)), 3 ) .* 255  .* BorderVal );
    Ratio = size(Montage) ./ size(Bordered(:,:,:,1));
    
    for frameNum = 1:numFrame;
        [Row,Col] = find(PosMap == frameNum);
        a = ( (Col-1) * Width ) + 1;
        b = (Col*Width);
        c = ( (Row-1) * Height ) + 1;
        d = (Row*Height);
        
        LandingIdxX = ( ( (Col-1) * Width ) + 1 ):(Col*Width);
        LandingIdxY = ( ( (Row-1) * Height ) + 1 ):(Row*Height);
        Montage(  c:d,  a:b,:) = Bordered(:,:,:,frameNum);
    end
end
