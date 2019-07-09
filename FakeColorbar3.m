function [Handle] = FakeColorbar3( ColorMin, ColorMax, ColorMap, YaxLabel, labelAngle, yTicksNum, yTicksStr)
    FontSize = 12;

    Handle = figure('Name','Scale');
    if ~exist('labelAngle')
        labelAngle = 0; 
    end
    if ~exist('yTicksNum')
        yTicksNum = 'auto'; 
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
%     yticks()
    set(gca,'TickDir','both');
   
    yticks(yTicksNum);
    ytickangle(labelAngle);
    
    if exist('yTicksStr')
        yticklabels( yTicksStr ); 
    end
    
    pbaspect([10 100 1])
    set(gca, 'Layer', 'Top');
    
    ax = gca;
    ax.FontSize = FontSize;
    
    if( exist('YaxLabel') && ~isempty(YaxLabel)   )
        hLabel = ylabel(YaxLabel, 'FontSize', FontSize .* 1.6);
        set(hLabel, 'position', get(hLabel,'position') + [.5,0,0]); 
%        text( double(mean( xlim) ) , double(mean(ylim)), double(ColorMax) , YaxLabel, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Rotation', 90)
    end
    
 
    set(gca,'LooseInset',get(gca,'TightInset'));
    set(gcf, 'Position', [.50 .50 .1 1.25] .* 300);
    
end