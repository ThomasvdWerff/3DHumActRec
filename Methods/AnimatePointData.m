function [] = AnimatePointData(allPointData, fps)
player = pcplayer([-77 77],[-77 77],[-5 10]);
while player.isOpen
    for i = 1:length(allPointData)
        if player.isOpen
            view(player, allPointData(i));
          pause(1/fps);
        else
            break
        end
    end
end
end