function [SpatialSim, TemporalSim, StateSim, CompositeSim] = ComponentSimilarity(Replicate)
    
    Spatials=[];
    Temporal=[];
    State=[];
    Composite=[];
    Rank = size(  Replicate(1).NNTF.U{1, 1},2);
    NumRep = length(Replicate);
    Spatials = nan(Rank,Rank,NumRep);
    Temporal = nan(Rank,Rank,NumRep);
    State = nan(Rank,Rank,NumRep);
    Composite = nan(Rank,Rank,NumRep);
    
    Replicate.Err ;
      
    [~,sourceRep] = min( cell2mat({Replicate.Err}) );
    
    for Rep = 1:NumRep
            if (Rep == sourceRep)
                continue
            end           
            Spatials(:,:,Rep) =  ( corr( Replicate(sourceRep).NNTF.U{1, 1} , Replicate(Rep).NNTF.U{1, 1} ));
            Temporal(:,:,Rep) =  ( corr( Replicate(sourceRep).NNTF.U{2, 1} , Replicate(Rep).NNTF.U{2, 1} ));
            State(:,:,Rep) = ( corr( Replicate(sourceRep).NNTF.U{3, 1} , Replicate(Rep).NNTF.U{3, 1} ));
            Composite(:,:,Rep) = mean( cat(3, Spatials(:,:,Rep), Temporal(:,:,Rep), State(:,:,Rep)) ,3 );
    end
    
    SpatialSim = nanmean( nanmax( (Spatials),[],2) , 3);
    TemporalSim = nanmean(  nanmax( (Temporal),[],2) , 3);
    StateSim =  nanmean( nanmax( (State),[],2) , 3);
    CompositeSim = nanmean( nanmax( (Composite),[],2) , 3);

end
