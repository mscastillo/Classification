
%% It requires to load the next 4 variables:
 % - tsne1
 % - tsne2
 % - names
 % - classes

%% Randomnes monitor
   RandStream.setGlobalStream( RandStream('mt19937ar','Seed',0) ) ;
   x = [] ; y = [] ;
   
for m = 1 : 10
   
%% Choose randomly a training subset
   idx1 = find( strcmp(classes,'unstim') > 0 ) ; idx1 = idx1( randperm(numel(idx1)) ) ; idx1 = idx1(1:floor(0.6*numel(idx1))) ;
   idx2 = find( strcmp(classes,'EPO30')+strcmp(classes,'EPO60') > 0 ) ; idx2 = idx2( randperm(numel(idx2)) ) ; idx2 = idx2(1:floor(0.6*numel(idx2))) ;
   index = [ idx1(1:min([numel(idx1),numel(idx2)])) ; idx2(1:min([numel(idx1),numel(idx2)])) ] ;
   gscatter( tsne1(index),tsne2(index),classes(index) ) ;
   superclass1 = names(idx1) ;
   superclass2 = names(idx2) ;
   
%% Trains the SVM
   idx1 = zeros(1,numel(names))' ; for k = 1:numel(superclass1) ; idx1 = idx1 + strcmp(names,superclass1{k}) ; end ; idx1 = idx1 > 0 ;
   idx2 = zeros(1,numel(names))' ; for k = 1:numel(superclass2) ; idx2 = idx2 + strcmp(names,superclass2{k}) ; end ; idx2 = idx2 > 0 ;
   svmo = svmtrain( [ [tsne1(idx1);tsne1(idx2)] [tsne2(idx1);tsne2(idx2)] ],[ zeros(sum(idx1),1);ones(sum(idx2),1) ],'ShowPlot',true,'kernel_function','quadratic') ;

%% The optimum surface
   axesHandle = svmo.FigureHandles{1} ; 
   childHandles = get(axesHandle,'children') ;
   hggroupHandle = childHandles(1) ;
   surfaceHandle = get(hggroupHandle, 'children') ;
   xvals = get(surfaceHandle, 'XData') ;
   yvals = get(surfaceHandle, 'YData') ; 
   if ( iscell(xvals) == 1 )
       if ( numel(xvals{1}) > numel(xvals{2}) ) 
           xvals = xvals{1} ;
           yvals = yvals{1} ;
       else
           xvals = xvals{2} ;
           yvals = yvals{2} ;
       end%if
   end%if
   xvals(isnan(xvals(:))) = [] ; x = [ x(:) ; xvals(:) ] ;
   yvals(isnan(yvals(:))) = [] ; y = [ y(:) ; yvals(:) ] ;
   m = ( yvals(2)-yvals(1) )/( xvals(2)-xvals(1) ) ; % only for linear kernel
   b = yvals(1) - m*xvals(1) ;                       % only for linear kernel
   
end%for

%% Fitting data to an elipse
   cla ;
   [zb, ab, bb, alphab] = fitellipse([x,y]','linear') ;
   plotellipse(zb, ab, bb, alphab, 'b--')
   h = findobj(gca,'Type','line') ; 
   xe = get(h,'Xdata') ;
   ye = get(h,'Ydata') ;
   
%% Plots
   cla ;
   hold on ;
   gscatter( tsne1,tsne2,classes ) ;
   plot( x,y,'x','MarkerSize',3,'Color',0.5*ones(1,3) ) ;
   plot( smooth(xe),smooth(ye),'k-','LineWidth',2,'Color',0.4*ones(1,3) ) ;
   hold off ;
   grid on ;
   
%% Classification
   outsite_ellipse = inv(ab^2)*( (tsne1 - zb(1))*cos(alphab) + (tsne2 - zb(2))*sin(alphab) ).^2 + inv(bb^2)*( -(tsne1 - zb(1))*sin(alphab) + (tsne2 - zb(2))*cos(alphab) ).^2 < 1 ;
