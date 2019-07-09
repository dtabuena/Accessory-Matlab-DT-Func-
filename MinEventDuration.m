function [SignalFilt] = MinEventDuration( Signal, Rate, Duration)

    % Zero out events shorter than [Duration] seconds
    
    DifSig= [Signal(1) diff(Signal)];

    TrigUp = find( DifSig == 1);
    TrigDown = find( DifSig == -1);
    
    CorLen = min( length(TrigDown ), length(TrigUp ) )
    TrigUp = TrigUp(1:CorLen);
    TrigDown = TrigDown(1:CorLen);
    
    
    Dur = TrigDown(1:length(TrigUp)) - TrigUp;
    DurLog = Dur < Rate .* Duration;
    
    SigRow = 1:length(Signal);
    GridSig = single( SigRow > TrigUp' & SigRow < TrigDown' );


    GridSig(DurLog,:) =  GridSig(DurLog,:) .* -1 ;


    SignalFilt = sum( GridSig(~DurLog,:) ,1) > 0;

    
%     figure(); clf;
%     imagesc(GridSig);
%     figure(); clf;
%     plot(SignalFilt)
end