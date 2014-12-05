Classification
==============

This repository includes scripts to perform different classification analyses.

# `tSNE_SVM_supervised.m`

This *MATLAB* script takes the next four variables:

```matlab
whos('tsne1','tsne2','classes','names')
%  Name         Size          Bytes     Class
%  classes      805x1         98442      cell
%  names        805x1        111090      cell
%  tsne1        805x1          6440    double
%  tsne2        805x1          6440    double
```

and provides the optimum line separating two subpopulations from the whole dataset using the support vectors machine (SVM) technique. The training data set is matually picked by hand. The Optimum surface is computed them using a linear kerner. See documentation to use an alternative one.

# `tSNE_SVM_bootstrapping.m`

This *MATLAB* script takes the next four variables:

```matlab
whos('tsne1','tsne2','classes','names')
%  Name         Size          Bytes     Class
%  classes      805x1         98442      cell
%  names        805x1        111090      cell
%  tsne1        805x1          6440    double
%  tsne2        805x1          6440    double
```

and computes the optimum surface separating two subpopulations from the whole dataset using SVM coupled with bootstrapping. Instead of choose the trainning dataset, this approach randomly pick the 60% of the two subpopulations and computes the corresponding boundry using a quadratic kernel. This is repeated for a hundred times and all the surfaces are ensembled at the end using a least squared ellipse fit.

This scripts depends on the next two functions:

* *fitellipse*
* *plotellipse*

that I have downloaded from [MATLAB Central](http://www.mathworks.com/matlabcentral/fileexchange/15125-fitellipse-m).
