

function [CaTraceData] = ReadWholeStackBin(FileLocName, BinSize)
    disp('Reading...')
    
    [FrameCount,Y,X] = StackSize(FileLocName);
    
    
    CaTrace = Tiff(FileLocName, 'r');
    i = currentDirectory(CaTrace);
%     disp(['     Frame ' num2str(i) '...']);
    CurrentFrame = single(read(CaTrace));
    BinnedFrame = BinStack(CurrentFrame, BinSize);
    CaTraceData = zeros(size(BinnedFrame,1),size(BinnedFrame,2),FrameCount);
    CaTraceData(:,:,i) = BinnedFrame;
    CheckEnd = lastDirectory(CaTrace);
    while CheckEnd == false
        nextDirectory(CaTrace);
        i = currentDirectory(CaTrace);
        clc;
        disp('Reading...')
        disp(['     Frame ' num2str(i) '...']);
        CurrentFrame = single(read(CaTrace));
        BinnedFrame = BinStackSum(CurrentFrame, BinSize);
        CaTraceData(:,:,i) = BinnedFrame;
        CheckEnd = lastDirectory(CaTrace);
    end
    close(CaTrace);
    CaTraceData = single(CaTraceData);
    disp('     Reading done.')
end


function [Mat3D] = ImgUnVectorize(Vectorized2D, DimVec)
    Vectorized3D = permute(Vectorized2D,[3,1,2]);
    Mat3D = reshape(Vectorized3D, DimVec(1), DimVec(2), DimVec(3));
end
