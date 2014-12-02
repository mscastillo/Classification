
%%% Requires 4 variables:
%%% - tsne1
%%% - tsne2
%%% - names
%%% - classes

RandStream.setGlobalStream( RandStream('mt19937ar','Seed',0) ) ;

% % Alternative way to randomly choose a training subset
%   idx1 = find( strcmp(classes,'unstim') > 0 ) ; idx1 = idx1( randperm(numel(idx1)) ) ; idx1 = idx1(1:floor(0.6*numel(idx1))) ;
%   idx2 = find( strcmp(classes,'EPO30')+strcmp(classes,'EPO60') > 0 ) ; idx2 = idx2( randperm(numel(idx2)) ) ; idx2 = idx2(1:floor(0.6*numel(idx2))) ;
%   index = [ idx1(1:min([numel(idx1),numel(idx2)])) ; idx2(1:min([numel(idx1),numel(idx2)])) ] ;
%   gscatter( tsne1(index),tsne2(index),classes(index) ) ;
idx1 = find( strcmp(classes,'unstim') > 0 ) ;
idx2 = find( strcmp(classes,'EPO30')+strcmp(classes,'EPO60') > 0 ) ;
index = [ idx1;idx2 ] ;

gscatter( tsne1(index),tsne2(index),classes(index) ) ;
h1 = gname(names(index)) ; 
superclass1 = get(h1,'String') ; superclass1 = unique(sort([superclass1{:}])) ;
h2 = gname(names(index)) ; 
superclass2 = get(h2,'String') ; superclass2 = unique(sort([superclass2{:}])) ;

idx1 = zeros(1,numel(names))' ; for k = 1:numel(superclass1) ; idx1 = idx1 + strcmp(names,superclass1{k}) ; end ; idx1 = idx1 > 0 ;
idx2 = zeros(1,numel(names))' ; for k = 1:numel(superclass2) ; idx2 = idx2 + strcmp(names,superclass2{k}) ; end ; idx2 = idx2 > 0 ;

% svmo = svmtrain( [ [tsne1(idx1);tsne1(idx2)] [tsne2(idx1);tsne2(idx2)] ],[ zeros(sum(idx1),1);ones(sum(idx2),1) ],'ShowPlot',true,'kernel_function','Quadratic') ;
svmo = svmtrain( [ [tsne1(idx1);tsne1(idx2)] [tsne2(idx1);tsne2(idx2)] ],[ zeros(sum(idx1),1);ones(sum(idx2),1) ],'ShowPlot',true,'kernel_function','linear') ;

axesHandle = svmo.FigureHandles{1} ; 
childHandles = get(axesHandle,'children') ;
hggroupHandle = childHandles(1) ;
surfaceHandle = get(hggroupHandle, 'children') ;
xvals = get(surfaceHandle, 'XData') ;
yvals = get(surfaceHandle, 'YData') ;
m = ( yvals(2)-yvals(1) )/( xvals(2)-xvals(1) ) ;
b = yvals(1) - m*xvals(1) ;

gscatter( tsne1,tsne2,classes ) ;
hold on ;
gscatter( tsne1((idx1+idx2)>0),tsne2((idx1+idx2)>0),ones(sum(idx1>0)+sum(idx2>0),1),'k','o' ) ;
grid on ;
x = get(gca,'xlim') ;
y = m*x + b ;
plot(x,y,'k--','Color',0.5*[1 1 1])

svmclassify( svmo,[tsne1 tsne2] )
