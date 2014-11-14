% Requires 4 variables:
% - tsne1
% - tsne2
% - names
% - classes

gscatter( tsne1,tsne2,classes )
h1 = gname(names) ; 
superclass1 = get(h1,'String') ; superclass1 = unique(sort(superclass1)) ;
h2 = gname(names) ; 
superclass2 = get(h2,'String') ; superclass2 = unique(sort(superclass2)) ;

idx1 = zeros(1,numel(names))' ; for k = 1:numel(superclass1) ; idx1 = idx1 + strcmp(names,superclass1{k}) ; end ; idx1 = idx1 > 0 ;
idx2 = zeros(1,numel(names))' ; for k = 1:numel(superclass2) ; idx2 = idx2 + strcmp(names,superclass2{k}) ; end ; idx2 = idx2 > 0 ;

svmo = svmtrain( [ [tsne1(idx1);tsne1(idx2)] [tsne2(idx1);tsne2(idx2)] ],[ repmat(1,sum(idx1),1);repmat(2,sum(idx2),1) ],'ShowPlot',true ) ;

axesHandle = svmo.FigureHandles{1} ; 
childHandles = get(axesHandle,'children') ;
hggroupHandle = childHandles(1) ;
lineHandle = get(hggroupHandle, 'children') ;
xvals = get(lineHandle, 'XData') ;
yvals = get(lineHandle, 'YData') ;
m = ( yvals(2)-yvals(1) )/( xvals(2)-xvals(1) ) ;
b = yvals(1) - m*xvals(1) ;
x = get(axesHandle,'xlim') ;
y = m*x + b ;

gscatter( tsne1,tsne2,classes ) ;
hold on ;
gscatter( tsne1((idx1+idx2)>0),tsne2((idx1+idx2)>0),[ones(sum(idx1>0)+sum(idx2>0),1)],'k','o' ) ;
grid on ;
x = get(gca,'xlim') ;
y = m*x + b ;
plot(x,y,'k--','Color',0.5*[1 1 1])

svmclassify( svmo,[tsne1 tsne2] )
