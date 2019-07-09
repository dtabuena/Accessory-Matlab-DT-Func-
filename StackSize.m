function [FrameCount,Y,X] = StackSize(FileLocName)

    CaTrace = Tiff(FileLocName, 'r');
    FrameOne = read(CaTrace);
    X = size(FrameOne,2);
    Y = size(FrameOne,1);
    
    
    CheckEnd = false;
    while CheckEnd == false
        nextDirectory(CaTrace);
        FrameCount = currentDirectory(CaTrace);
        CheckEnd = lastDirectory(CaTrace);
    end
    close(CaTrace);
end