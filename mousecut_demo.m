clf;
[px,py]=humps;
plot(px,py,'r.-');
title('Select with mouse, Enter when done');
[x,y] = ginput;
k=convhull(x,y);
vi=inpolygon(px,py,x(k),y(k));
hold on;
plot(x(k),y(k),px(vi),py(vi),'ko');