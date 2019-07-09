function [CaData, RunTime] = ReadAndBinCXD( FileNameLoc, BinSize, SubStackRange )
%% [CaData, Time] = ReadAndBinCXD( FileNameLoc, BinSize, [SubStackRange] )
% FileNameLoc = Path to the cxd eg: "C:\SSD_Data\Adult_InVivo\012418\Ani1\012418_CaData_Adult1_00001.cxd
% BinSize = how much binning to do (see table)
% SubStackRange = OPTIONAL - frame numbers to import eg: [40:90]


% Bin Table (incrementing by multiples of 2)
% Orig      : 960 x 720
% +2 (2)    : 480 x 360
% +2 (4)    : 240 x 180
% +2 (8)    : 120 x 90

%% Debug Var
% Loc = 'G:\InVivoPup\111517\Animal_3'
% File = '111517_CaData00003_A3_Rec2.cxd'
% FileNameLoc = [Loc '\' File];
% BinSize = 8;
% SubStackRange = [38 40];



%% DEPENDANT ON  :
%     BinStack.m  (DT)
%     Bioformats Tool (https://docs.openmicroscopy.org/bio-formats/5.9.2/developers/matlab-dev.html)
%%
if (~exist('BinSize'))
    BinSize = 1;
end
if (~(BinSize > 1))
    BinSize = 1;
end    
if (isempty(BinSize))
    BinSize = 1;
end 

if (exist('SubStackRange','var'))
    disp(['Opening ' num2str(SubStackRange(1)) ' to ' num2str(SubStackRange(end))]);
else
    disp('Opening All');
end

disp('Read Meta Data...');
reader = bfGetReader(FileNameLoc);
omeMeta = reader.getMetadataStore();
stackSizeX = omeMeta.getPixelsSizeX(0).getValue(); % image width, pixels
stackSizeY = omeMeta.getPixelsSizeY(0).getValue(); % image height, pixels
% stackSizeZ = omeMeta.getPixelsSizeZ(0).getValue(); % number of Z slices
stackSizeT = omeMeta.getPixelsSizeT(0).getValue(); % number of T slices
disp('Read Meta Data...done.');

if (~exist('SubStackRange'))
    SubStackRange = 1:stackSizeT;
end

CaData = single( zeros(stackSizeY ./ BinSize, stackSizeX ./ BinSize, length(SubStackRange)) );
tic;
for i = 1:length(SubStackRange)
    FrameNo = SubStackRange(i);
    disp(['Frame ' num2str(FrameNo) ' of ' num2str(SubStackRange(1)) ' to ' num2str(SubStackRange(end)) '...']);
    CurrentFrame = single( bfGetPlane(reader, FrameNo) );
    
    if (BinSize <= 1)
        CaData(:,:,i) = CurrentFrame;
    else
        CurrentFrameBinned = BinStack(CurrentFrame, BinSize);
        CaData(:,:,i) = CurrentFrameBinned;
    end
end


RunTime = toc;
Rate = prod(size(CaData)) ./ RunTime;