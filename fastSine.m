function [ SinW ] = fastSine( Amplitude, Frequency, Segment, Rate)

%     Amplitude = 2.2;
%     Frequency = 5;
    t = 0:1./Rate:Segment;
    SinW = ( sin( 2*pi * Frequency * t).* Amplitude );
end