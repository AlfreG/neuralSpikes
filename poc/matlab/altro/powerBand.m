function [power, tot] = powerBand( y, lowFreq, highFreq, sampleSize, sampleRate)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

tot = bandArea(y.^2,        0, sampleRate/2, sampleSize, sampleRate);

power = [ bandArea(y.^2,        0,      lowFreq, sampleSize, sampleRate)./tot ...
          bandArea(y.^2,  lowFreq,     highFreq, sampleSize, sampleRate)./tot ...
          bandArea(y.^2, highFreq, sampleRate/2, sampleSize, sampleRate)./tot ...
        ];

% Normalized total power
tot = tot;

end

