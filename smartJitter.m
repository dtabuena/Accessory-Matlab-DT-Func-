function [xVals] = smartJitter(Yvals, JitSiz,NumBins)
    % [xVals] = smartJitter(Yvals, MaxJit,NumBins)
    
    Ns = isnan(Yvals);
    Nandex = find(~Ns);
    Yvals = Yvals(~Ns);
    
    
    binEdges = linspace(min(Yvals), max(Yvals), NumBins+1);
    [dotHist, ~ ,binLoc] = histcounts(Yvals,binEdges);
    xVals = zeros(size(Yvals));
    OcNum = [];

    for n = 1:length(binLoc)        
        OcNum(n) = sum((binLoc(n) == binLoc(1:n) ));
        OcMax(n) = dotHist(binLoc(n));
    end
    
    OcNum;
    OcMax;
    OcNumNormish = (OcNum );
    OcNumNormSign = OcNumNormish;
    OcNumNormSign(mod(OcNum,2) == 1) = -(OcNumNormish(mod(OcNum,2) == 1) - 1);
    
    OcNumNormSign(mod(OcMax,2)==0) = OcNumNormSign(mod(OcMax,2)==0) - .5;
    OcNumNormF = ( (OcNumNormSign) ./ (max(OcNumNormSign)) );
    
%     xVals = OcNumNormF .* MaxJit;
    xVals = OcNumNormSign .* JitSiz;
    
    xValsNan = nan(size(Ns));xValsNan(Nandex) = xVals;

    xVals = xValsNan;
end
    
