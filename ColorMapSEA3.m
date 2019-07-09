function [Color256] = ColorMapSEA3()
    Level(1) = 0.0;     BaseColors(1,:) = [0.10, 0.00, 0.40];
    Level(2) = 0.9;     BaseColors(2,:) = [0.75, 1.00, 0.40];
    Level(3) = 1.0;     BaseColors(3,:) = [1.00, 1.00, 1.00];

    Level256 = round( Level.*255 +1);
    
     for n = 1:(length(Level)-1)
         SubRange = Level256(n):Level256(n+1);
         for rgb = [1:3]
            Color256(SubRange,rgb) = linspace( BaseColors( n ,rgb) , BaseColors( n+1 ,rgb) , length(SubRange) );
         end
     end
 
end