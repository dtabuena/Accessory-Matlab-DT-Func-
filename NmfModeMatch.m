function [NmfGroup] = NmfModeMatch( NmfGroup  )

%     Ranks = length( NmfGroup );
    Ranks = find(~cellfun(@isempty, {NmfGroup.Replicate} ));
    
    
    
    for rank = Ranks;
        Reps = length( NmfGroup(rank).Replicate );
        for rep = 1:Reps;
            [~, NmfGroup(rank).Best] = min( cell2mat({  NmfGroup(rank).Replicate.Err}));            
            Modes = size( NmfGroup(rank).Replicate(rep).H,1 );
            for mod = 1:Modes
                
                if length(size(NmfGroup(rank).Replicate(rep).W)) == 3;
                    NmfGroup(rank).Replicate(rep).Modes(mod).Recon = ImgVectorize(NmfGroup(rank).Replicate(rep).W(:,:,mod)) * NmfGroup(rank).Replicate(rep).H(mod,:);  
                else
                    NmfGroup(rank).Replicate(rep).Modes(mod).Recon = NmfGroup(rank).Replicate(rep).W(:,mod) * NmfGroup(rank).Replicate(rep).H(mod,:);
                end
                NmfGroup(rank).Replicate(rep).Modes(mod).ReconV = NmfGroup(rank).Replicate(rep).Modes(mod).Recon(:);
            end            
        end
        
        for rep = 1:Reps;
            A = cell2mat( {NmfGroup(rank).Replicate(  NmfGroup(rank).Best ).Modes.ReconV} );
            B = cell2mat( {NmfGroup(rank).Replicate(rep).Modes.ReconV} );
            NmfGroup(rank).Replicate(rep).Corrs = corr( A, B);
            [NmfGroup(rank).Replicate(rep).ModeMatch, NmfGroup(rank).Replicate(rep).BestModeCorrs] = FindModeMatch( NmfGroup(rank).Replicate(rep).Corrs );
        end
        
        
        subplot( 2,1,1)
        yValues = cell2mat( {NmfGroup(rank).Replicate.Err});
        ModXvals = rank + smartJitter(yValues, .05, 1); 
        scatter( ModXvals , yValues.^2); hold on;
        xlabel('Number of Components')
        ylabel('|Error| / |X|');
    
                
        subplot( 2,1,2)
        NotBest = ~(1:length(NmfGroup(rank).Replicate) == NmfGroup(rank).Best);
        yValues = cell2mat( {NmfGroup(rank).Replicate(NotBest).BestModeCorrs});
        ModXvals = rank + smartJitter(yValues, .01, 5); 
        scatter( ModXvals , yValues, 15, 'o'); hold on;
        Stats = prctile( yValues , [ 25, 50, 75]);            
        line(rank + [-.1 .1], Stats(2) .* [1 1] , 'Color','k' );
        line(rank .* [1 1], Stats([1 3]) ,'Color','k' );
        xlabel('Number of Components');
        ylabel('R^{2} of Modes');
    
    end
    
end