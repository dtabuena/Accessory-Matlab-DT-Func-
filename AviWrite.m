function [FileNameLoc] = AviWrite(FileNameLoc, MovieStruct, FrameRate, Audio, SampleRate, Acceleration, Quality)

        %% Debug Var
%         FileNameLoc = 'H:\_Macros\In Vivo StimMatch\InVivoPup\Test2.avi'
%         MovieStruct = InVivoPup(13).CaEmgMov;
%         FrameRate = InVivoPup(13).FrameRate
%         Audio = InVivoPup(13).Signal;
%         SampleRate = InVivoPup(13).SampleRate;
%         Acceleration = 10;            

        %%
        if ~exist('Acceleration','var')
            Acceleration = 1;
        end
        
        MovieStruct = uint8(MovieStruct);
        
        FrameInd = 1:Acceleration:size(MovieStruct,4);
        FrameMod = mod(FrameInd(end), Acceleration);
        FrameInd = FrameInd(1:end-FrameMod);
        
        AudioClipped = Audio(1:(FrameInd(end) + Acceleration -1 ) .* (SampleRate ./ FrameRate) );               
        AudioSteps = reshape( AudioClipped, SampleRate ./ FrameRate .* Acceleration, []);
        
        try
            release( videoFWriter);
        end
        
        
        videoFWriter = vision.VideoFileWriter(FileNameLoc, 'AudioInputPort', true, 'FileFormat', 'AVI', 'VideoCompressor' , 'MJPEG Compressor' ,  'FrameRate', FrameRate, 'Quality', Quality);
        
        for Step = 1:length(FrameInd)
            FrameNum = FrameInd(Step);
            FrameImg = MovieStruct(:,:,:,FrameNum);
            FrameAudio = AudioSteps(:,Step);
            videoFWriter( FrameImg, FrameAudio );
        end
        
        try
            release( videoFWriter);
            disp('Finished');
        end
end