function result = testQuant(p, plot)
% test quantization effects
% p parameters' struct
% plot true, false


%% generate quantized signal
signal = mySignal(p);
T = switchType('fixed16');
    signalFi = cast(signal,'like',T.b);



%% filter set up
[b, a] = butter(p.filterOrder, 2*p.cutOffFreq/p.sampleRate,p.filterType);   % H = B / A
    bFi = cast(b.*2^16,'like',T.b);
    aFi = cast(b.*2^16,'like',T.b);


%% filtering 
size = round( p.duration*p.sampleRate);
filters = zeros(size,10);

filters(:,1) =      filter( b, a, signal );
filters(:,2) = myFiltering( b, a, signal, [0 0], 'Direct1', T);
filters(:,3) = myFiltering( b, a, signal, [0 0], 'Direct2', T);


%% statistics
mid = round(size/2);
filters = double(filters);  % necessary to compute the norm 

for i=1:1:3
    result(i,1) = norm( filters(:,1)-filters(:,i) , 2);
        result(i,2) = norm( filters(1:mid,1)-filters(1:mid,i) , 2);
        result(i,3) = norm( filters(mid+1:end,1)-filters(mid+1:end,i) ,2);
end


%% Graphs

if plot == true
    
subplot(2,1,1), % time domain 
    plot(1:size, [ signal filters(:,:) ]); 
    grid ON;
%     legend('signal','matlab','d1','d2','d1*','d2*');
    title('sampleRate=9kHz, sin.freq=500Hz, sin.freq=1kHz');
%     axis([0 30 0 6])
    xlabel('sample');

    
subplot(2,1,2), % frequences domain
    span = size - mid;
    tier = round(size/3);
    
    y = 20*log10(abs(sfft(signal))); 
    z = 20*log10(abs(sfft(filters(:,1))));
    
    plot(log10(1:1+tier),  [y(mid:mid+tier) z(mid:mid+tier) y(mid:mid+tier)-z(mid:mid+tier)] );
%   line([x1 x2],[y1 y2]);
%   axis([4500 5500 -50 120])
    grid ON;
    title('fft, HighPass.ButterW.Order=2.CutOffFreq=500Hz');
%   legend('signal','filteredSignal','diff')
    xlabel('Hz');
    ylabel('dB');
end

end
