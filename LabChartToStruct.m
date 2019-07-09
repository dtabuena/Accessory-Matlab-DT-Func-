function [LabChartData] = LabChartToStruct(LabChartFile)
    disp('Loading labchart.mat into cell...')
    scaleunits = ones(1,20);
    scaleoffset = zeros(1,20);
    load(LabChartFile); %Load an adressed file
    
    for i=1:length(datastart) % Read each channel into an entry in a cell.
        LabChartData(i).Time = datetime(blocktimes,'ConvertFrom','datenum');
        LabChartData(i).Title = titles(i,:);
        LabChartData(i).SampleRate = samplerate(i);
        LabChartData(i).Data = data(datastart(i):dataend(i)) .* scaleunits(i) + scaleoffset(i) ;
    end
    disp('     Loaded.')
end