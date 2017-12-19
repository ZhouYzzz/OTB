startup;

seqs=configSeqsOTB100;

features=configFeaturesOTB100;

ANA(seqs, features);

%figure
t=clock;
t=uint8(t(2:end));
disp([num2str(t(1)) '/' num2str(t(2)) ' ' num2str(t(3)) ':' num2str(t(4)) ':' num2str(t(5))]);
