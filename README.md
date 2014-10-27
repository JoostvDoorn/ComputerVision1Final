# Computer Vision 1 Final project
By Roger Wechsler, Tran Cong Nguyen and Joost van Doorn
*University of Amsterdam 2014*

The functions expect the data to be in the data/ directory. All batch functions are created to automatically store results in the results/ folder, and to store the intermediate results.

Single training files are designed to run after eachother for one specific setting, they are split into two files:
* runTraining.m - Builds the visual vocabulary and trains the SVM.
* evaluate.m - Tests the vocabulary on the test set.

Batch training files automatically train multiple models with the specified settings.
* runTrainingMulti.m - Used to build the visual vocabulary and train the SVMs
* trainSVMs.m - Used to automically retrain the SVMs for different settings, uses the histograms and classLabels in the results/ folder.
* runEvaluationMulti.m - Used to automatically evaluate all the trained SVMs using the test set. Will output a LaTeX compatible table format in results/table0.txt (linear kernel), results/table1.txt (polynomial kernel) and results/table2.txt (RBF kernel).

