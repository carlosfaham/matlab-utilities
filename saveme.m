function saveme(name,size,options)
% saveme(name,size)
%
% Saves name.fig and name.eps of active figure
% 
% Options can be:
% 'zbuff' to use render that works with density() plots
% 'timestamp' add timestamp to name
%
%
% Default size is [8 6] if not specified
%
% 20130418 CHF - Created pet function

if nargin < 2
    size = [8 6];
end


% Save eps, png
if ~exist('options','var')
    save_graphic(name,size,'eps','png');
else
    save_graphic(name,size,'eps','png',options);
end

% Save fig
saveas(gca,name,'fig')
fprintf('Create %s.fig\n',name)
