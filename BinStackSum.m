function [Binned] = BinStackSum(Data, BinSize)
% 1 = no binning
disp('Binning...')


Ystop = ceil(size(Data,1)/BinSize)*BinSize;
Xstop = ceil(size(Data,2)/BinSize)*BinSize;

Yrange = (size(Data,1)+1):Ystop;
XRange = (size(Data,2)+1):Xstop;

Data(Yrange, :, :) = NaN;
Data(:, XRange, :) = NaN;

for i = 1:BinSize
   Temp = Data(i:BinSize:Ystop, i:BinSize:Xstop, :, :);
   SubArrays(1:size(Temp,1),1:size(Temp,2),1:size(Temp,3),i) = Temp;
end

Binned = nanmean(SubArrays, 4)*BinSize*BinSize;
disp('     done.')
end