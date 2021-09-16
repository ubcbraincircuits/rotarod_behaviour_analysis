# rotarod_behaviour_analysis
![alt text](https://github.com/ubcbraincircuits/rotarod_behaviour_analysis/blob/main/Mouseandfootsips.JPG)
1) Paw Analysis: MATLAB Analysis of rotarod behaviour, particularly paw movements, from deeplabcut (DLC) tracking  
Scripts:  
Rotarodpositions.m - Analyzes foot slips, paw height, SD of paw height, and more over time from DLC .csv files  
Rotarodpositions_individual.m - Same but used for an individual file rather than a folder of files  
  
2) Photometry Analysis: Aligning rotarod paw data to fiber photometry GCAMP and RCAMP data  
Scripts:  
rotarod_Deeplabcut_photometry.m - Aligns foot slip data from CSV files to photometry data (TDT files)
Footslips_Photometry_Averages.m - Averaging of previously analyzed photometry data from previous script
Footslips_Photometry_Normalization.m - Normalizes baseline period of photometry data before foot slip occurs  
