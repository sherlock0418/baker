
Read Me
This folder stores data and analysis codes related to the paper "???". All the results of the study and observed data are contained in the following Matlab struct and codes.

 (1) Subject.mat
Syntax: 
load Subject Subject
Subject(1)
Description:
This struct summarizes the observed data and model fitting results for each subject (40 people). The fields of the struct are as follows.
nirs: Oxidized blood hemoglobin concentration in each brain region (rostral (ch3), dorsolateral (ch7), and ventral lateral (ch8)) observed in the experiment.
price: Price sequence used in the experiment.
rtn: Return sequence used in the experiment, created by adding white noise to the fundamental returns.
full_price: Price sequence used in the experiment (including out of decision range).
full_rtn: Return sequence used in the experiment (including out of decision range).
fundamental_rtn: Fundamental return used in the experiment.
noize: White noise category used in the experiment.
noise_scale: Standard deviation of the white noise used in the experiment.
investment: Investment rate sequence observed in the experiment
flt: Normalized sequences of investment rate and oxidized blood hemoglobin concentration.
ramda: Parameter corresponding to the cost per unit of information in the Matejka and McKay 2015 model
llh_MM: Log-likelihood in the Matejka and McKay 2015 model
aic_MM: Akaike's information criterion in the Matejka and McKay 2015 model
R2_MM: Rate of improvement of the log-likelihood from random predictions in the Matejka and McKay 2015 model
kappa: Parameter corresponding to Kalman gain in the Sims 2003 model (Models1-6).
llh_Sims: Log-likelihood in the Sims 2003 model (Model1-6)
aic_Sims: Akaike's information criterion in the Sims 2003 model (Model1-6).
R2_Sims: Rate of improvement of log-likelihood from random predictions in the Sims 2003 model (Model1-6).
gamma: Parameter used in Model 3 of the Sims 2003 model.
delta: Parameter used in Model4 of the Sims2003 model.

(2) time_series.m
Syntax: 
time_series(Subject)
Description: 
This function plots the time series data of the price used in the experiment, the investment rate observed in the experiment, and the concentration of hemoglobin in oxidized blood in each brain region (rostral (ch3), dorsolateral (ch7), and ventral lateral (ch8)) for each subject. Each figure will be saved as a fig file and then written out as a ppt file.
 
(3)investment_nirs.m
Syntax: 
investment_nirs(Subject)
Description: 
This function shows a scatter plot of the magnitude of the variation in the investment rate (variance) and the change in the oxidized blood hemoglobin concentration (period mean) for all subjects. Each figure will be saved as a fig file and then written out as a ppt file.

(4) fitting_MM2015.m
Syntax: 
Subject = fitting_ MM 2003(Subject)
Description: 
This function conducts a fitting of the observed investment rate to the Matejka and McKay 2015 model. The estimated parameters É…, the log-likelihood, Akaike's information criterion, and the percentage improvement in the log-likelihood from random predictions are stored in the structure.

(5) fitting_Sims2003.m
Syntax: 
Subject = fitting_Sims2003(Subject)
Description: 
This function conducts the fitting of the observed investment rates to the Sims 2003 models (Models1-6). The estimated parameters É», É¡ (Model3), É¬ (Model4), the log-likelihood, Akaike's information criterion, and the percentage improvement in the log-likelihood from random forecasts are stored in the structure.

(6) ramda_nirs.m
Syntax: 
ramda_nirs(Subject)
Description: 
This function shows a scatter plot of the parameter É… estimated by model fitting and the change in oxidized blood hemoglobin concentration (period average) for all subjects. Each figure will be saved as a fig file and then written out as a ppt file.

(7) ramda_nirs_quantile_analysis.m
Syntax: 
ramda_nirs_quantile_analysis(Subject)
Description: 
This function performs a quantile analysis (dichotomous and trichotomous) of the relationship between the parameter É… estimated by model fitting and the change in oxidized blood hemoglobin concentration (period mean). The results are divided into quartiles according to the magnitude of the parameter values, and the differences in the distribution of changes in blood hemoglobin concentration for each quartile are tested. The mean value of the change in blood hemoglobin concentration for each quartile and the figure of the test statistic will be saved as fig files.

(8) kappa_nirs.m
Syntax: 
kappa_nirs(Subject)
Description: 
This function shows a scatter plot of the parameter É» estimated by model fitting and the change in oxidized blood hemoglobin concentration (period average) for all subjects. Each figure will be saved as a fig file and then written out as a ppt file.

(9) kappa_nirs_quantile_analysis.m
Syntax: 
kappa_nirs_quantile_analysis(Subject)
Description: 
This function performs a quantile analysis (dichotomous and trichotomous) of the relationship between the parameter É» estimated by model fitting and the change in oxidized blood hemoglobin concentration (period mean). The results are divided into quartiles according to the magnitude of the parameter values, and the differences in the distribution of changes in blood hemoglobin concentration for each quartile are tested. The mean value of the change in blood hemoglobin concentration for each quartile and the figure of the test statistic will be saved as fig files.

(10) model_comparison.m
Syntax: 
model_comparison(Subject)
Description: 
This function summarizes the results obtained by model fitting in a table and saves it as an Excel file. The vertical axis of the exported table is, from top to bottom, the log-likelihood mean, the log-likelihood standard deviation, Akaike's information criterion, and the percentage improvement in the log-likelihood from a random prediction. The horizontal axis is, from left to right, the Matejka and McKay 2015 model, the Sims 2003 model (Models1-6).
