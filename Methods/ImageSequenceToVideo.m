function [] = ImageSequenceToVideo(images, fps, videoWidth, videoHeight, videoName, clipType)
    tic
    disp("Writing imagesequence to video")
    outputVideo = VideoWriter(['Clips\' videoName], clipType);
    outputVideo.FrameRate = fps;
    open(outputVideo)
    numImages = length(images);
    progressBar = waitbar(0, "Writing imagesequence to video: " + 0 + "/" + numImages);
    for i = 1:numImages
        waitbar((i-1)/numImages, progressBar, "Writing frame: " + i + "/" + numImages);

        img = images{i};
        writeVideo(outputVideo,img(1:videoWidth,1:videoHeight)');
    end
    close(progressBar);
    close(outputVideo)
    disp("Video writing process finished");
    disp("Created video at " + ['Clips\' videoName]);
    toc
    disp("");
end






















%{
function [] = ImageSequenceToVideo(images, fps, videoWidth, videoHeight, videoName)
    tic
    disp("Writing imagesequence to video")
    outputVideo = VideoWriter(['Clips\' videoName]);
    outputVideo.FrameRate = fps;
    open(outputVideo)
    deltaW = videoWidth/2
    deltaH = videoHeight/2
    
    for j = 1:length(images)
        img = images{j};
        [imgCW, imgCH] = size(img);
       try
        writeVideo(outputVideo,img(floor(imgCW/2-deltaW):floor(imgCW/2+deltaW),floor(imgCH/2-deltaH):floor(imgCH/2+deltaH))');
       catch exception
           disp(exception)
       end
        %    writeVideo(outputVideo,img(1:videoWidth,1:videoHeight)');
    end
    close(outputVideo)
    disp("Video writting process finished");
    disp("Created video at " + ['Clips\' videoName]);
    toc
    disp("");
end
%}