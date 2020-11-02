function [projection] = Project3Dto2Dunfolding(xCoords,yCoords,zCoords,imageWidth,pointValues, threshold)
    r = sqrt(xCoords.^2+yCoords.^2+zCoords.^2);
    azimuth = -atan2(yCoords,xCoords);
    azimuthNormalized = ( azimuth+pi)/(2*pi);
    columns = floor((imageWidth-1)*azimuthNormalized)+1;
    angleDelta = abs([azimuth(end) - azimuth(1); azimuth(2:end) - azimuth(1:(end-1))]);
    jump = angleDelta > threshold ;

    rows = cumsum(jump)+1;
    projection = zeros(imageWidth, max(rows));
    for i = 1:length(rows)
        projection(columns(i),rows(i)) = pointValues(i);
    end
end














