function [MovStr] = FourDToStruct( FourDMov)
    CellMov =  reshape(num2cell(FourDMov, 1:3), 1, []);
    MovStr = struct('cdata', CellMov, 'colormap', []);
end