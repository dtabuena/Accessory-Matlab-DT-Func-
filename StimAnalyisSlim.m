function [ A ] = StimAnalyisSlim( A )

    for StimType = 1:length( A)
        for R = 1:length( A( StimType ).TcaResults.Ranks )
            for Rep = 1:length( A( StimType ).TcaResults.Ranks( R ).Replicate )
                 try
                     A( StimType ).TcaResults.Ranks( R ).Replicate = rmfield(A( StimType ).TcaResults.Ranks( R ).Replicate, 'Component');
                 end
                 try
                     A( StimType ).TcaResults.Ranks( R ).Replicate = rmfield(A( StimType ).TcaResults.Ranks( R ).Replicate, 'Recon');
                 end
            end
        end
    end
end