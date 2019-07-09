
function [MarkedCanvas] = ScrollSig(Signal, SignalRate, FrameRate , CanvasTime, ShadeTime,  CanvasSize, SigMaxPrct, CursorColor, Shade, zeroColor)
    %% Debug Var  
%     Signal = InVivoPup( Entry ).SignalMovie;
%     SignalRate = InVivoPup( Entry ).SampleRate;
%     FrameRate = InVivoPup( Entry ).FrameRate;
%     TimeWindow = 1;
%     CanvasSize = [[50, 240] .* upscale, length(InVivoPup( Entry ).MovieIdx)];
%     SigMaxPrct = 99.950;
%     CursorColor = [1 0 0];
%     Shade = .2;

    disp({['Vis: +/-' num2str(CanvasTime) 's'] ; ['Shade: +/-' num2str(ShadeTime) 's']});

    % Canvas Setup
    Canvas = zeros(  CanvasSize(1), CanvasSize(2), 3, CanvasSize(4) , 'uint8');
    ShadeLeng = round( CanvasSize(2)./2 ./ (CanvasTime ./ ShadeTime));
    Canvas(:, round( CanvasSize(2)./2) + [-ShadeLeng:ShadeLeng] , :, :) = 255.* Shade ;
    Canvas(:,round(CanvasSize(2)./2),1,:) = CursorColor(1) .* 255;
    Canvas(:,round(CanvasSize(2)./2),2,:) = CursorColor(2) .* 255;
    Canvas(:,round(CanvasSize(2)./2),3,:) = CursorColor(3) .* 255;
   
    
    
    % Normalize Signal
    GeneralSigInd = [(SignalRate.*-CanvasTime):(SignalRate.*CanvasTime)];
    [NormSig, Top, Bot] = NormAndClip(Signal, [100-SigMaxPrct SigMaxPrct]);
    
 
    if exist('zeroColor')
        h = CanvasSize(1)
        h0 = round( h.* (  Top ./ ( Top - Bot) ));
        Canvas(h0,:,1,:) = zeroColor(1) .* 255;
        Canvas(h0,:,2,:) = zeroColor(2) .* 255;
        Canvas(h0,:,3,:) = zeroColor(3) .* 255;
    end
        
    NullSig =  -Bot ./ (Top - Bot);
    
    
    

    % MarkCanvas
    for FN = 1:CanvasSize(4)
        FN
        CurTime = (FN - 1) ./ FrameRate;
        CurrSigInd = round( GeneralSigInd + (CurTime .* SignalRate) ,0);
        BadSamp =  (CurrSigInd <= 0 ) | (CurrSigInd > length(Signal));
        FrameSig = ones(size(CurrSigInd)) .* NullSig;
        FrameSig(~BadSamp) = NormSig( CurrSigInd(~BadSamp) );
        
        SigDownSample = ceil(CanvasSize(1) .* imresize( FrameSig , [1,CanvasSize(2)] , 'nearest' ) );
        
        Maxes = max(SigDownSample,[SigDownSample(2:end), SigDownSample(end)]);
        Mins = min(SigDownSample,[SigDownSample(2:end), SigDownSample(end)]);
        
        % Alternate MaxMin
            TopLine = movmax( FrameSig, ceil((SignalRate ./ (CanvasSize(2) ./ CanvasTime) ) .*2 ));
            BotLine = movmin( FrameSig, ceil((SignalRate ./ (CanvasSize(2) ./ CanvasTime) ) .*2 ));
            Maxes = ceil(CanvasSize(1) .*  imresize( TopLine , [1,CanvasSize(2)] , 'nearest' ));
            Mins = ceil(CanvasSize(1) .*  imresize( BotLine , [1,CanvasSize(2)] , 'nearest' ));
        
        [XpixInd,YpixInd] = meshgrid(1:CanvasSize(2),CanvasSize(1):-1:1);
        TableMaxes = repmat(Maxes,[CanvasSize(1),1]);
        TableMins = repmat(Mins,[CanvasSize(1),1]);
        CurPoints = (YpixInd <= TableMaxes) & (YpixInd >= TableMins);
        BigLogical(:,:,:,FN) = repmat(CurPoints,[1,1,3,1]);
    end
    MarkedCanvas = Canvas;
    MarkedCanvas(BigLogical) = 255;
   
   
end
