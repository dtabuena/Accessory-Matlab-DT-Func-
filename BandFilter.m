function [FilteredBands] = BandFilter( Signal, SampRate, Flist)

%     Flist = [0 1;
%             1 4;
%             4 8;
%             8 13;
%             13 32;]
    FilteredBands = nan( [size(Flist,1), size(Signal)]);
    for Band = 1:size(Flist,1)
        FilteredBands( Band,:) = bandpass( Signal, Flist(Band,:), SampRate);
    end
end