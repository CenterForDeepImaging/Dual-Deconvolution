# Dual Deconvolution Algorithm

This software package provides key algorithms for dual-deconvolution microscopy analysis. The dual-deconvolution algorithm is an advanced deep-tissue imaging technique designed to measure fluorescence signals from thick, aberrated samples. It incorporates virtual structured illumination microscopy (SIM) and computational adaptive optics to achieve super-resolution imaging.

The reference URL available on the archive: : https://doi.org/10.48550/arXiv.2404.11849

## System Requirements
The code has been validated for use in MATLAB R2020a, R2021a, R2022a, R2023a, R2024a, R2024b, and R2025a environments. Two essential toolboxes must be installed during the MATLAB installation process: the Signal Processing Toolbox and the Image Processing Toolbox.

Some subfunctions are implemented as MEX functions written in C++ to enhance performance. Precompiled MEX executable files for Microsoft Windows systems and the corresponding C++ source code are provided. If you wish to run the code on a linux system, please compile the MEX source code on that system for use. The dual-deconvolution algorithm is memory-intensive and requires at least 64 GB of RAM (128 GB is recommended for optimal performance).

All code and datasets have been developed and tested by Seok-chan Yoon (Pusan University) and Su-min Lim (Korea University), members of the Super-Depth Imaging Group (https://www.bioimaging.korea.ac.kr/).

## Code and Sample Datasets

The package only includes comprehensive algorithm implementations to facilitate the broader adoption of dual-deconvolution in deep-tissue imaging applications.

The experimental data for this code can be downloaded from the following link on Figshare as follows: https://doi.org/10.6084/m9.figshare.28600847.v1

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





