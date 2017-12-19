startup;

seqs=configSeqs_selected;

trackers=configTrackersOTB100;

OPE(seqs, trackers);

figure
t=clock;
t=uint8(t(2:end));
disp([num2str(t(1)) '/' num2str(t(2)) ' ' num2str(t(3)) ':' num2str(t(4)) ':' num2str(t(5))]);
