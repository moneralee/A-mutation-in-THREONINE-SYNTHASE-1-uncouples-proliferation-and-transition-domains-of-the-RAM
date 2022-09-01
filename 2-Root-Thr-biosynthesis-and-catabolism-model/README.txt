This folder contains R scripts for the in silico root simulations shown in the manuscript “A  mutation in THREONINE SYNTHASE 1 uncouples proliferation and transition domains of the root apical meristem”.
Authors: Monica L. Garcia-Gomez, Blanca Jazmin Reyes-Hernandez, Debee Prasad Sahoo, Selene Napsucialy-Mendivil,Aranza Xhaly Quintana-Armas, Jose Antonio Pedroza-Garcia, Svetlana Shishkova, Hector Hugo Torres-Martinez, Mario A. Pacheco-Escobedo, and Joseph G. Dubrovsky, 2022

First run “Threonine-model-catabolism.R”, and then “Threonine-model-Functions-catabolism.R”. 
The folder output will have a folder per simulation (Wt, mto22, double mutant, ts2) with root images, and .csv files storing cells’ properties (coordinates, cell type,TS1, TSY2, Threonine content). For default, only Wt and mto22 simulations will run. If you wish to run the other options, uncomment them. 

For the simulations to run properly, be sure to install the following packages: viridis and deSolve