function [data] = LoadPointData(path, expression)
disp("Loading LiDAR point data from the files in: ");
disp(" - " + path);
tic
files = dir([path  expression]);
fileNames = {files.name};
numFiles = length(fileNames);
allPointClouds(1:numFiles) = pointCloud([0,0,0]);
progressBar = waitbar(0, "Loading points: " + 0 + "/" + numFiles);
for i = 1:numFiles
    waitbar((i-1)/numFiles, progressBar, "Loading points: " + i + "/" + numFiles);
    fileId = fopen([path fileNames{i}]);
    pointData = fread(fileId, [4,inf], 'float');
    xyz = pointData(1:3,:)';
    intensity = pointData(4,:)';
    allPointClouds(i) = pointCloud(xyz, 'Intensity', intensity);
  %  [allPointClouds(i), ~] = removeInvalidPoints( allPointClouds(i));
    fclose(fileId);
end
close(progressBar);
data = allPointClouds;
disp("All points are loaded.");
toc
end
