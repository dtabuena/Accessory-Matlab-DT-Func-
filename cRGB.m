function [RGB] = cRGB( Name, direction )
    
    if ~exist('direction')
        direction = 'n';
    end

    rgbAll.Wake = [1 0 1] ; % Magenta 
    rgbAll.Sleep = [0 1 1] ; % Cyan 
    
    rgbAll.WavePos = rgbAll.Sleep .* (1-.3); 
    rgbAll.WaveNeg =  [0 0 1];   
    
    
    rgbAll.Onset = [1, 0, 0]; % Red 
    rgbAll.Onset = rgbAll.Onset + (1 - rgbAll.Onset) .* 0.7 ; % Light Red 
    
    rgbAll.Shade = 0.8 .* [1, 1, 1]; % Grey
    rgbAll.OppShade = rgbAll.Wake + (1 - rgbAll.Wake) .* 0.2  ; % Light Magenta
    rgbAll.OppShade = [1 0 0];
    rgbAll.AfDur = [178, 127, 98] ./ 255 ;  % Not Used
    rgbAll.BoxTime = rgbAll.OppShade; 
    
    
    rgbAll.NMF = ColorMapWint();  % Not Blue-Green-White; Linearized Luminance
    rgbAll.dFoF = ColorMapSpr(); % Not Mag-Red-Yellow-White; Linearized Luminance

    rgbAll.InitProbWake = ColorMapWK(); %Mag - White; Linearized Luminance
    rgbAll.InitProbSleep = ColorMapSP(); %Cyan - White; Linearized Luminance
    rgbAll.PSD = ColorMapSFO(); %Grey-Red-Yellow-White; Linearized Luminance
    rgbAll.PSD = ColorMapSFO(); rgbAll.PSD = rgbAll.PSD(end.*.3:end,:) .* [.9 1 1];

    
    RGB = rgbAll.( Name );
    
    if direction == ['r']
        RGB = flipud(RGB);
    end
    
    
end