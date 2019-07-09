function [TcaResults] = CalcTcaErr(TcaResults, StimTensor)

RankLimit = length(TcaResults.Ranks)
for Rank = 1:RankLimit
    disp(['Rank ' num2str(Rank) ' of ' num2str(RankLimit)]);
    Replicates = length(TcaResults.Ranks(Rank).Replicate);
   
    for Rep = 1:Replicates
        disp(['     Rep ' num2str(Rep) ' of ' num2str(Replicates)]);

        A = TcaResults.Ranks(Rank).Replicate(Rep).NNTF.U{1,1};
        B = TcaResults.Ranks(Rank).Replicate(Rep).NNTF.U{2,1};
        C = TcaResults.Ranks(Rank).Replicate(Rep).NNTF.U{3,1};
        D = TcaResults.Ranks(Rank).Replicate(Rep).NNTF.lambda;              
        Recon = single(  zeros(size(A,1), size(B,1) , size(C,1)) );
        for r = 1:Rank
            Recon =  Recon + ( A(:,r) .* permute(B(:,r),[2,1,3]) .* permute(C(:,r) ,[2 3 1])  .* D(r) )  ;
        end            

%         TcaResults.Ranks(Rank).Replicate(Rep).Recon = Recon ;
%         TcaResults.Ranks(Rank).Replicate(Rep).Res = (Recon - StimTensor) .^ 2
%         TcaResults.Ranks(Rank).Replicate(Rep).Err = sum( TcaResults.Ranks(Rank).Replicate(Rep).Res(:) ) ./ (sum(StimTensor(:).^2) )  ;
        
      Base = StimTensor;  TcaResults.Ranks(Rank).Replicate(Rep).Err = sqrt( sum( (Base(:) - Recon(:)).^2)  ./ (sum(Base(:).^2) ) ) ;        
    end
    [~, TcaResults.Ranks(Rank).Best] = min( cell2mat( {TcaResults.Ranks(Rank).Replicate.Err} ));
    
    %% Optional clear Recon

    
end

end