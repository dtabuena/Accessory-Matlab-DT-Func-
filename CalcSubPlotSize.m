function [SubDim] = CalcSubPlotSize(NumEntries, Ratio)
    if ~exist('Ratio')
        Ratio = [1 1];
    end
    
%     clear A
    A.NumEntries = NumEntries;
    A.Ratio = Ratio;
       
    A.InitSubDim(1) = sqrt(A.NumEntries .* (A.Ratio(1) ./ A.Ratio(2)));
    A.InitSubDim(2) = A.InitSubDim(1) * (A.Ratio(2) ./ A.Ratio(1));
    A.BigSubDim = ceil(A.InitSubDim);
    A.BigSize = prod(A.BigSubDim);
    A.ManySize(:,1) = A.BigSubDim;
    A.ManySize(:,2) = A.BigSubDim - [0 1];
    A.ManySize(:,3) = A.BigSubDim - [1 0];
    A.ManySize(:,4) = A.BigSubDim - [1 1];
    A.Sizes = prod(A.ManySize,1);
    A.Delta = A.Sizes - A.NumEntries;
    A.Pick = min(A.Delta(A.Delta >= 0));
    A.Final = A.ManySize(:,(A.Delta == A.Pick))';
    SubDim = A.Final;

end


%%
%     if A.BigSize>A.NumEntries
%         A.Delta = A.BigSize - A.NumEntries;
%         A.MinusDelta = A.BigSubDim - A.Delta;
%         A.Greater = A.MinusDelta(A.MinusDelta>0);
%         A.MinusDeltaN = A.MinusDelta == A.Greater;
%         A.SubDim = A.BigSubDim - A.MinusDeltaN;
%     else
%         A.SubDim = A.BigSubDim;
%     end
%     
%     SubDim = A.SubDim;