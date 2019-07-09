function [Mat3D] = ImgUnVectorize(Vectorized2D, DimVec)
    Vectorized3D = permute(Vectorized2D,[3,1,2]);
    Mat3D = reshape(Vectorized3D, DimVec(1), DimVec(2), DimVec(3));
end
