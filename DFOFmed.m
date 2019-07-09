function [dFoF,GlobalDF] = DFOFmed(CaTraceData)
    %%
%     TimeWindow = 20; % sec
%     FrameRate = 20; % hz
%     [CaVec, DimVec] = vectorizeTiff(CaTraceData);
    
    fZero = median(CaTraceData,3);
    
%     dFoFvec = (CaVec - MoveMin) ./MoveMin;
    dFoF  = (CaTraceData - fZero) ./fZero;
    GlobalDF = permute(mean(mean(CaTraceData,1),2), [3,2,1]);
%     plot(mean(dFoF,1))
%     [dFoF] = UnVectorizeTiff(dFoFvec, DimVec);
end