function OPE(seqs, trackers)
%% Perform OPE Evaluation
evalType='OPE';

diary(['./tmp/' evalType '.txt']);

finalPath = ['./results/results_' evalType '_CVPR13/'];

numSeq = length(seqs);
numTrk = length(trackers);

if ~exist(finalPath,'dir')
    mkdir(finalPath);
end

tmpRes_path = ['./tmp/' evalType '/'];
bSaveImage = false;

if ~exist(tmpRes_path,'dir')
    mkdir(tmpRes_path);
end

for idxSeq = 1:numSeq
    s = seqs{idxSeq};
    s.len = s.endFrame - s.startFrame + 1;
    s.s_frames = cell(s.len,1);
    fmtstr = ['%0' num2str(s.nz) 'd.' s.ext];
    for i=1:s.len
        s.s_frames{i} = sprintf(fullfile(s.path,'img',fmtstr), s.startFrame + i - 1);
    end

    numSeg = 20;
    rect_anno = s.groundtruth_rect;
    [subSeqs, subAnno]=splitSeqTRE(s,numSeg,rect_anno);

    %% case 'OPE'
    subS = subSeqs{1};
    subSeqs=[];
    subSeqs{1} = subS;
    
    subA = subAnno{1};
    subAnno=[];
    subAnno{1} = subA;

    for idxTrk = 1:numTrk
        t = trackers{idxTrk};

        if exist([finalPath s.name '_' t.name '.mat'])
            load([finalPath s.name '_' t.name '.mat']);
            bfail=checkResult(results, subAnno);
            if bfail
                disp([s.name ' '  t.name]);
            end
            continue;
        end
        results = [];
        for idx=1:length(subSeqs)
            disp([num2str(idxTrk) '_' t.name ', ' num2str(idxSeq) '_' s.name ': ' num2str(idx) '/' num2str(length(subSeqs))])       

            rp = [tmpRes_path s.name '_' t.name '_' num2str(idx) '/'];
            if bSaveImage&~exist(rp,'dir')
                mkdir(rp);
            end
            
            subS = subSeqs{idx};
            
            subS.name = [subS.name '_' num2str(idx)];
            
            funcName = ['res=' t.runfile '(subS, rp, bSaveImage);'];

            try
                cd(t.path);
                % addpath(genpath('./'));
                eval(t.fsetup);
                eval(funcName);
                
                rmpath(genpath('./'))
                cd(get_global_variable('workspace_path'));
                
                if isempty(res)
                    results = [];
                    break;
                end
            catch err
                disp(getReport(err));
                rmpath(genpath('./'))
                cd(get_global_variable('workspace_path'));
                res=[];
                continue;
            end
            
            res.len = subS.len;
            res.annoBegin = subS.annoBegin;
            res.startFrame = subS.startFrame;
            results{idx} = res;
        end
        save([finalPath s.name '_' t.name '.mat'], 'results');
    end

end

end
