function [Color256] = ColorMapSpr(Elements)
    BaseColor = ([0.5 0 0; .9 1 0] );
    %%
    n = 1;
    Level(n) = 0.00;     BaseColors(n,:) = [0.75, 0.00, 0.80];    n = n+1;
    Level(n) = 0.05;     BaseColors(n,:) = [0.80, 0.15, 0.70];    n = n+1;
    Level(n) = 0.15;     BaseColors(n,:) = [1.00, 0.15, 0.15];    n = n+1;
    Level(n) = 0.20;     BaseColors(n,:) = [1.00, 0.25, 0.15];    n = n+1;
    Level(n) = 0.30;     BaseColors(n,:) = [1.00, 0.40, 0.20];    n = n+1;
    Level(n) = 0.65;     BaseColors(n,:) = [1.00, 0.75, 0.10];    n = n+1;
    Level(n) = 0.95;     BaseColors(n,:) = [1.00, 1.00, 0.00];    n = n+1;
    Level(n) = 1.00;     BaseColors(n,:) = [1.00, 1.00, 1.00];    n = n+1;     
    
    Level256 = round( Level.*255 +1);
    for n = 1:(length(Level)-1)
         SubRange = Level256(n):Level256(n+1);
         for rgb = [1:3]
            Color256(SubRange,rgb) = linspace( BaseColors( n ,rgb) , BaseColors( n+1 ,rgb) , length(SubRange) );
         end
    end
    
    if exist('Elements')
        Color256 = imresize(Color256, [Elements,3],'nearest')
    end
    
%     PerceptionCheck( Color256 );
end