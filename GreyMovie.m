function [GreyMov] = GreyMovie(VideoMat, Type)
    
    if ~exist('Type')
        Type = 'Sum';
    end
    
    if Type = 'Sum'
       GreyMov = repmat( sum(VideoMat,3), [1,1,3,1] ); % Sum/Average of colors; higher gain for white input but dilutes monochrome input like LEDS
    end
    if Type = 'Max'
       GreyMov = repmat( max(VideoMat,[],3), [1,1,3,1] ); % Max Input; higher gain for monochrome inputs such as a colored LEDs
    end

    GreyMovF = uint8(GreyMov ./ max(GreyMov (:) ) .* 255);
    
    
end