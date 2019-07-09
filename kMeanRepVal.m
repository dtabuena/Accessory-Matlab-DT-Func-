function [Result ] = kMeanRepVal( X, K, REPS)
    figure()
for k = 1:K
%     clc; disp(['Modes: ' num2str(k)]);
    for rep = 1:REPS
%         disp(['     Rep: ' num2str(rep)]);
        [Result(k).Replicate(rep).Idx, Result(k).Replicate(rep).Mode,  Result(k).Replicate(rep).SUMD, Result(k).Replicate(rep).D] = kmeans(X, k);
        Result(k).Replicate(rep).MinD = sum( min( Result(k).Replicate(rep).D,[], 2));
    end
    
    % Similarity
    [~, BestRep] = min(cell2mat({Result(k).Replicate.MinD}));
    BestRep = BestRep(1);
    
    for rep = 1:REPS
        Result(k).Replicate(rep).ModeCorr = corr( Result(k).Replicate(rep).Mode', Result(k).Replicate(BestRep).Mode' );
%         Result(k).Replicate(rep).ModeCorr = Result(k).Replicate(rep).ModeCorr .* Result(k).Replicate(rep).ModeCorr';        

        [Bs,Is] = sort( Result(k).Replicate(rep).ModeCorr ,2,'descend');
        [~, Ix] = sort(Bs(:,1),1,'descend'); 
        Bss = Bs(Ix,:);
        Iss = Is(Ix,:);
        Match = [];
        for rows = 1:size(Iss,1)
            for cols = 1:size(Iss,2);
                check = ismember(Iss(rows,cols), Match); 
                if ~check
                    Match(rows) = Iss(rows,cols);
                    break
                end  
            end
        end
        Result(k).Replicate(rep).ModeMatch(Ix) = Match;      
        
        for row = 1:length(Result(k).Replicate(rep).ModeMatch(Ix))            
            Result(k).Replicate(rep).BestModeCorrs(row) = Result(k).Replicate(rep).ModeCorr(row, Result(k).Replicate(rep).ModeMatch(row) );
        end
        
%         [Result(k).Replicate(rep).BestModeCorrs, Result(k).Replicate(rep).ModeMatch] = max( ( Result(k).Replicate(rep).ModeCorr ),[],1);
        Result(k).Replicate(rep).MeanModeCorr = mean(Result(k).Replicate(rep).BestModeCorrs);
        
    end

    
    Result(k).Best = Result(k).Replicate(BestRep);
    
    
    JitSiz = .01;
    NumBins = 10;

    subplot(1,2, 1)
    minD = cell2mat({ Result(k).Replicate.MinD}) ./ max(cell2mat({ Result(1).Replicate.MinD})) ;
    scatter( k + smartJitter(minD, JitSiz,NumBins) , minD  ); hold on
    scatter(k, mean(minD), '+k');
    
    
    subplot(1,2, 2)
    MeanModeCorr = cell2mat({ Result(k).Replicate.MeanModeCorr});
    scatter( k + smartJitter(MeanModeCorr, JitSiz,NumBins) , MeanModeCorr ); hold on
    scatter(k, mean(MeanModeCorr), '+k');
    ylim( ylim().*[1, 0] + [0, 1] )
    
    
end
    
end
