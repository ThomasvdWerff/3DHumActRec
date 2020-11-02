close all;
clearvars  -except lidarPointClouds
clc;


% Set the following parameters youself
% Take local stored pointclouds
loadPointData = false;
loadImageData = false;

% Show the LiDAR animation or not
showAnimation = true;

% Project data and Save a clip of the projected data
projectData = true;


% Relative path for stored data
pointPath = './LidarData/KittiSet1/';
if not(exist(pointPath, 'dir'))
   disp("datapath not valid");
    return; 
end


%  loading point data

if (loadPointData || not(exist('lidarPointClouds', 'var')) || isempty(lidarPointClouds))
    lidarPointClouds = LoadPointData(pointPath, '*.bin');
end

% loading image data
if (loadImageData)
    pictureData = LoadImageData(imagePath.RGB,'*.png'); %#ok<UNRCH>
end

if (showAnimation)
    AnimatePointData(lidarPointClouds, 10); %#ok<UNRCH>
end

if (projectData)
    W = 2048;
    H = 64;
    threshold = 0.7;
    minDim([1 2]) = [W,H];
    projection = cell(1,length(lidarPointClouds));

    numPointClouds = length(lidarPointClouds);

    progressBar = waitbar(0, "Projecting 3D to 2D: " + 0 + "/" + numPointClouds);
    for i = 1:numPointClouds
        waitbar((i-1)/numPointClouds, progressBar, "Projecting scene: " + i + "/" + numPointClouds);
        [x, y, z, r, intensity] =  ExtractXYZRI(lidarPointClouds(i));
        projection{i} =  adapthisteq(Project3Dto2Dunfolding(x,y,z,W,intensity, threshold));
        %projection{j} =  Project3Dto2Dsphere(x,y,z,H,W,intensity);
        sizeFrame = size(projection{i});
        minDim = min([minDim; sizeFrame]);
    end    
    close(progressBar);

    
    ImageSequenceToVideo(projection, 10, minDim(1), minDim(2), 'unfoldProjectionV4.avi',  'Grayscale AVI');
    %  ImageSequenceToVideo(pictureData, 10,  374,1241, 'pictures.avi', 'Uncompressed AVI');
end










