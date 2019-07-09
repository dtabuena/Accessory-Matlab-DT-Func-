function [] = WriteStructMovie(ImageDataStruct, TiffName, FileLocation)
    % Can write a large (>4gb) single or double to a tif file.
    % Inputs
    %     ImageData: a Movie in Matlab Struct Format ( ImageDataStruct(Frame).cdata ; cdata = (y,x,RGB) )
    %     TiffName: a string of the file name. eg 'MyTif.tif'
    %     FileLocation: a string of the file path to save in. eg 'C:\MyData\MyStacks'
    
%     ImageData: a 4d uint matrix representing a tiff stack (y, x, RGB, time)
    for FrameNo=1:length(ImageDataStruct)
        ImageData(:,:,:,FrameNo) = ImageDataStruct(FrameNo).cdata;
    end
    
    disp('Saving Tiff...')
    ImageData = uint8(ImageData); %Convert to int
    FileNameLoc = [FileLocation '\' TiffName ]; % concatenate path and file
    ObjTiff = Tiff(FileNameLoc, 'w8'); % Create and open a tiff object in write mode
    try % A 'try ... catch' statment is used to garauntee that the tiff is closed by matlab regardless of succeful write (prevents file locking)
        for i=1:size(ImageData,4) % Loop through each matlab frame
            % write meta data for each frame
            tagstruct.ImageLength     = size(ImageData,1); %image dimensions
            tagstruct.ImageWidth      = size(ImageData,2); %image dimensions
            tagstruct.Photometric     = Tiff.Photometric.RGB; %pixel value interpretation
            tagstruct.BitsPerSample   = 8; % Pixel bit depth
            tagstruct.SamplesPerPixel = 3; % Intensity values per pixel per frame.
            tagstruct.RowsPerStrip    = 16; % Memory handling 
            tagstruct.PlanarConfiguration = Tiff.PlanarConfiguration.Chunky; % Memory handling 
            tagstruct.Software        = 'MATLAB'; %Written by
            ObjTiff.setTag('Photometric', Tiff.Photometric.RGB); %pixel value interpretation
            ObjTiff.setTag('SampleFormat', Tiff.SampleFormat.UInt); %pixel value interpretation
            ObjTiff.setTag(tagstruct) % Save meta data
            % End write meta 
            
            ObjTiff.write(ImageData(:,:,:,i)); %Write one matlab frame to a tif frame (aka a directory or IFD)
            if (i~=size(ImageData,4)) % If there are more matlab frames ... 
                writeDirectory(ObjTiff); % ...make a new tif frame.
            end        
        end
        ObjTiff.close(); % Stop writing to tiff
        disp('     Saved'); % Report success
    catch % If an error occurs...
        disp('Failed'); % ... report failure
        ObjTiff.close(); % ... close the tiff anyway
    end
end
