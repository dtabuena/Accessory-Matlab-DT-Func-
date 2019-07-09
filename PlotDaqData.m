function [] = PlotDaqData( DAQdata, DownSampRate )
        
    

%% Plot DaqData

% EntryRange =14;
% for Entry = EntryRange
%     DownSampRate = 10;

%     % Load DaqData
%     if  (~isfield(Vgluts, 'DAQdata') || isempty( DAQdata))
%         temp = load( DAQ_DataLoc ); DAQdata = temp.DAQdata; clear temp;
%     end 
    
    ChanCount = 0;
    for Chan = 1:length( DAQdata.Channel)
        if ~isempty(DAQdata.Channel(Chan).Signal)
            ChanCount = ChanCount+1;
        else
            continue
        end
    end    
    figure();
    for Chan = 1:ChanCount
       SPH(Chan) = subplot(ChanCount,1,Chan);
       plot(seconds( DAQdata.Channel(Chan).Time(1:DownSampRate:end) ), DAQdata.Channel(Chan).Signal(1:DownSampRate:end),'-k')
    end
    linkaxes( SPH, 'x')
% end

end