function [Handle, hLabel] = ColorBarDT( ColorMin, ColorMax, ColorMap, YaxLabel, labelAngle, yTicksNum, yTicksStr, EndLabel)
    FontSize = 10;

    Handle = figure('Name','Scale');
    if ~exist('labelAngle')
        labelAngle = 0; 
    end
    if ~exist('yTicksNum')
        yTicksNum = 'auto'; 
    end
    
    
    
    axes('Position', [.3 .1 .7 .8]);
    
    ColorMax = round(ColorMax,2,'significant');
    
    surf( -1:2:1 , linspace(ColorMin, ColorMax, 255)' ,repmat(linspace(ColorMin, ColorMax, 255)', [1 2]), 'EdgeColor', 'interp');
    box on;
    grid off
    xlim([-1 1]);
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
%         hLabel = ylabel(YaxLabel, 'FontSize', FontSize .* 1.6);
%         set(hLabel, 'Units', 'Normalized', 'Position', [1, 0.5, 0]); 
       text( double(mean( xlim) ) , double(mean(ylim)), double(ColorMax) , YaxLabel, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'middle', 'Rotation', 90, 'FontSize', FontSize .* 1.6)
    end
    
    
    set(gca,'LooseInset',get(gca,'TightInset'));
    set(gcf, 'Position', [.50 .50 .1 1.25] .* 300);
    
    if exist('EndLabel')
        EndLabel(1);
        EndLabel(2);

        text( 0, ColorMin - ColorMax .* .05  , 500 ,  EndLabel(1), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'mid', 'Rotation', labelAngle, 'FontSize', FontSize.* 1.6);
        text( 0, ColorMax + ColorMax .* .05  , 500 , EndLabel(2), 'HorizontalAlignment', 'center', 'VerticalAlignment', 'mid', 'Rotation', labelAngle, 'FontSize', FontSize.* 1.6);
    end
    
    
    
end