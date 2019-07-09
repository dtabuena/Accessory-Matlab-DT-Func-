function [Mat3D] = UnVectorizeTiffNan(Vectorized2D, DimVec, NanVec)
    
    if ~exist('NanVec')
        NanVec = logical( ones( DimVec(1) .*  DimVec(2) , 1 ));
    end



    Vectorized2Dnan = nan(DimVec(1).*DimVec(2), DimVec(3));
    Vectorized2Dnan(~NanVec,:) = Vectorized2D;

    Vectorized3D = permute(Vectorized2Dnan,[3,1,2]);
    Mat3D = reshape(Vectorized3D, DimVec(1), DimVec(2), DimVec(3));
    
end
