# rotarod_behaviour_analysis
![alt text](https://github.com/ubcbraincircuits/rotarod_behaviour_analysis/blob/main/Mouseandfootsips.JPG)
1) MATLAB Analysis of rotarod behaviour, particularly paw movements, from deeplabcut (DLC) tracking  
Scripts:  
Rotarodpositions.m - Analyzes foot slips, paw height, SD of paw height, and more over time from DLC .csv files  
Rotarodpositions_individual.m - Same but used for an individual file rather than a folder of files  
  
2) Aligning rotarod paw data to fiber photometry GCAMP and RCAMP data  
Scripts:  
Footslips_Photometry_Averages.m - Aligns foot slip data from DLC files to photometry data (TDT files)  
Footslips_Photometry_Normalization.m - Normalizes baseline period of photometry data before foot slip occurs  
