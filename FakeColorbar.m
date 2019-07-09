function [Handle] = FakeColorbar( ColorMin, ColorMax, ColorMap, YaxLabel, labelAngle )
    Handle = figure('Name','Scale');

    if ~exist('labelAngle')
        labelAngle = 0; 
    end
    

    axes('Position', [.3 .1 .7 .8]);
    
    ColorMax = round(ColorMax,2,'significant');
    
    surf( 1:2 , linspace(ColorMin, ColorMax, 255)' ,repmat(linspace(ColorMin, ColorMax, 255)', [1 2]), 'EdgeColor', 'interp');
    box on;
    grid off
    xlim([1 2]);
    ylim([ColorMin ColorMax]);
    set(gca,'TickDir','in'); 
    set(gca,'xtick',[])
    colormap(ColorMap);
    view([0 90]);
    yticks([ColorMin, ColorMax]);
%     set(gca,'TickDir','both');
    set(gca,'FontSize',16)
    ytickangle(labelAngle)

    
    pbaspect([10 100 1])
    set(gca, 'Layer', 'Top');
    
    if( exist('YaxLabel') && ~isempty(YaxLabel)   )
       hLabel = ylabel(YaxLabel);
       set(hLabel, 'position', get(hLabel,'position') + [.5,0,0]); 
%        text( double(mean( xlim) ) , double(mean(ylim)), double(ColorMax) , YaxLabel, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Rotation', 90)
    end
    
end