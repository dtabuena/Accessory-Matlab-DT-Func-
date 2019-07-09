function [TcaResults] = ModelSimilarity(TcaResults)

    %%
    
%     TcaResults = Vgluts( Entry ).StimAnalysis( StimType ).TcaResults;
    
%     for n = 
    for Rank = 1:length(TcaResults.Ranks)
        try            
            [~,sourceRep] = min( cell2mat({TcaResults.Ranks(Rank).Replicate.Err}) );
            Rank
            for Rep = 1:length( TcaResults.Ranks( Rank ).Replicate )
                TcaResults.Ranks( Rank ).Replicate(Rep).Rval = corr(  TcaResults.Ranks(Rank).Replicate(sourceRep).Recon(:) ,   TcaResults.Ranks(Rank).Replicate(Rep).Recon(:) );
            end
        end
    end
    

    
end
