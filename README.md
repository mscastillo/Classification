Classification
==============

This repository includes different scripts to perform clustering and classification analyses.


# `SVM_classification` [:octocat:](https://github.com/mscastillo/Classification/tree/master/SVM_classification)

Suite of MATLAB scripts to disect two subpopulation in a 2D data set using Support Vectors Machine (SVM). Despite the name of the variables, the analysis can be applied to the results of the tSNE or any other dimensional reduction analysis.

### Inputs

1. Import into MATLAB's workspace the next four variables: `whos('tsne1','tsne2','classes','names')`
2. Additional inputs are required depending on the trainning subset.

 ####[`tSNE_SVM_supervised.m`](https://github.com/mscastillo/Classification/tree/master/SVM_classification)
 
 The training data set is matually picked by giving the classes of the two subpoulation. See details at the beginning of the script. The Optimum surface is computed them using a linear kerner. See documentation to use an alternative one.

 ####[`tSNE_SVM_bootstrapping.m`](https://github.com/mscastillo/Classification/tree/master/SVM_classification)
 
 This approach combines SVM with bootstrapping to compute the optimum boundary disecting the two subpopulations. Instead of choose the whole data, the training data set is sampled from the two subpoulations and the optimum surface is computed using a quadratic kernel. This process is repeated one hundred times and all the optimum surfaces are ensemble using a least squared ellipse fit. This scripts depends on `fitellipse.m` and `plotellipse.m` from [MATLAB Central](http://www.mathworks.com/matlabcentral/fileexchange/15125-fitellipse-m).

### Outputs

The script outputs a scatter-plot with the optimum boundare surface diseccting the two subpopulations.


# `GMM_clustering` [:octocat:](https://github.com/mscastillo/Classification/tree/master/GMM_clustering)

This script performs a clustering analysis using Gaussian Mixture Model (GMM).

> [Constrained mixture estimation for analysis and robust
classification of clinical time series](http://bioinformatics.oxfordjournals.org/content/25/12/i6). Bioinformatics (2009).

### Dependencies

The main script, `gmm_clustering.m`, computes the GMM with different modes using the *gmdistribution* function from MATLAB's statistical toolbox. To interact with the model, the custom user's interface files `gui.fig` and `gui.m` are required.

### Inputs 

1. Data is read from a table in CSV or Excel file with a header, dscribing the variables names, and the next columns: (*i*) an unique identifier with the samples names, (*ii*) the class name to which each sample belongs, (*iii*) the *X* coordinates and (*iv*) the *Y* coordinates. Find an example in [here](https://github.com/mscastillo/Classification/tree/master/Examples)
2. `K`, the maximum number of modes. This parameter could be an integer or any of the next strings (that we use a multiple of the actusal number of classes in the dataset): `'one'`, `'two'`, `'three'`, ...`'ten'`. Notice that text strings are defined between single quotes. By default is set to `'two'`.
3. `seed`, the random generator's seed. For repeatability, the randomness is controlled by fixing the seed of the random generator. By default,it set as zero. Use any other value to generate alternative solutions.

### Outputs

The main script will compute the data densite of the dataset and all GMM from 1 to `K` Gaussian components into the mix. The results of each single model will be plotted as a heatmap overlaping the GMM (with white dots indicating the mean of the Gaussian modes) and a 3D plot. In addition, the [Akaike information criterion](http://en.wikipedia.org/wiki/Akaike_information_criterion) is computed and its evolution throgh all the models plotted. A trend lins is plot when a stable level is reached.

![Clustering using GMM](https://raw.githubusercontent.com/mscastillo/FSE/master/Examples/gmm_clustering.jpg)

After computing all models, the GUI gets open and any of the GMM for a given number of modes can be plotted with the classification results using the chosen GMM. Use the slider to choose the number of modes and compare the clustering results with the original input data set. For a given data set, the clustering results can be reported provinding which data belongs to a specific mode and theirs hyperparameters by doing click on <kdb>Export</kdb>.


