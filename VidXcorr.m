function [Corrs, Lags, BestR, BestLag, Pval] = VidXcorr( A, B, Lags)
    %%
%     B = Vector;
%     A = ColumnArray;
    %%
%     Lags = -50:10:50;    
    if length(Lags) == 1
       Lags = -Lags:Lags;
    end
    %%
    clc;
    Corrs = [];
    Pval = [];
%     figure(1); clf;
    for Shift = Lags  
        disp(['Shift:' num2str(Shift)])
        Bshift = nan(size(B));
        if Shift < 0
            Bshift(1:end+Shift,:) = B(1-Shift:end,:);
        else
            Bshift(1+Shift:end,:) = B(1:end-Shift,:);
        end  
%         disp(num2str( Bshift(1) ) );
        [Corrs(:,find(Shift == Lags)), Pval(:,find(Shift == Lags))] = corr( A, Bshift,'rows','complete');
%         plot( Bshift + find(Shift == Lags)); hold on;
        
        
    end
    %%
    
    [BestR, Ind] = max( Corrs,[], 2);
    BestLag = Lags(Ind);
    
    
%     %%
%     subplot(1,2,1)
%     imagesc( ImgUnVectorize(BestR, [VGluts( Entry ).dimvec(1:2),1])); colorbar();
%     subplot(1,2,2)
%     imagesc( ImgUnVectorize(BestLag, [VGluts( Entry ).dimvec(1:2),1])); colorbar();

end