function [Handle] = FakeColorbar2( ColorMin, ColorMax, ColorMap, YaxLabel, Angle )
    Handle = figure('Name','Scale');

    if ~exist('Angle'); Angle = 0; end;
    
    
%     ColorMax = round(ColorMax,2,'significant');
    DataRange = repmat(linspace(ColorMin, ColorMax, 255)' - ColorMin, [1 2]);
    
    
    imagesc(DataRange, ColorMap); set(gca,'Ydir','Normal')
    

    box on;
    xlim([1 2]);
    ylim([ColorMin ColorMax]);
    set(gca,'xtick',[])
    view([0 90]);
%     yticks()
    set(gca,'TickDir','both');
   
    ytickangle(Angle)
    if( exist('YaxLabel') )
        ylabel(YaxLabel);
    end
    pbaspect([10 100 1])
%     set(gca, 'Layer', 'Top');
end