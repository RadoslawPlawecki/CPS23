%{
@author: Radoslaw Plawecki
%}

a = ProcessImage("original_chest.png"); % create a class object

%% high-pass filter

cutoffFreq = 5;

figure(1)
b = a.highPassFilter(cutoffFreq,1);
ax = gca;
exportgraphics(ax, "C:\Users\KOMPUTER\Desktop\Projekt z CPS\brain_mask_" + ...
    "high_pass_filter_" + cutoffFreq + ".png");
figure(2)
b.showFilteredImage;
ax = gca;
exportgraphics(ax, "C:\Users\KOMPUTER\Desktop\Projekt z CPS\brain_" + ...
    "high_pass_filter" + cutoffFreq + ".png");

%% low-pass filter

cutoffFreq = 400;

figure(1)
c = a.lowPassFilter(cutoffFreq,1);
ax = gca;
exportgraphics(ax, "C:\Users\KOMPUTER\Desktop\Projekt z CPS\chest_" + ...
    "mask_low_pass_filter_" + cutoffFreq + ".png");
figure(2)
c.showFilteredImage;
ax = gca;
exportgraphics(ax, "C:\Users\KOMPUTER\Desktop\Projekt z CPS\chest_" + ...
    "low_pass_filter_" + cutoffFreq + ".png");

%% band-pass filter

bottomFreq = 10;
topFreq = 200;

figure(1)
d = a.bandPassFilter(bottomFreq,topFreq,1);
ax = gca;
exportgraphics(ax, "C:\Users\KOMPUTER\Desktop\Projekt z CPS\brain_" + ...
    "mask_band_pass_filter_" + bottomFreq + "x" + topFreq + ".png");
figure(2)
d.showFilteredImage
ax = gca;
exportgraphics(ax, "C:\Users\KOMPUTER\Desktop\Projekt z CPS\brain_" + ...
    "band_pass_filter_" + bottomFreq + "x" + topFreq + ".png");

%% band-stop filter

bottomFreq = 40;
topFreq = 50;

figure(1)
e = a.bandStopFilter(bottomFreq,topFreq,1);
ax = gca;
exportgraphics(ax, "C:\Users\KOMPUTER\Desktop\Projekt z CPS\chest_" + ...
    "mask_band_stop_filter_" + bottomFreq + "x" + topFreq + ".png");
figure(2)
e.showFilteredImage
ax = gca;
exportgraphics(ax, "C:\Users\KOMPUTER\Desktop\Projekt z CPS\chest_" + ...
    "band_stop_filter_" + bottomFreq + "x" + topFreq + ".png");
