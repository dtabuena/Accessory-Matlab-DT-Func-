function [WindowedMat, Window] = WindowVecs(DataMat, Window)
% Contructs a vector (PeekingPS) that is the powerspectrum of each window
% SpectProf = the spectral profile data package
% PeekTime = time window in sec to include in classification i.e. memory
    %%
    
    OrigHeight = size(DataMat,1);
    Padding = nan(OrigHeight, Window );    
    Padded = [Padding DataMat Padding];    
    ToShift = repmat( Padded, [Window.*2+1, 1]);    
    for i = -Window:Window
        Bloc = find(i == -Window:Window);
        ToShift( (OrigHeight*(Bloc-1))+1:OrigHeight*Bloc , : ) = circshift( ToShift( (OrigHeight*(Bloc-1))+1:OrigHeight*Bloc , : ), [0 i]);
    end
    WindowedMat = ToShift;
end