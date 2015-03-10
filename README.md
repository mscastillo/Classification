Classification
==============

This repository includes different scripts to perform clustering and classification analyses.


# `SVM_classification` [:octocat:](https://github.com/mscastillo/Classification/tree/master/SVM_classification)

Suite of MATLAB scripts to disect two subpopulation in a 2D data set using Support Vectors Machine (SVM). Despite the name of the variables, the analysis can be applied to the results of the tSNE or any other dimensional reduction analysis.

### Inputs

1. Import into MATLAB's workspace the next four variables.
 ```matlab
whos('tsne1','tsne2','classes','names')
%  Name         Size          Bytes     Class
%  classes      805x1         98442      cell
%  names        805x1        111090      cell
%  tsne1        805x1          6440    double
%  tsne2        805x1          6440    double
 ```
2. Additional inputs are required depending on the trainning subset.

 [`tSNE_SVM_supervised.m`](https://github.com/mscastillo/Classification/tree/master/SVM_classification)
 
 The training data set is matually picked by giving the classes of the two subpoulation. See details at the beginning of the script. The Optimum surface is computed them using a linear kerner. See documentation to use an alternative one.

 [`tSNE_SVM_bootstrapping.m`](https://github.com/mscastillo/Classification/tree/master/SVM_classification)
 
 This approach combines SVM with bootstrapping to compute the optimum boundary disecting the two subpopulations. Instead of choose the whole data, the training data set is sampled from the two subpoulations and the optimum surface is computed using a quadratic kernel. This process is repeated one hundred times and all the optimum surfaces are ensemble using a least squared ellipse fit. This scripts depends on `fitellipse.m` and `plotellipse.m` from [MATLAB Central](http://www.mathworks.com/matlabcentral/fileexchange/15125-fitellipse-m).



# `GMM_clustering` [:octocat:](https://github.com/mscastillo/Analyses/tree/master/GMM_clustering)

![Clustering using GMM](https://raw.githubusercontent.com/mscastillo/FSE/master/Examples/gmm_clustering.jpg)

