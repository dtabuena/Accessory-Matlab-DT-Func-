function [Edges] = SharpEdge( Binary )
    Edgy = fliplr(flipud(filter2(Binary,ones(3),'full')))/9;
    Edges = Edgy(2:end-1,2:end-1) < 1 & Binary;
end
