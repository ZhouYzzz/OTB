startup;

seqs=configSeqsOTB100;

features=configFeaturesOTB100;

%% START ANA PLOT
evalType='ANA';

diary(['./tmp/' evalType '.txt']);

finalPath = ['./results/results_' evalType '_CVPR13/'];
plotDrawStyleAll={
    struct('color',[1,0,0],'lineStyle','-','lineWidth',3),...
    struct('color',[0,1,0],'lineStyle','-','lineWidth',3),...
    struct('color',[0,0,1],'lineStyle','-','lineWidth',3),...
    struct('color',[0,1,1],'lineStyle','-','lineWidth',3),...
    struct('color',[1,0,0],'lineStyle','--','lineWidth',3),...
    struct('color',[0,1,0],'lineStyle','--','lineWidth',3),...
    struct('color',[0,0,1],'lineStyle','--','lineWidth',3),...
    struct('color',[0,1,1],'lineStyle','--','lineWidth',3),...
};
% plotDrawStyleAll={
%     struct('color',[1,0,0],'lineStyle','--','lineWidth',3),...
%     struct('color',[0,1,0],'lineStyle','--','lineWidth',3),...
%     struct('color',[0,0,1],'lineStyle','--','lineWidth',3),...
%     struct('color',[0,0,0],'lineStyle','--','lineWidth',3),...
% };
numSeq = length(seqs);
numFtr = length(features);

persistency_cell = cell(numFtr,numSeq);
equivalency_cell = cell(numFtr,numSeq);
response_cell = cell(numFtr,numSeq);

angles = [];

for idxSeq = 1:numSeq
    s = seqs{idxSeq};

    for idxFtr = 1:numFtr
        t = features{idxFtr};
        disp([s.name '_' t.name]);
        if exist([finalPath s.name '_' t.name '.mat'])
            load([finalPath s.name '_' t.name '.mat']);
            bfail=isempty(results);
            if bfail
                disp(['ERROR ' s.name ' '  t.name]);
                break;
            end
        end
        persistency_cell{idxFtr,idxSeq} = results{1}.persistency';
        equivalency_cell{idxFtr,idxSeq} = results{1}.equivalency';
        response_cell{idxFtr,idxSeq} = results{1}.response';
        
        if isempty(angles),angles = results{1}.angles';end;
    end
end
figure(1); title('persistency Plot'); hold on;
figure(2); title('equivalencyesentativeness Plot'); hold on;
figure(3); title('Response Plot'); hold on;
for idxFtr = 1:numFtr
persistency = cell2mat(persistency_cell(idxFtr,:));
equivalency = cell2mat(equivalency_cell(idxFtr,:));
response = cell2mat(response_cell(idxFtr,:));
fprintf('%s, %f +- %f, %f +- %f, %f +- %f\n', features{idxFtr}.name, 1-mean(persistency(:)), sqrt(var(mean(persistency,1))),1-mean(equivalency(:)),sqrt(var(mean(equivalency,1))),mean(response(:)),sqrt(var(mean(response,1))) );
persistency_mean = mean(persistency,2);
equivalency_mean = mean(equivalency,2);
resp_mean = mean(response,2);
if idxFtr==1, resp_norm = resp_mean(1);end;

% fprintf
resp_mean = resp_mean / max(resp_mean);
% resp_mean = resp_mean / resp_norm;
figure(1); plot(angles,persistency_mean,plotDrawStyleAll{idxFtr});
figure(2); plot(angles,equivalency_mean,plotDrawStyleAll{idxFtr});
figure(3); plot(angles,resp_mean,plotDrawStyleAll{idxFtr});
end
features = [features{:}];
figure(1);legend({features.name});
figure(2);legend({features.name});
figure(3);legend({features.name});