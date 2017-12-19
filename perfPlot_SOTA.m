startup;

attPath = './anno/att/'; % The folder that contains the annotation files for sequence attributes

attName={'illumination variation'	'out-of-plane rotation'	'scale variation'	'occlusion'	'deformation'	'motion blur'	'fast motion'	'in-plane rotation'	'out of view'	'background clutter' 'low resolution'};

attFigName={'illumination_variations'	'out-of-plane_rotation'	'scale_variations'	'occlusions'	'deformation'	'blur'	'abrupt_motion'	'in-plane_rotation'	'out-of-view'	'background_clutter' 'low_resolution'};


plotDrawStyleAll={   struct('color',[1,0,0],'lineStyle','-'),...
    struct('color',[0,1,0],'lineStyle','-'),...
    struct('color',[0,0,1],'lineStyle','-'),...
    struct('color',[0,0,0],'lineStyle','-'),...%    struct('color',[1,1,0],'lineStyle','-'),...%yellow
    struct('color',[1,0,1],'lineStyle','-'),...%pink
    struct('color',[0,1,1],'lineStyle','-'),...
    struct('color',[0.5,0.5,0.5],'lineStyle','-'),...%gray-25%
    struct('color',[136,0,21]/255,'lineStyle','-'),...%dark red
    struct('color',[255,127,39]/255,'lineStyle','-'),...%orange
    struct('color',[0,162,232]/255,'lineStyle','-'),...%Turquoise
    struct('color',[163,73,164]/255,'lineStyle','-'),...%purple    %%%%%%%%%%%%%%%%%%%%
    struct('color',[1,0,0],'lineStyle','--'),...
    struct('color',[0,1,0],'lineStyle','--'),...
    struct('color',[0,0,1],'lineStyle','--'),...
    struct('color',[0,0,0],'lineStyle','--'),...%    struct('color',[1,1,0],'lineStyle','--'),...%yellow
    struct('color',[1,0,1],'lineStyle','--'),...%pink
    struct('color',[0,1,1],'lineStyle','--'),...
    struct('color',[0.5,0.5,0.5],'lineStyle','--'),...%gray-25%
    struct('color',[136,0,21]/255,'lineStyle','--'),...%dark red
    struct('color',[255,127,39]/255,'lineStyle','--'),...%orange
    struct('color',[0,162,232]/255,'lineStyle','--'),...%Turquoise
    struct('color',[163,73,164]/255,'lineStyle','--'),...%purple    %%%%%%%%%%%%%%%%%%%
    struct('color',[1,0,0],'lineStyle','-.'),...
    struct('color',[0,1,0],'lineStyle','-.'),...
    struct('color',[0,0,1],'lineStyle','-.'),...
    struct('color',[0,0,0],'lineStyle','-.'),...%    struct('color',[1,1,0],'lineStyle',':'),...%yellow
    struct('color',[1,0,1],'lineStyle','-.'),...%pink
    struct('color',[0,1,1],'lineStyle','-.'),...
    struct('color',[0.5,0.5,0.5],'lineStyle','-.'),...%gray-25%
    struct('color',[136,0,21]/255,'lineStyle','-.'),...%dark red
    struct('color',[255,127,39]/255,'lineStyle','-.'),...%orange
    struct('color',[0,162,232]/255,'lineStyle','-.'),...%Turquoise
    struct('color',[163,73,164]/255,'lineStyle','-.'),...%purple
    };

plotDrawStyle10={   struct('color',[1,0,0],'lineStyle','-'),...
    struct('color',[0,1,0],'lineStyle','--'),...
    struct('color',[0,0,1],'lineStyle',':'),...
    struct('color',[0,0,0],'lineStyle','-'),...%    struct('color',[1,1,0],'lineStyle','-'),...%yellow
    struct('color',[1,0,1],'lineStyle','--'),...%pink
    struct('color',[0,1,1],'lineStyle',':'),...
    struct('color',[0.5,0.5,0.5],'lineStyle','-'),...%gray-25%
    struct('color',[136,0,21]/255,'lineStyle','--'),...%dark red
    struct('color',[255,127,39]/255,'lineStyle',':'),...%orange
    struct('color',[0,162,232]/255,'lineStyle','-'),...%Turquoise
    };

seqs=configSeqsOTB100;

trackers=configTrackersSOTA('otb2015');

% seqs = seqs(1:10);
% trackers = trackers(1:10);

numSeq=length(seqs);
numTrk=length(trackers);

nameTrkAll=cell(numTrk,1);
for idxTrk=1:numTrk
    t = trackers{idxTrk};
    nameTrkAll{idxTrk}=t.name;
end

%nameTrkAll = {'ECO','RAECO'};

nameSeqAll=cell(numSeq,1);
numAllSeq=zeros(numSeq,1);

att=[];
for idxSeq=1:numSeq
    s = seqs{idxSeq};
    nameSeqAll{idxSeq}=s.name;
    
    s.len = s.endFrame - s.startFrame + 1;
    
    numAllSeq(idxSeq) = s.len;
    
    att(idxSeq,:)=s.att;
end

attNum = size(att,2);

figPath = './figs/SOTA/';

perfMatPath = './perfMat/SOTA/';

if ~exist(figPath,'dir')
    mkdir(figPath);
end

if ~exist(perfMatPath,'dir')
    mkdir(perfMatPath);
end

% metricTypeSet = {'overlap'};
metricTypeSet = {'error'};
% evalTypeSet = {'SRE', 'TRE', 'OPE'};
evalTypeSet = {'OPE'};

rankingType = 'AUC';%AUC, threshod

rankNum = 10;%number of plots to show

if rankNum == 10
    plotDrawStyle=plotDrawStyle10;
else
    plotDrawStyle=plotDrawStyleAll;
end

thresholdSetOverlap = 0:0.05:1;
thresholdSetError = 0:50;

for i=1:length(metricTypeSet)
    metricType = metricTypeSet{i};%error,overlap
    
    switch metricType
        case 'overlap'
            thresholdSet = thresholdSetOverlap;
            rankIdx = 11;
            xLabelName = 'Overlap threshold';
            yLabelName = 'Success rate';
        case 'error'
            thresholdSet = thresholdSetError;
            rankIdx = 21;
            xLabelName = 'Location error threshold';
            yLabelName = 'Precision';
    end  
        
    if strcmp(metricType,'error')%&strcmp(rankingType,'AUC')
%         continue;
        rankingType = 'threshold';
    end
    
    tNum = length(thresholdSet);
    
    for j=1:length(evalTypeSet)
        
        evalType = evalTypeSet{j};%SRE, TRE, OPE
        
        plotType = [metricType '_' evalType];
        
        switch metricType
            case 'overlap'
                titleName = ['Success plots of ' evalType];
%                 titleName = evalType;
            case 'error'
                titleName = ['Precision plots of ' evalType];
%                 titleName = evalType;
        end

        dataName = [perfMatPath 'aveSuccessRatePlot_' num2str(numTrk) 'alg_'  plotType '.mat'];
        
        % If the performance Mat file, dataName, does not exist, it will call
        % genPerfMat to generate the file.
        if ~exist(dataName)
            genPerfMat_SOTA(seqs, trackers, evalType, nameTrkAll, perfMatPath);
        end        
        
        load(dataName);
        numTrk = size(aveSuccessRatePlot,1);        
        
        if rankNum > numTrk | rankNum <0
            rankNum = numTrk;
        end
        
        % For table drawing, stop plotting here;
        perSuccess = aveSuccessRatePlot(:,:,thresholdSetOverlap==0.5);
        %% SUCCESS 1-50
%         fid = fopen('/home/zhouyz/Documents/cvpr2018/txt/table_success_1.tex','w');
%         
%         for idxTrk = 1:numTrk
%             fprintf(fid, '& \\textbf{%s} ', nameTrkAll{idxTrk});
%         end
%         fprintf(fid, '\\\\\\hline\n');
%         for idxSeq = 1:50
%             fprintf(fid, '%-12s', seqs{idxSeq}.name);
%             perMax = max(perSuccess(:, idxSeq));
% 
%             for idxTrk = 1:numTrk
%                     fprintf(fid, '& %.3f ', perSuccess(idxTrk, idxSeq));
%             end
%             fprintf(fid, '\\\\ \\hline \n');
%         end
%         fprintf(fid, '\\textbf{mean}');
%         meanSuccess = mean(perSuccess(:, 1:50),2);
%         for idxTrk = 1:numTrk
%             fprintf(fid, '& \\textbf{%.3f} ', meanSuccess(idxTrk));
%         end
%         fprintf(fid, '\\\\\\hline\n');
%         fclose(fid);
        
        %% SUCCESS 51-100
%         fid = fopen('/home/zhouyz/Documents/cvpr2018/txt/table_success_2.tex','w');
%         
%         for idxTrk = 1:numTrk
%             fprintf(fid, '& \\textbf{%s} ', nameTrkAll{idxTrk});
%         end
%         fprintf(fid, '\\\\\\hline\n');
%         for idxSeq = 51:100
%             fprintf(fid, '%-12s', seqs{idxSeq}.name);
%             perMax = max(perSuccess(:, idxSeq));
% 
%             for idxTrk = 1:numTrk
%                     fprintf(fid, '& %.3f ', perSuccess(idxTrk, idxSeq));
%             end
%             fprintf(fid, '\\\\ \\hline \n');
%         end
%         fprintf(fid, '\\textbf{mean}');
%         meanSuccess = mean(perSuccess(:, 51:100),2);
%         for idxTrk = 1:numTrk
%             fprintf(fid, '& \\textbf{%.3f}', meanSuccess(idxTrk));
%         end
%         fprintf(fid, '\\\\\\hline\n');
%         fclose(fid);

    
        perPrecision = aveSuccessRatePlot(:,:,thresholdSetError == 20);
        %% PRECISON 1-50
        fid = fopen('/home/zhouyz/Documents/cvpr2018/txt/table_success_3.tex','w');
        
        for idxTrk = 1:numTrk
            fprintf(fid, '& \\textbf{%s} ', nameTrkAll{idxTrk});
        end
        fprintf(fid, '\\\\\\hline\n');
        for idxSeq = 1:50
            fprintf(fid, '%-12s', seqs{idxSeq}.name);
            perMax = max(perPrecision(:, idxSeq));

            for idxTrk = 1:numTrk
                    fprintf(fid, '& %.3f ', perPrecision(idxTrk, idxSeq));
            end
            fprintf(fid, '\\\\ \\hline \n');
        end
        fprintf(fid, '\\textbf{mean}');
        meanPrecision = mean(perPrecision(:, 1:50),2);
        for idxTrk = 1:numTrk
            fprintf(fid, '& \\textbf{%.3f}', meanPrecision(idxTrk));
        end
        fprintf(fid, '\\\\\\hline\n');
        fclose(fid);
        
        %% PRECISON 51-100
        fid = fopen('/home/zhouyz/Documents/cvpr2018/txt/table_success_4.tex','w');
        
        for idxTrk = 1:numTrk
            fprintf(fid, '& \\textbf{%s} ', nameTrkAll{idxTrk});
        end
        fprintf(fid, '\\\\\\hline\n');
        for idxSeq = 51:100
            fprintf(fid, '%-12s', seqs{idxSeq}.name);
            perMax = max(perPrecision(:, idxSeq));

            for idxTrk = 1:numTrk
                    fprintf(fid, '& %.3f ', perPrecision(idxTrk, idxSeq));
            end
            fprintf(fid, '\\\\ \\hline \n');
        end
        fprintf(fid, '\\textbf{mean}');
        meanPrecision = mean(perPrecision(:, 51:100),2);
        for idxTrk = 1:numTrk
            fprintf(fid, '& \\textbf{%.3f}', meanPrecision(idxTrk));
        end
        fprintf(fid, '\\\\\\hline\n');
        fclose(fid);
        return;
        %% =========================
        figName= [figPath 'quality_plot_' plotType '_' rankingType];
        idxSeqSet = 1:length(seqs);
        
        % draw and save the overall performance plot
        plotDrawSave(numTrk,plotDrawStyle,aveSuccessRatePlot,idxSeqSet,rankNum,rankingType,rankIdx,nameTrkAll,thresholdSet,titleName, xLabelName,yLabelName,figName,metricType);
        
        % draw and save the performance plot for each attribute
        attTrld = 0;
        for attIdx=1:attNum
            
            idxSeqSet=find(att(:,attIdx)>attTrld);
            
            if length(idxSeqSet) < 2
                continue;
            end
            disp([attName{attIdx} ' ' num2str(length(idxSeqSet))])
            
            figName=[figPath attFigName{attIdx} '_'  plotType '_' rankingType];
            titleName = ['Plots of ' evalType ': ' attName{attIdx} ' (' num2str(length(idxSeqSet)) ')'];
            
            switch metricType
                case 'overlap'
%                     titleName = ['Success plots of ' evalType ' - ' attName{attIdx} ' (' num2str(length(idxSeqSet)) ')'];
                    titleName = [attName{attIdx} ' (' num2str(length(idxSeqSet)) ')'];
                case 'error'
%                     titleName = ['Precision plots of ' evalType ' - ' attName{attIdx} ' (' num2str(length(idxSeqSet)) ')'];
                    titleName = [attName{attIdx} ' (' num2str(length(idxSeqSet)) ')'];
            end
            
            plotDrawSave(numTrk,plotDrawStyle,aveSuccessRatePlot,idxSeqSet,rankNum,rankingType,rankIdx,nameTrkAll,thresholdSet,titleName, xLabelName,yLabelName,figName,metricType);
        end        
    end
end
