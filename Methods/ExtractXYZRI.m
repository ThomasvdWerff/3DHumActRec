function [xCoord, yCoord, zCoord, rDistance, intensity] = ExtractXYZRI(pntCloud)
    xCoord = pntCloud.Location(:,1);
    yCoord = pntCloud.Location(:,2);
    zCoord = pntCloud.Location(:,3);
    rDistance = sqrt(xCoord.^2 + yCoord.^2 + zCoord.^2);
    intensity = pntCloud.Intensity;
end

