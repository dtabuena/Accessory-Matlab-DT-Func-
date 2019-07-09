function [Clipped, Top, Bot] = NormAndClip(Sig, Clip)
    % returns Sig Normalized between 0 and 1 with percentile cutoffs, 'Clip = [ low High] ' 
    if ~exist('Clip')
        Clip = [0 100];
    end

    Bot = prctile( Sig(:), Clip(1) );
    Top = prctile( Sig(:), Clip(2) );
    
    
    Normed = (Sig - Bot ) ./ (Top - Bot);
    

    
    Clipped = Normed;
    Clipped( Normed > 1) = 1;
    Clipped( Normed < 0) = 0;
  
end