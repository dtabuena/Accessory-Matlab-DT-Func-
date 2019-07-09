function [ BurntCa, PowerSpecMovFullSize ] = BurnSpect( CaMov, PowerSpect, RelSize, BufferPx)
    %%
    CustMap = pmkmp(256 , 'CubicL');
%     CaMov = CaDataRGBFu;
%     PowerSpect = (InVivoPup(13).STF(5).EventPowerSpec);
%     PowerSpect = flipud(PowerSpect);
%     RelSize = 0.1;
%     BufferPx = 4;
    %
    logPowerSpect = (flipud(PowerSpect));
    numrows = floor( size(CaMov(1).cdata,1).*RelSize );
    
    logPowerSpect = imresize(logPowerSpect ,[numrows size(CaMov,2)]);
    lowerlimit = prctile( logPowerSpect(:) , 2);
    upperlimit = prctile( logPowerSpect(:) , 98);
    
    PowerSpec256 = uint8 ( (logPowerSpect - lowerlimit) ./ (upperlimit - lowerlimit) .* 255 );
    
    PowerSpec2564d = permute( repmat(PowerSpec256, [1,1,length( CaMov)]) , [1,2,4,3]); 

    PowerSpecMov = immovie(PowerSpec2564d, CustMap);

    % Time Color
    for i = 1:length(PowerSpecMov)
        PowerSpecMov(i).cdata(:,i,:) = 255;
        PowerSpecMovFullSize(i) = PowerSpecMov(i);
        PowerSpecMov(i).cdata = imresize3(PowerSpecMov(i).cdata ,[ numrows , size(CaMov(1).cdata,2), size(PowerSpecMov(i).cdata,3)]);
    end
    % append to CaMov
    for i = 1:length(PowerSpecMov)
        BurntCa(i).cdata = [ CaMov(i).cdata; zeros(BufferPx, size(CaMov(i).cdata,2), 3); PowerSpecMov(i).cdata];
        BurntCa(i).colormap = [];
    end    
    
    



