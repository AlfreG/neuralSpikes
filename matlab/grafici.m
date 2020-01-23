function grafici(p)

% Draw time and freq graphs
p.saveGraph= false;
p.snrDb = -6;
p.interSpikeType = 4;
p.impulseType=5;
graphSpectr(p)
%graphTime(p)