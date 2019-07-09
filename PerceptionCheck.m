function [] = PerceptionCheck( cMap )
%     close all;
    Ligthness = sqrt( sum( cMap.^2 .* [.241 .691 .068] ,2) )';

    figure('Name', 'PerceptionCheck')
    X = (1:length(Ligthness)) ./ 255;
    
    scatter( X, Ligthness, 200 , cMap ,'filled')
    ylim([0 1]); xlim([0 1]);
    set(gca,'Color', [0.75 0.75 0.75])
    pbaspect([1 1 1]);    
    FitLine = polyfit( [X(1),X(end)] , [Ligthness(1) Ligthness(end)] ,1 ); 
    hold on; plot( X, polyval(FitLine,X),'k' ); hold off;
    
end