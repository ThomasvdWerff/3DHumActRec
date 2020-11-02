function [projection] = Project3Dto2Dsphere(xCoords,yCoords,zCoords,imageHeight,imageWidth,pointValues)
    r = sqrt(xCoords.^2+yCoords.^2+zCoords.^2);
    pitch = asin(zCoords./r);
    yaw = atan2(yCoords,xCoords);
    
    fovUp = max(pitch);
    fovDown = min(pitch);
    
    pitch = -pitch + fovUp;
    yaw = yaw+pi;
    
    pitchNormalized = pitch/(fovUp-fovDown);
    yawNormalized = yaw/(2*pi);
    
    rows = floor((imageHeight-1)*pitchNormalized)+1;
    columns = floor((imageWidth-1)*yawNormalized)+1;
    
    projection = zeros(imageWidth, imageHeight);
    for i = 1:length(rows)
        projection(columns(i),rows(i)) = pointValues(i);
    end
end
