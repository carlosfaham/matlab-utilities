function deletelastchild(n)
% Deletes the last object plotted in figure
% Original credit to Rick Gaitskell
%
% CH Faham

if( nargin<1 ) n = 1; end;
h = get( gca , 'child' );
dis('Current Axes contained %d children',length(h));

dis('Deleting oject: type %s',get(h(n),'type'));
delete( h(n) );

