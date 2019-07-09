function [Color256] = ColorMapWint()
%%

    Level = [];    
    BaseColors = [0 0 0];
    Color256 =[];
    n = 1;
    Level(n) = 0.00;     BaseColors(n,:) = [0.00, 0.40, 0.75];    n = n+1;
    Level(n) = 0.20;     BaseColors(n,:) = [0.25, 0.55, 0.70];    n = n+1;
    Level(n) = 0.40;     BaseColors(n,:) = [0.30, 0.70, 0.70];    n = n+1;
    Level(n) = 0.55;     BaseColors(n,:) = [0.20, 0.85, 0.35];    n = n+1;
    Level(n) = 0.65;     BaseColors(n,:) = [0.40, 0.90, 0.25];    n = n+1;
    Level(n) = 0.75;     BaseColors(n,:) = [0.60, 0.95, 0.00];    n = n+1;
%     Level(n) = 0.80;     BaseColors(n,:) = [0.91, 0.91, 0.00];    n = n+1;
%     Level(n) = 0.88;     BaseColors(n,:) = [0.95, 0.95, 0.50];    n = n+1;
    Level(n) = 1.00;     BaseColors(n,:) = [1.00, 1.00, 1.00];    n = n+1;     
%     
    Level = ( Level - min(Level) ) ./ ( max(Level)  - min(Level) );


    Level256 = round( Level.*255 +1);
    for i = 1:(length(Level)-1)
         SubRange = Level256(i):Level256(i+1);
         for rgb = [1:3]
            Color256(SubRange,rgb) = linspace( BaseColors( i ,rgb) , BaseColors( i+1 ,rgb) , length(SubRange) );
         end
    end
    
%     close all; 
%     PerceptionCheck( Color256 );
end





% %%
%     Level(n) = 0.00;     BaseColors(n,:) = [0.00, 0.40, 0.75];    n = n+1;
%     Level(n) = 0.20;     BaseColors(n,:) = [0.25, 0.55, 0.70];    n = n+1;
%     Level(n) = 0.40;     BaseColors(n,:) = [0.30, 0.70, 0.70];    n = n+1;
%     Level(n) = 0.55;     BaseColors(n,:) = [0.20, 0.85, 0.35];    n = n+1;
%     Level(n) = 0.65;     BaseColors(n,:) = [0.40, 0.90, 0.25];    n = n+1;
%     Level(n) = 0.75;     BaseColors(n,:) = [0.60, 0.95, 0.00];    n = n+1;
%     Level(n) = 0.80;     BaseColors(n,:) = [0.91, 0.91, 0.00];    n = n+1;
%     Level(n) = 0.88;     BaseColors(n,:) = [0.95, 0.95, 0.50];    n = n+1;
%     Level(n) = 1.00;     BaseColors(n,:) = [1.00, 1.00, 1.00];    n = n+1;  