# A-mutation-in-THREONINE-SYNTHASE-1-uncouples-proliferation-and-transition-domains-of-the-RAM
This folder contains R scripts for the in silico root simulations shown in the manuscript “A mutation in THREONINE SYNTHASE 1 uncouples proliferation and transition domains of the root apical meristem”. 
Authors: Monica L. Garcia-Gomez, Blanca Jazmin Reyes-Hernandez, Debee Prasad Sahoo, Selene Napsucialy-Mendivil,Aranza Xhaly Quintana-Armas, Jose Antonio Pedroza-Garcia, Svetlana Shishkova, Hector Hugo Torres-Martinez, Mario A. Pacheco-Escobedo, and Joseph G. Dubrovsky, 2022  

Simulations for the role of Thr biosynthesis enzymes (1-Simulation) and both Thr biosynthesis and catabolism enzymes (2-Simulation) are included.In each case first run “Threonine-functions.R”, and then “Threonine-model.R”. The folder output will have a folder per simulation (Wt, mto22, double mutant, ts2) with root images, .csv files storing cells’ properties (coordinates, cell type,TS1, TSY2, Threonine content), and plots.For default, only Wt and mto22 simulations will run. If you wish to run the other options, uncomment them. 


For the simulations to run properly, be sure to install the following packages: viridis and deSolve
