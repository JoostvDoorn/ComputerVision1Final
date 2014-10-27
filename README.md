# Computer Vision 1 Final project

Joost van Doorn - 10805176
Tran Cong Nguyen - 10867481
Roger Wechsler - 10850007

*University of Amsterdam 2014*

**Dependencies**


The following two external libraries should be installed and loaded to Matlab's namespace initially:
- libsvm (http://www.csie.ntu.edu.tw/~cjlin/libsvm/#matlab)
- VLFeat (http://www.vlfeat.org/install-matlab.html)

**Directories**


The functions expect the data to be in the data/ directory. Each category has two directories, one for the training images and one for the test images (e.g. airplaines_test and airplanes_train).

All batch functions are created to automatically store results in the results/ folder, and to store the intermediate results.
This has the advantage that further training runs will be processed faster as intermediate results will be loaded from external files.

**Files**


Single training files are designed to run after eachother for one specific setting, they are split into the following files
* train.m - Builds the visual vocabulary and calculates the visual descriptions for all training images.
* trainsvm.m - Trains a SVM classifier for each class (1-vs-all).
* evaluation.m - Evaluates the test set on the trained classifiers.
* demoRun.m - Illustrates how one entire run of training and evaluation is performed.

Batch training files automatically train multiple models with the specified settings.
* runTrainingMulti.m - Used to build the visual vocabulary and train the SVMs
* trainSVMs.m - Used to automically retrain the SVMs for different settings, uses the histograms, visual vocabulary and classLabels in the results/ folder.
* runEvaluationMulti.m - Used to automatically evaluate all the trained SVMs using the test set. Will output a LaTeX compatible table format in results/table0.txt (linear kernel), results/table1.txt (polynomial kernel) and results/table2.txt (RBF kernel).

The following files are functions used by the training and evaluation scripts and do not need to be adjusted.
* addToResultTable.m - Outputs the evaluation results in a LaTeX table.
* assignVisualWords.m - Returns a histogram of visual words for descriptors.
* buildVisualVoc.m - Builds the visual vocabulary (codebook).
* colorSift.m - Extraction of color SIFT descriptors.
* convertColor.m - Color conversion for feature extraction.
* createRankedList.m - Creates ranked lists of the best predictions for each category.
* evaluate.m - Computes the evaluation (average precision) for a test set.
* featureExtraction.m - Wrapper function that controls the different extraction options.
* getData.m - Returns data from the training or test set for all classes.
* getSubsetFromData.m - Returns a subset of images files for all classes.
* getVisualDescriptions.m - Computes the visual descriptions for a set of images.
* grayscaleSift.m - Extracts grayscale SIFT descriptors.
* splitDataset.m - Splits set of images into a set to build the codebook and into another one for training the classifiers.


