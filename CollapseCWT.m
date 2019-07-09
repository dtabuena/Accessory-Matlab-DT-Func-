function [PowerBands] = CollapseCWT( wt, f, Flist)

%     Flist = [0 1;
%             1 4;
%             4 8;
%             8 13;
%             13 32;]
    PowerBands = nan( [size(Flist,1), size(wt,2)]);
    for Band = 1:size(Flist,1)
        Fcheck = (f >=  Flist(Band,1)) & (f <= Flist(Band,2));
        PowerBands( Band,:) = mean( wt(Fcheck,:),1);
    end
end