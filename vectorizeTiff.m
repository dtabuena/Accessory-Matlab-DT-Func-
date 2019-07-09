function [Vectorize2D, DimVec] = vectorizeTiff(OrigMat)
    DimVec = [size(OrigMat,1) size(OrigMat,2) size(OrigMat,3)]; 
    Vectorize3D = reshape(OrigMat, 1, [],size(OrigMat,3));
    Vectorize2D = permute(Vectorize3D,[2,3,1]);
end