function [Mask, ROI] = DrawRoi( Image, Name)
    FigH = figure('Name',['Draw ' Name]);
    imagesc( Image); colormap('bone');
    ROI = drawpolygon('LineWidth',2,'Color','cyan');
    Mask = createMask(ROI);
    close 
end