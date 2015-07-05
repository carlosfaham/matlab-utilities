function out = save_graphic( varargin )
% save_graphic( filename , [x y] size in inches , options ) 
% options 
%   'preview' to see the graphics 
%
% graphics output options - specifiy as many as you want
% pdf & png are default
%   'zbuff' to use render that works with density() plots
%   'timestamp' add timestamp to name
%   'pdf' generate pdf (default)
%   'epstopdf' generate pdf via unix function epstopdf - has better bounding box
%   'gif' generate gif
%   'jpg' generate eps
%   'all' generates EPS, PDF, GIF, JPG, PNG
%   'eps' generate eps
%   'png' generate png (default)
% - generate figures using convert to get better quality gif
% - jpg cretaed by matlab generator
% - zbuffer necessary to get desnity plost to render
%
% Note that the PDF file gives graphic in bottomm left corner of Letter size page - don't know how to change this
%
% 030810 rjg jpg added
% 031029 Suggestion - I should file the graphics in appropriate sub-directories
% 031201 flag_pdfonly added
% 040116 Mac has -dpdf & -dpng options so use them
% 040319 Display eps in Preview
% 040402 Added epstopdf option - which generates PDF using unix command epstopdf
% Golden Ratio is x = 0.6180339887
% Assume command for epstopdf - this is not working yet
% 040608 Remove . from file names
% 040622 Fix bug on strrep of /

epstopdf_unix = '/usr/local/teTeX/bin/powerpc-apple-darwin-current/epstopdf';

flag_preview = 0;
flag_render = '';
flag_pdfonly = 0;
flag_default = 1;
flag_pdf = 0;
flag_epstopdf = 0;
flag_eps = 0;
flag_gif = 0;
flag_jpg = 0;
flag_png = 0;

flag_timestamp = 0;

if nargin>=3
    v = varargin(3:end);
    while length(v)>0
        switch v{1}
            case 'preview'
                flag_preview = 1;
            case 'zbuff'
                flag_render = '-zbuffer';
            case 'pdf'
                flag_default = 0;
                flag_pdf = 1;
            case 'epstopdf'
                flag_default = 0;
                flag_epstopdf = 1;
            case 'eps'
                flag_default = 0;
                flag_eps = 1;
            case 'jpg'
                flag_default = 0;
                flag_jpg = 1;
            case 'gif'
                flag_default = 0;
                flag_gif = 1;
            case 'png'
                flag_default = 0;
                flag_png = 1;
            case 'timestamp'
                flag_timestamp = 1;
        end
        v(1) = [];
    end
end

if nargin<2
    figsize = [5 4];
else
    figsize = varargin{2};
end
if nargin<1
    varargin{1} = 'test';
end

if flag_default  % output default
    flag_pdf = 1;
    flag_png = 1;
end

file = varargin{1}; % File name
file = strrep(file,' ','_');
file = strrep(file,'.','_');
%file = strrep(file,'/','_');


if flag_timestamp
    file = [file '_' cclock];
end

figsizegif = figsize; % Final gif size in inches
set(gcf,'papersize' , figsize);
papersize = get(gcf,'papersize');
set(gcf,'paperpos',[0 papersize(2)-figsize(2) figsize]);

% Always create eps
% Will delete file later if not required in flag_eps

print(file,'-depsc2','-loose',flag_render);    
%print(file, '-depsc2',flag_render);    

if flag_eps
    fprintf('Create %s.eps\n',file);
end

if flag_jpg
    fprintf('Create %s.jpg\n',file);
    print(file, '-djpeg99',flag_render);
end

if flag_png
    fprintf('Create %s.png\n',file);
    %print(file, '-dpng',flag_render);
    print(file, '-dpng','-r600');
end

if flag_pdf
    fprintf('Create %s.pdf\n',file);
    switch 1
        case 1
            % Mac OS X with -dpdf option
            print(file, '-dpdf','-loose',flag_render);    
        case 2
            % Use unix convert utility
            unix(['convert ' file '.eps ' file '.pdf']); 
    end
end

% This must come after flag_pdf option
if flag_epstopdf
    fprintf('Create %s.pdf using epstopdf \n',file);
    unix([epstopdf_unix ' ' file '.eps ']); % Output default is *.pdf
    % Problems getting this to run
    flag_pdf = 1; % INdicate pdf now available
end

if flag_gif
    fprintf('Create %s.gif\n',file);
    unix(fprintf('convert -geometry %dx%d %s.eps %s.gif\n',72*figsizegif,file,file)); 
end

if ~flag_eps
    % Finishd with eps file
    delete([file '.eps']);
end

if flag_preview
    if flag_gif
        unix(['open -a Preview ' file '.gif']);
    end
    
    if flag_pdf
        unix(['open -a Preview ' file '.pdf']);
    end

    if flag_eps
        unix(['open -a Preview ' file '.eps']);
    end

    if flag_jpg
        unix(['open -a Safari ' file '.jpg']);
    end

    if flag_png
        unix(['open -a Safari ' file '.png']);
    end
end
