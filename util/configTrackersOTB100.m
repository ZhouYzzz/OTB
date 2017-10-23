function trackers=configTrackersOTB100
global global_trackers;
global_trackers = {};

%  register_tracker(tName, tDirName, tFunHandle, tSetupFun)
register_tracker('ECO', 'ECO', 'OTB_DEEP_settings', 'setup_paths');
register_tracker('RAECO', 'ECO_augment', 'VOT2016_DEEP_aug_best_C', 'setup_paths');

trackers = global_trackers;
end

function register_tracker(tName, tDirName, tFunHandle, tSetupFun)
    global global_trackers;
    tPath = fullfile(get_global_variable('workspace_path'),'trackers',tDirName);
    if ~exist(tPath, 'dir')
        error(['Tracker Dir not exist : ' tPath]);
    end
    t = struct();
    t.name = tName;
    t.path = tPath;
    t.runfile = tFunHandle;
    t.fsetup = tSetupFun;
    % t.params = tParams;
    global_trackers{end+1} = t;
end
