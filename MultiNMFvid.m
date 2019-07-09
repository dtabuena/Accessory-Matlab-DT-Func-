function [NMFResults, DimVec] = MultiNMFvid( Vid, kRange, Reps, NMFResults)
    [VidVec, DimVec] = ImgVectorize( Vid);
    figure(); hold on;
    for K = kRange
        disp(['K = ' num2str(K) ]);
        disp(['     ' num2str(kRange)]);        
        for R = 1:Reps
            
            
%             Check = exist('NMFResults') ...
%                 &&  isfield( NMFResults(K), 'Replicate') ...
%                 && isfield( NMFResults(K).Replicate(R) , 'H' ) ...
%                 && ~isempty(  NMFResults(K).Replicate(R).H);
%             if Check
%                 continue
%             end
%                 
                
                
            disp(['     ' 'R = ' num2str(R) ' of ' num2str(Reps) ]);      
            opt = statset('Display','Iter');
            
            try
                [Wvec, NMFResults(K).Replicate(R).H, NMFResults(K).Replicate(R).D] = nnmf( VidVec, K, 'options',opt);
                scatter(K,NMFResults(K).Replicate(R).D); drawnow update;
            end
            
            try
                NMFResults(K).Replicate(R).W = ImgUnVectorize(Wvec, [DimVec(1:2) K] );
                NMFResults(K).Replicate(R).Lambda = max( NMFResults(K).Replicate(R).W , [] , [1 2]);
                NMFResults(K).Replicate(R).LambdaH = max(NMFResults( K ).Replicate(R).H,[],2);
                NMFResults(K).Replicate(R).H = NMFResults(K).Replicate(R).H .* permute(NMFResults(K).Replicate(R).Lambda, [3 2 1]);  
                NMFResults(K).Replicate(R).W = NMFResults(K).Replicate(R).W ./ NMFResults(K).Replicate(R).Lambda;
            end
            
        end
    end
end