function [Color256] = ColorMapUW()
    BaseColor = ([0.3 0 .3 ; 1 1 0] );
    Color256(:,1) = linspace(BaseColor(1,1) , BaseColor(2,1) , 256);
    Color256(:,2) = linspace(BaseColor(1,2) , BaseColor(2,2) , 256);
    Color256(:,3) = linspace(BaseColor(1,3) , BaseColor(2,3) , 256);
end
