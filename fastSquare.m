function [ SqW ] = fastSquare( Amplitude, Frequency, OnTime, Segment, Rate)

%     Amplitude = 2.2;
%     Frequency = 5;
%     OnTime = .1;
    t = 0 : 1./Rate :Segment;
    SqW = ( square(2*pi * Frequency * t, OnTime .* Frequency *100 ) .* Amplitude./2)  + Amplitude./2;
end