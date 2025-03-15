
% Description:
% Example code for displaying two-photon fluorescence microscopy (TPFM), confocal TPFM, 
% SIM, and dual-deconvoluved SIM images.
% Three raw Experimental datasets for differnt type of samples can be loaded and processed.
 
%% ---- clear --------------------------------------
clearvars; close all; clc;
addpath(genpath('./'));

%% --- load raw data from file --------------------------------------
% Select the filename of the data to load. 
% Three raw data sets are aviable:

filename = '../data/USAF.mat';          % (1) USAF target in Fig. 4(f-i)
% filename = '../data/Beads_A488.mat';  % (2) Alexa-488 gold beads in Fig. 4(a-c)
% filename = '../data/COS7_Cell.mat';   % (3) COS-7 cell in Fig. 5(a-b) 

psim_data = load_raw_data(filename);

%% ---- set parameters -----------------------------------------------
precision = 'single';     % specify precision: 'sinlge' or 'double'
                          % Sinlge precision is recommended due to the memory-intensive nature of the code.
green = flip(circshift(hot(256),1,2),2);     % green colormap
x_coord = psim_data.scan_info.x_coords;     % X and Y coordinates for displaying images
y_coord = psim_data.scan_info.y_coords;

%% ---- image preprocessing ------------------------------------------
psim_data = remove_bg_offset(psim_data, precision);

%% --- generate two-photon fluorescence microscopy image -------------
TPFM_image = gen_two_photon_image(psim_data, precision);

h_fig = figure(1);
h_fig.Name = 'Conventional two-photon fluorescence image';
imagesc(x_coord, y_coord, TPFM_image)
axis image
colormap(green)
colorbar
title('2PFM image')
xlabel ('x (\mum)')
ylabel ('y (\mum)')
drawnow

%% --- generate confocal two-photon fluorescence image ----------------
pinhole_radius_in_um = 0.2;     % radius of confocal pinhole in micrometer
CTPFM_image  = gen_confocal_image(psim_data, pinhole_radius_in_um, precision);

h_fig = figure(2);
h_fig.Name = 'Two-photon excitation and confocal detection';
imagesc(x_coord, y_coord, CTPFM_image)
axis image
colormap(green)
colorbar
title('Confocal 2PFM image')
xlabel ('x (\mum)')
ylabel ('y (\mum)')
drawnow

%% ---- construct incoherent response matrix, Fkk = F(ko, ki) -------
[Fkk, otf_params] = gen_Fkk(psim_data, precision);

%% ---- reconstruct 2PSIM image without aberration correction -------
TPSIM_image = SIM_image_from_Fkk(Fkk, otf_params);

h_fig = figure(3);
h_fig.Name = 'Two-photon SIM image without aberration correction';
imagesc(x_coord, y_coord, TPSIM_image)
axis image
colormap(green)
colorbar
title('2PSIM image')
xlabel ('x (\mum)')
ylabel ('y (\mum)')
drawnow

%% ---------- generate AO-2PSIM image -------------------------------

% Setting parameters for dual deconvolution
deconv_params = psim_data.deconv_params;    % By default, optimal parameters for dual deconvolution are preloaded.

% You can customize the parameters by uncommenting and modifying the lines below:
% deconv_params.max_iter = 5;      % Maximum number of iterations
% deconv_params.iter_tol = 1E-4;   % Iteration Stopping criterion for OTF error (tolerance)
% deconv_params.N_cutoff_k = 8;    % Cutoff frequency for DC filtering, specified in pixels
% deconv_params.alpha = 9E-5;      % Noise-to-signal ratio (NSR) for the Wiener filter applied to W(ko, ki)
% deconv_params.beta = 0.15;       % NSR for the Wiener filter applied to the object spectrum G(dk)
% deconv_params.gamma = 3E-3;      % NSR for the Wiener filters applied to excitation and emission OTFs, H_ex(ki) and H_em(ko)
% deconv_params.iterN_lucy = 2;    % Number of iterations for Lucy-Richardson deconvolution (used when dec_type = 0)
% deconv_params.dec_type = 0;      % Deconvolution method: 0 = Lucy-Richardson (faster, avoids ringing), 1 = Wiener

deconv_params.x_coord = x_coord; % for figure 
deconv_params.y_coord = y_coord;

% dual deconvolution: reconstruct AO_2PSIM image by dual deconvolution
[AO2PSIM_image, H_ex_map, H_em_map] = dual_deconv(Fkk, otf_params, deconv_params);

%% comparison with blind deconvolution

% ---- blind deconvolution of TPFM image -------
initial_PSF = fspecial('gaussian', size(TPFM_image,1), 3); % initial guess
[TPFM_image_deconv, ~] = deconvblind(TPFM_image, initial_PSF, 5);

h_fig = figure(11);
h_fig.Name = 'blind deconvolution of two-photon image';
imagesc(x_coord, y_coord, TPFM_image_deconv)
axis image
colormap(green)
colorbar
title('TPFM\_image\_deconv')
xlabel ('x (\mum)')
ylabel ('y (\mum)')

% ---- blind deconvolution of confocal TPFM image -------
initial_PSF = fspecial('gaussian', size(TPFM_image,1), 3); % initial guess
[CTPFM_image_deconv, ~] = deconvblind(CTPFM_image, initial_PSF, 10);

h_fig = figure(12);
h_fig.Name = 'blind deconvolution of confocal two-photon image';
imagesc(x_coord, y_coord, CTPFM_image_deconv)
axis image
colormap(green)
colorbar
title('CTPFM\_image\_deconv')
xlabel ('x (\mum)')
ylabel ('y (\mum)')

% ---- blind deconvolution of 2PSIM image -------
initial_PSF = fspecial('gaussian', size(TPFM_image,1), 6); % initial guess
[TPSIM_image_deconv, ~] = deconvblind(TPSIM_image, initial_PSF, 5);

h_fig = figure(32);
h_fig.Name = 'blind deconvolution of confocal 2PSIM image';
imagesc(x_coord, y_coord, TPSIM_image_deconv)
axis image
colormap(green)
colorbar
title('TPSIM\_image\_deconv')
xlabel ('x (\mum)')
ylabel ('y (\mum)')

drawnow


