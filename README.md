# Dual Deconvolution Algorithm

This repository includes simplified Matlab codes that demonstrate the principles of dual deconvolution algorithm.

## System Requirements
The codes were developed and tested on a 64-bit Microsoft Windows 11 and Linux systems using MATLAB version R2020a, R2021a, R2022a, R2023a. R2024a, R2024b, and R2025a. 
Signal processing toolbox and image processing toolbox must be properly installed during the Matlab download process.
Some subfunctions are implemented as MEX functions written in C++ to enhance performance. Precompiled MEX executable files for Microsoft Windows systems and the corresponding C++ source code are provided. If you wish to run the code on a linux system, please compile the MEX source code on that system for use. The dual-deconvolution algorithm is memory-intensive and requires at least 64 GB of RAM (128 GB is recommended for optimal performance).

## Code and Sample Datasets

Please download the code and data from the repository's 'code' and 'data' tabs, respectively. Place the the downloaded zip files in the same directory and extract them.

### Directory Structure:

- `\Root_Dir`
  - `\code`
    - `main.m`  - Main execution code
    - `\subfunctions`  - Contains Matlab subcodes
  - `\data`
    - `Beads_A488.mat`
    - `Beads_A488.bin`
    - `COS7_Cell.mat`
    - `COS7_Cell.bin`
    - `USAF.mat`
    - `USAF.bin`

### Usage
Execute `main.m` in the code directory.  
Three raw datasets are available:
1. **USAF**: Data for Fig. 4(f-k) in the manuscript.  
2. **Beads_A488**: Data for Fig. 4(a-e) in the manuscript.  
3. **COS7_Cell**: Data for Fig. 5(a,b) in the manuscript.  

Each dataset consists of a pair of files: a `.mat` file and a `.bin` file.  
The `.mat` file contains metadata related to the dataset, while the `.bin` file stores the raw camera images in a binary format.





