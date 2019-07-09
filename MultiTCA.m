function [TcaResults ] = MultiTCA(Tensor, RankLimit, Replicates)
    for Rank = 1:RankLimit
        disp(['Rank ' num2str(Rank) ' of ' num2str(RankLimit)]);
        for Rep = 1:Replicates
            disp(['Rep ' num2str(Rep) ' of ' num2str(Replicates)]);
            options.Display = false;
            tic;
            [TcaResults.Ranks(Rank).Replicate(Rep).U, TcaResults.Ranks(Rank).Replicate(Rep).OUTPUT] = cpd( Tensor,  Rank, options);
            TcaResults.Ranks(Rank).Replicate(Rep).RunTime = toc;
        end
    end
end