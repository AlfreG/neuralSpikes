% Main folder
cd /home/alfre/Documents/Unimib/Tesina/neuralSpikes/matlab;

addpath('/home/alfre/Documents/Unimib/Tesina/neuralSpikes/matlab/altro', '-begin');
addpath('/home/alfre/Documents/Unimib/Tesina/neuralSpikes/matlab/filtering', '-begin');
addpath('/home/alfre/Documents/Unimib/Tesina/neuralSpikes/matlab/fixedPoint', '-begin');
addpath('/home/alfre/Documents/Unimib/Tesina/neuralSpikes/matlab/filterTheory', '-begin');
addpath('/home/alfre/Documents/Unimib/Tesina/neuralSpikes/matlab/data', '-begin');
addpath('/home/alfre/Documents/Unimib/Tesina/neuralSpikes/matlab/genGraph', '-begin');
addpath('/home/alfre/Documents/Unimib/Tesina/neuralSpikes/matlab/testSignal', '-begin');
addpath('/home/alfre/Documents/Unimib/Tesina/neuralSpikes/matlab/dataMining', '-begin');
addpath('/home/alfre/Documents/Unimib/Tesina/neuralSpikes/matlab/results', '-begin');
addpath('/home/alfre/Documents/Unimib/Tesina/neuralSpikes/matlab/parameter', '-begin');

% Remove all variables from the current MATLAB® workspace
clear;clc;

% Set simulation parameters
makeParam;
makeP1;

% Load Spikes data
data = importSpikes;

% % Load Diapason data
% % importFile('diapason.wav')
% % importFile('voce.mp3')
% % load('data/data.mat');
% % load('data/fs.mat');