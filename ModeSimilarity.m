function [Replicate] = ModeSimilarity( Replicate )

% Replicate = Vgluts( Entry ).StimAnalysis( StimType ).TcaResults.Ranks( 7 ).Replicate;
% 
%%
Rank = size(  Replicate(1).NNTF.U{1, 1},2);
for Rep = 1:length(Replicate)
    disp(['Rank:' num2str(Rank) ' Rep:' num2str(Rep)]);
    for Comp = 1:Rank
        Dims = size( Replicate(Rep).NNTF );
        SpatialVec = single( Replicate(Rep).NNTF.U{1, 1}(:,Comp) );
        Temporal = single(  Replicate(Rep).NNTF.U{2, 1}(:,Comp) );
        State = single(  Replicate(Rep).NNTF.U{3, 1}(:,Comp) );
        Lambda = single(  Replicate(Rep).NNTF.lambda(Comp) );
        
        
        Pct = 0.1; Step = round( 1./ (Pct./100) );
        SpatialVecDS = SpatialVec(1:Step:end);
      	Dims(1) = length( SpatialVecDS );
        
        A = repmat( permute( SpatialVecDS, [1,2,3]), [1, Dims(2), Dims(3)]);
        B = repmat( permute( Temporal, [2,1,3]), [Dims(1), 1, Dims(3)]);
        C = repmat( permute( State, [2,3,1]), [Dims(1), Dims(2), 1]);
        Replicate(Rep).Component(Comp).CompositeVec = reshape( A .* B .* C.* Lambda, 1,[]);
                
        Replicate(Rep).Component(Comp).CompositeVec = Replicate(Rep).Component(Comp).CompositeVec;
    end
end
%%
[~, BestFit] = min( cell2mat( {Replicate.Err}));    
% BestCompVec = cell2mat( {Replicate(BestFit).Component.CompositeVec}) ;  
for Rep = 1:length(Replicate)    
    for CompBest = 1:length(Replicate(BestFit).Component)
        for CompTest = 1:length(Replicate(Rep).Component)
            Replicate(Rep).CorrMat(CompBest, CompTest) = corr( Replicate(BestFit).Component(CompBest).CompositeVec' ,  Replicate(Rep).Component(CompTest).CompositeVec');
        end
    end

end
% 
% figure('Name', num2str(Rank), 'Position', [1, 1, 4.5, 1.5] .* 300)
for Rep = 1:length(Replicate)    
    [Replicate(Rep).ModeMatch, Replicate(Rep).BestModeCorrs] = FindModeMatch( Replicate(Rep).CorrMat );

%     % Optional Plot
%     subplot(1,length(Replicate),Rep); hold on;
%     imagesc( Replicate(Rep).CorrMat ); colorbar(); pbaspect([1 1 1]); 
%     scatter(Replicate(Rep).ModeMatch, 1:length(Replicate(Rep).ModeMatch), 30, 'k' );
%     drawnow update;

end

try Replicate = rmfield(Replicate, 'Component'); end
    
end