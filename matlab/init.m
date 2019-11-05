% Main folder
cd /home/alfre/Documents/Unimib/Tesina/spikeFilter/matlab;

addpath('/home/alfre/Documents/Unimib/Tesina/spikeFilter/matlab/altro', '-begin');
addpath('/home/alfre/Documents/Unimib/Tesina/spikeFilter/matlab/filtering', '-begin');
addpath('/home/alfre/Documents/Unimib/Tesina/spikeFilter/matlab/fixedPoint', '-begin');
addpath('/home/alfre/Documents/Unimib/Tesina/spikeFilter/matlab/filterTheory', '-begin');
addpath('/home/alfre/Documents/Unimib/Tesina/spikeFilter/matlab/data', '-begin');
addpath('/home/alfre/Documents/Unimib/Tesina/spikeFilter/matlab/genGraph', '-begin');
addpath('/home/alfre/Documents/Unimib/Tesina/spikeFilter/matlab/testSignal', '-begin');
addpath('/home/alfre/Documents/Unimib/Tesina/spikeFilter/matlab/dataMining', '-begin');
addpath('/home/alfre/Documents/Unimib/Tesina/spikeFilter/matlab/results', '-begin');

% Remove all variables from the current MATLAB® workspace
clear;clc;

% Load parameters and results
load('parameter/param.mat');
load('parameter/units.mat');
load('parameter/graphSorting.mat');
% load('parameter/forms.mat');
% load('parameter/A.mat');
% load('parameter/B.mat');

% Load Spikes data
importSpikes

% % Load Diapason data
% % importFile('diapason.wav')
% % importFile('voce.mp3')
% % load('data/data.mat');
% % load('data/fs.mat');