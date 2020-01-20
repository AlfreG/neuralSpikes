% Main folder
cd /home/alfre/unimib/Tesina/neuralSpikes/matlab;

addpath('/home/alfre/unimib/Tesina/neuralSpikes/matlab/altro', '-begin');
addpath('/home/alfre/unimib/Tesina/neuralSpikes/matlab/filtering', '-begin');
addpath('/home/alfre/unimib/Tesina/neuralSpikes/matlab/fixedPoint', '-begin');
addpath('/home/alfre/unimib/Tesina/neuralSpikes/matlab/filterTheory', '-begin');
addpath('/home/alfre/unimib/Tesina/neuralSpikes/matlab/data', '-begin');
addpath('/home/alfre/unimib/Tesina/neuralSpikes/matlab/genGraph', '-begin');
addpath('/home/alfre/unimib/Tesina/neuralSpikes/matlab/testSignal', '-begin');
addpath('/home/alfre/unimib/Tesina/neuralSpikes/matlab/dataMining', '-begin');
addpath('/home/alfre/unimib/Tesina/neuralSpikes/matlab/results', '-begin');
addpath('/home/alfre/unimib/Tesina/neuralSpikes/matlab/parameter', '-begin');

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