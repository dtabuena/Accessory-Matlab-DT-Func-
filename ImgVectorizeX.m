function [Vectorize2D, DimVec] = ImgVectorizeX(OrigMat)
%     OrigMat = Vgluts( Entry ).StimAnalysis( StimType ).StimStack;
    DimVec = size(OrigMat);
    DimVecM = [ 1, prod(DimVec(1:2)), DimVec(3:end)];
    Vectorize3D = reshape(OrigMat, DimVecM);
    Vectorize2D = permute(Vectorize3D, circshift(1:length(DimVecM),-1));
end