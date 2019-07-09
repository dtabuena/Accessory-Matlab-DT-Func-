function [dFoF,GlobalDF] = DFOFmm(CaTraceData, TimeWindow, FrameRate)
    %%
%     TimeWindow = 80; % sec
%     FrameRate = 20; % hz
    
    MoveMin = movmin(CaTraceData, TimeWindow * FrameRate ,3);
    
    dFoF  = (CaTraceData - MoveMin) ./MoveMin;
    GlobalDF = permute(mean(mean(CaTraceData,1),2), [3,2,1]);
%     plot(mean(dFoF,1))
end