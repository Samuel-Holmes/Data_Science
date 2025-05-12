# Binary Classifier Wisconsin Breast Cancer Data Set

## Project Context 

This project aims to employ supervised machine learning in the R programming language to successfully predict benign and malignant tumours based upon other variables within the dataset. Such as, cell size, shape and thickness. 

## Steps Taken 

Preproccesing of data:

* Loaded and opened the file to check that it presented as expected
* Checked for missing values to ensure completeness and accuracy
* Highlighted 16 missing values and decided upon an appropriate imputation method (predictive mean matching used)

## Determination of Model

* Given that class is binary a logistical regression model will be used as this use case is appropriate
* Plotted a correlation matrix to establish predictor variables for the model (used cell size, shape and bare nuclei as predictor variables)

## Training & Testing Split

The training and testing split is established using probability and random sampling. That is to say that each row in the full dataset has a 70% chance of being assigned to the training set and a 30% chance of being assigned to the testing set.

## Model Fit Assessment

McFaddens R^2 score test was used to assess the models fit with a score of > 0.4 indicating a good model fit 

## Summary and Conclusions 

This project provided useful insight into the impactful applications of machine learning and how they along with technology can be utilised to maximise societal welfare. Given that this was my first data science project I was pleased with the outcome, however there is great scope to improve my understanding and technique in the subject area going forward. 
