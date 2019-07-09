function [Vectorized2D, DimVec] = ImgVectorizeRGB(OrigMat)
    DimVec = [size(OrigMat,1) size(OrigMat,2) size(OrigMat,3) size(OrigMat,4)]; 
    Vectorize3D = reshape(OrigMat, 1, [],size(OrigMat,4));
    Vectorized2D = permute(Vectorize3D,[2,3,1]);
end