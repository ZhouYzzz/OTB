function seqs = configSeqsOTB100
%% OTB 100 seqs
cache_path = fullfile(get_global_variable('workspace_path'),'cache','seqs_OTB100.mat');
if exist(cache_path, 'file')
    display(['Loading sequence cache file : ' cache_path]);
    load(cache_path);
    return;
end

display('Automatic construct sequences information...');
seqs = {};
fid = fopen(fullfile(get_global_variable('workspace_path'),'sequences','seqlist.txt'),'r');

sequences_root = fullfile(get_global_variable('workspace_path'),'sequences');

while true
	sName = fgetl(fid);
	if (sName == -1), break; end;
	s = construct(sequences_root, sName);
	seqs = cat(2, seqs, s); % append seqs list
end

fclose(fid);
display(['Saving cache file to : ' cache_path]);
save(cache_path, 'seqs');
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
        s = {get_seq('Human4', fullfile(root, 'Human4'), 'groundtruth_rect.2.txt')};
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
    %% count frames and read groundtruth
    s.startFrame = 1;
    s.groundtruth_rect = dlmread(fullfile(sDir,gtfilename));
    s.endFrame = size(s.groundtruth_rect, 1);
    if (strcmp(sName, 'David')), s.startFrame = 300; s.endFrame = 770; end;
    if (strcmp(sName, 'Football1')), s.endFrame = 74; end;
    if (strcmp(sName, 'Freeman3')), s.endFrame = 460; end;
    if (strcmp(sName, 'Freeman4')), s.endFrame = 283; end;
end
