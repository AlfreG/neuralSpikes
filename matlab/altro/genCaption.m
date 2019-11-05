function caption = genCaption(p,u,s)
% name save and close graph
% generate .tex file to support caption editing

    chap = s.chap;
    sect = s.sect;
    desc = s.desc;
    fileName = [chap sect];
    xts = s.xts;
    path = s.path;
    
%             '$w_{-}=2pi$' ...
%             num2str(p.lowFreq) u.lowFreq ...    
%             ', ' ...
%             '$w_{+}=2pi$' ...
%             num2str(p.highFreq) u.highFreq ...    
%             '. ' ...
%             'SNR = ' num2str(p.snrDb) ' dB.'
            %
    
    caption = [ '$\nu_{l}=$' ...
            num2str(p.lowFreq) u.lowFreq ...    
            ', ' ...
            '$\nu_{h}=$' ...
            num2str(p.highFreq) u.highFreq ...
            '$\nu$ ' ...
            num2str(p.sampleRate/1000) u.sampleRate ...
            ',' ...
            '$N=$ ' ...
            num2str(p.samplesNumber) ...
            ' SAMPLES.'];
    
    if p.saveGraph == true
    
    % save and close figure
    saveas(gcf, [path fileName], xts);
    close;
    
    % save caption
    fileID = fopen([path fileName '.tex'],'w');
    fprintf(fileID, [ s.desc '.' caption] );
    fclose(fileID);
    
    end

end