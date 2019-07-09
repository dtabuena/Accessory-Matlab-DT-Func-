function [BinnedMovie] = Bin4dMov( FourDmov , BinSize)
    Filter = zeros( BinSize .* 2 -1);
    Filter(1:BinSize,1:BinSize) = ones(BinSize);
    FilteredMovie = convn(FourDmov, Filter, 'same');    
    BinnedMovie = FilteredMovie(1:BinSize:end,1:BinSize:end,:,:);
    BinnedMovie = uint8(  BinnedMovie ./ max( BinnedMovie(:) ) .* 255 );
 end