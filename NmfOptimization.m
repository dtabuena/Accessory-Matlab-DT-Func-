function [NMFResults] = NmfOptimization( NMFResults , Original)
	kRange = find(~cellfun(@isempty, {NMFResults.Replicate} ));
    figure();
    for kIter = kRange
        numReps = length( NMFResults(kIter).Replicate )
        % Simple Error;
        for Rep = 1:numReps
            NMFResults(kIter).Replicate(Rep).Recon = ImgVectorize( NMFResults(kIter).Replicate(Rep).W ) * NMFResults(kIter).Replicate(Rep).H ;
            NMFResults(kIter).Replicate(Rep).Err = norm(Original(:)-NMFResults(kIter).Replicate(Rep).Recon(:) , 'fro') ./ norm(Original(:) , 'fro');
        end
        
        [~, BestRep] = min(cell2mat({NMFResults(kIter).Replicate.Err}));
        
        % Fit Var
        for Rep = 1:numReps
            NMFResults(kIter).Replicate(Rep).CorBest = corr2( NMFResults(kIter).Replicate(Rep).Recon(:), NMFResults(kIter).Replicate(BestRep).Recon(:));
%             NMFResults(kIter).Replicate(Rep).CorBest = (NMFResults(kIter).Replicate(Rep).CorBest(2,1);
        end
        
%           

        for Rep = 1:numReps        
            subplot(1,2,1); hold on;
            yVals =cell2mat({NMFResults(kIter).Replicate.Err}); 
            xVals = smartJitter( yVals  , .1, 5)
            scatter( kIter + xVals, yVals);
            ylim([0, 1]);
            
            subplot(1,2,2); hold on;
            yVals =cell2mat({NMFResults(kIter).Replicate.CorBest}); 
            xVals = smartJitter( yVals  , .1, 5)
            scatter( kIter + xVals, yVals);
            ylim([0, 1]);
        end
        
        
        % Clear Recon
        for Rep = 1:numReps
            NMFResults(kIter).Replicate(Rep).Recon = [];
        end
        drawnow update
        
    end