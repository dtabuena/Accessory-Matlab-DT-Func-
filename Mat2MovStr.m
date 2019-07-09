function [MovieStruct, Top, Bot] = Mat2MovStr(CaData, CMap, Clip)
    if ~exist('Clip')
        [Normalized, Top, Bot] = NormAndClip(CaData);
    else
        [Normalized, Top, Bot] = NormAndClip(CaData, Clip);
    end
    
    if size(Normalized,3) == 3
        CaData256d4 = Normalized;
    else        
        CaData256d4 = permute( Normalized , [1,2,4,3]);
    end
    
    MovieStruct = immovie( uint8(CaData256d4.*255), CMap);
    
end