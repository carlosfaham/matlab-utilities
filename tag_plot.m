function tag_plot(str)
%
% Timestamps and namestamps plot
%
% Inputs:
%        str: namestamp
%

figure(gcf)

text_pos = [0.82 0.009 0.11 0.04];
tag_string = [datestr(now,'yyyymmdd'),'  ',str];
fontsizzle = 6;
col = [1 1 1]*0;
    
%% Do it

annotation(gcf,'textbox',...
    text_pos,...
    'String',tag_string,...
    'FontSize',fontsizzle,...
    'FitBoxToText','on',...
    'LineStyle','none',...
    'color',col);
