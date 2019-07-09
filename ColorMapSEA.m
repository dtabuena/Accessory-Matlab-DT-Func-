function [Color256] = ColorMapSEA()
    n = 1;
    Level(n) = 0.00;     BaseColors(n,:) = [0.00 0.60 0.50];    n = n+1;
%     Level(n) = 0.55;     BaseColors(n,:) = [0.00 1.00 0.00];    n = n+1;
    Level(n) = 0.75;     BaseColors(n,:) = [1.00 1.00 0.50];    n = n+1;
    Level(n) = 0.85;     BaseColors(n,:) = [1.00 1.00 1.00];    n = n+1;
    Level(n) = 1.0;     BaseColors(n,:) = [1.00 1.00 1.00];    n = n+1;

%     Level256 = round( Level.*255 +1);
%     
%      for n = 1:(length(Level)-1)
%          SubRange = Level256(n):Level256(n+1);
%          for rgb = [1:3]
%             Color256(SubRange,rgb) = linspace( BaseColors( n ,rgb) , BaseColors( n+1 ,rgb) , length(SubRange) );
%          end
%      end
%  
%      
     
     
    Level256 = round( Level.*255 +1);
    for n = 1:(length(Level)-1)
         SubRange = Level256(n):Level256(n+1);
         for rgb = [1:3]
            Color256(SubRange,rgb) = linspace( BaseColors( n ,rgb) , BaseColors( n+1 ,rgb) , length(SubRange) );
         end
    end
    
    
    
    
end