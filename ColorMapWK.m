function [Color256] = ColorMapWK()
    Level(1) = 0.00;     BaseColors(1,:) = [0.60, 0.00, 0.60];
    Level(2) = 0.50;     BaseColors(2,:) = [1.00, 0.80, 1.00];
    Level(3) = 1.00;     BaseColors(3,:) = [1.00, 1.00, 1.00];
    

    Level256 = round( Level.*255 +1);
    
     for n = 1:(length(Level)-1)
         SubRange = Level256(n):Level256(n+1);
         for rgb = [1:3]
            Color256(SubRange,rgb) = linspace( BaseColors( n ,rgb) , BaseColors( n+1 ,rgb) , length(SubRange) );
         end
     end
 
end