function myfigview(el)
% set size for easy viewing in presentations, etc
%
% 050201 pfs v1.0
% 061005 pfs v1.1 fixed bugs & added error trapping
% 100610 chf v1.2 white background, made into function with input el
% 110222 chf v1.3 removed 'else' clause that made legend fontsize smaller

if nargin < 1
    el = 11; 
end


set(gcf,'color','white')
box(gca,'on')

Handle = get(gcf,'children');

for Index=1:length(Handle)
	HH = get(Handle(Index));
	if isfield(HH,'FontSize')
		if ~isfield(get(Handle(Index)),'String') 
			set(Handle(Index),'FontSize',el);	
		end
	end
end


h = get(gca, 'title');
set(h,'Fontsize', el)
h = get(gca,'xlabel');
set(h,'Fontsize', el)
h = get(gca,'ylabel');
set(h,'Fontsize', el)

clear Handle HH Index