close all;
folder = 'LidarData\';
compData = {dir([folder, '*.zip']).name};
fig = uifigure;
set(fig, 'MenuBar', 'none', 'ToolBar', 'none')
d = uiprogressdlg(fig,'Title','Unzipping LiDAR Data','Indeterminate','on');
drawnow
for i = 1:length(compData)
    zipName = [folder compData{i}];
    unzip(zipName,zipName(1:(end-4)));
end
close(fig)
