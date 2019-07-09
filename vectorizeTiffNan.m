function [Vectorize2D, DimVec, NanVec] = vectorizeTiffNan(OrigMat)

    DimVec = [size(OrigMat,1) size(OrigMat,2) size(OrigMat,3)];   
    Vectorize3D = reshape(OrigMat, 1, [],size(OrigMat,3));
    
    Vectorize2Dnan = permute(Vectorize3D,[2,3,1]);
    NanVec = isnan( Vectorize2Dnan(:,1) );
    Vectorize2D = Vectorize2Dnan( ~NanVec ,: );
    
    
end