function writeToLog( stringMsg )

path = '/home/alfre/Documents/Unimib/Tesina/neuralSpikes/matlab/';

fid = fopen(fullfile(path, 'LogFile.txt'), 'a');
if fid == -1
  error('Cannot open log file.');
end
fprintf(fid, '%s: %s\n', datestr(now, 0), stringMsg);
fclose(fid);

end