function seqs = configSeqsOTB100
%% OTB 100 seqs
%cache_path = fullfile(get_global_variable('workspace_path'),'cache','seqs_OTB100.mat');
%if exist(cache_path, 'file')
%    display(['Loading sequence cache file : ' cache_path]);
%    load(cache_path);
%    return;
%end

%display('Automatic construct sequences information...');
seqs = {};
fid = fopen(fullfile(get_global_variable('workspace_path'),'sequences','seqlist_selected.txt'),'r');

sequences_root = fullfile(get_global_variable('workspace_path'),'sequences');

while true
	sName = fgetl(fid);
	if (sName == -1), break; end;
	s = construct(sequences_root, sName);
	seqs = cat(2, seqs, s); % append seqs list
end

fclose(fid);

% add anno to all seqs
atts = {
    'IV'    ,...Illumination Variation
    'SV'    ,...Scale Variation
    'OCC'   ,...Occlusion
    'DEF'   ,...Deformation
    'MB'    ,...Motion Blur
    'FM'    ,...Fast Motion
    'IPR'   ,...In-Plane Rotation
    'OPR'   ,...Out-of-Plane Rotation
    'OV'    ,...Out-of-View
    'BC'    ,...Background Clutters
    'LR'    ,...Low Resolution
};

att_seq_list = cell(1,length(atts));
for idxAtt = 1:length(atts);
    fid = fopen(fullfile(get_global_variable('workspace_path'),'anno','att',[atts{idxAtt} '.txt']));
    if (fid == -1), error('IO ERROR, NO FILE'); end;
    fstr = fgetl(fid);
    seqs_list = strsplit(fstr,', ');
    att_seq_list{idxAtt} = seqs_list;
    fclose(fid);
end

for idxSeq = 1:length(seqs)
    s = seqs{idxSeq};
    display([s.name, '_att']);
    att = zeros(1,length(atts));
    for idxAtt = 1:length(atts)
        att(idxAtt) = ismember(s.name, att_seq_list{idxAtt}); % check if seq's name is in att' seqs list
    end
    s.att = att;
    seqs{idxSeq} = s;
end

%display(['Saving cache file to : ' cache_path]);
%save(cache_path, 'seqs');
end

function s = construct(root, sName)
    %% seqs with 2 targets
    if (strcmp(sName, 'Skating2'))
        s1 = get_seq('Skating2.1', fullfile(root, 'Skating2.1'), 'groundtruth_rect.1.txt');
        s2 = get_seq('Skating2.2', fullfile(root, 'Skating2.2'), 'groundtruth_rect.2.txt');
        s = {s1, s2};
        return;
    end
    if (strcmp(sName, 'Jogging'))
        s1 = get_seq('Jogging.1', fullfile(root, 'Jogging.1'), 'groundtruth_rect.1.txt');
        s2 = get_seq('Jogging.2', fullfile(root, 'Jogging.2'), 'groundtruth_rect.2.txt');
        s = {s1, s2};
        return;
    end
    %% seqs with different gtfilename
    if (strcmp(sName, 'Human4'))
        s = {get_seq('Human4.2', fullfile(root, 'Human4.2'), 'groundtruth_rect.2.txt')};
        return;
    end

    %% default
    s = {get_seq(sName, fullfile(root, sName), 'groundtruth_rect.txt')};
end
%% e.g. get_seq('Jogging', 'path/to/Jogging.1', 'groundtruth_rect.1.txt');
function s = get_seq(sName, sDir, gtfilename)
    disp(sName);
    s = struct();
    s.name = sName;
    s.path = sDir;

    s.nz = 4;
    if (strcmp(sName, 'Board')), s.nz = 5; end;
    s.ext = 'jpg';

    %% count frames and read groundtruth
    s.startFrame = 1;
    s.groundtruth_rect = dlmread(fullfile(sDir,gtfilename));
    s.endFrame = size(s.groundtruth_rect, 1);
    if (strcmp(sName, 'David')), s.startFrame = 300; s.endFrame = 770; end;
    if (strcmp(sName, 'Football1')), s.endFrame = 74; end;
    if (strcmp(sName, 'Freeman3')), s.endFrame = 460; end;
    if (strcmp(sName, 'Freeman4')), s.endFrame = 283; end;
    if (strcmp(sName, 'BlurCar1')), s.startFrame = 247; s.endFrame = 988; end;
    if (strcmp(sName, 'BlurCar3')), s.startFrame = 3; s.endFrame = 359; end;
    if (strcmp(sName, 'BlurCar4')), s.startFrame = 18; s.endFrame = 397; end;
    if (strcmp(sName, 'Tiger1')), s.startFrame = 6; s.endFrame = 354; s.groundtruth_rect = s.groundtruth_rect(s.startFrame:s.endFrame,:); end;
end
