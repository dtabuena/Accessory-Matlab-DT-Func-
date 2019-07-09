function [TcaResults ] = MultiRepTCA(Tensor, RankRange, Replicates,  TcaResults)
    if ~exist('Steps'); Steps = 1; end;
    
    AddCheck = exist('TcaResults');
    
  
    for Rank = RankRange
        disp(['Rank ' num2str(Rank) ' of ' num2str(RankRange)]);
        StartRep = 1;
        if AddCheck
            try
                StartRep = length( TcaResults.Ranks(Rank).Replicate ) +1
            end
        end
        for Rep = StartRep:Replicates
            disp(['Rep ' num2str(Rep) ' of ' num2str(Replicates)]);
            options.Display = false;
            tic;
            TcaResults.Ranks(Rank).Replicate(Rep).NNTF = ncp(Tensor , Rank , 'verbose' ,0);      % From https://github.com/kimjingu/nonnegfac-matlab/blob/master/ncp.m
            TcaResults.Ranks(Rank).Replicate(Rep).RunTime = toc;
        end
    end
end