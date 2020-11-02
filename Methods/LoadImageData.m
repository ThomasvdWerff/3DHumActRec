function [data] = LoadImageData(path, expression)
files = dir([path  expression]);
fileNames = {files.name};
imageData = cell(length(fileNames),1);
for i = 1:length(fileNames)
    imageData{i} = imread([path fileNames{i}]);
end
data = imageData;
end

