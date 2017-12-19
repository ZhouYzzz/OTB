function trackers=configTrackersOTB100
global global_trackers;
global_trackers = {};

%  register_tracker(tName, tDirName, tFunHandle, tSetupFun)
% register_tracker('ECO', 'ECO', 'OTB_DEEP_settings', 'setup_paths');
% register_tracker('ECO_augment', 'ECO_augment', 'OTB_DEEP_test_params_C', 'setup_paths');
register_tracker('ECO_raw', 'ECO', 'whatever', 'whatever');
%register_tracker('ECO_tune_27OCT', 'ECO_augment', 'OTB_DEEP_tune_27OCT', 'setup_paths');
%register_tracker('ECO_tune_28OCT', 'ECO_augment', 'OTB_DEEP_tune_28OCT', 'setup_paths');

% TEST SET 27 OCT(deleted)
% register_tracker('ECO_tune_28OCT6', 'ECO_augment', 'OTB_DEEP_tune_28OCT6', 'setup_paths'); % 0.678, Lemming and Jogging.1

% TEST SET 28 OCT, try to succeed Lemming and Jogging.1 with soft tune
%register_tracker('ECO_tune_28OCT7', 'ECO_augment', 'OTB_DEEP_tune_28OCT7', 'setup_paths');
%register_tracker('ECO_tune_28OCT8', 'ECO_augment', 'OTB_DEEP_tune_28OCT8', 'setup_paths');
%register_tracker('ECO_tune_28OCT9', 'ECO_augment', 'OTB_DEEP_tune_28OCT9', 'setup_paths');
%register_tracker('ECO_tune_28OCT10', 'ECO_augment', 'OTB_DEEP_tune_28OCT10', 'setup_paths');
% register_tracker('ECO_tune_29OCT', 'ECO_augment', 'OTB_DEEP_tune_29OCT', 'setup_paths');
% register_tracker('ECO_tune_29OCT_M', 'ECO_augment', 'OTB_DEEP_tune_29OCT_M', 'setup_paths');
% register_tracker('ECO_tune_29OCT_M2', 'ECO_augment', 'OTB_DEEP_tune_29OCT_M2', 'setup_paths');
% register_tracker('ECO_tune_29OCT_M3', 'ECO_augment', 'OTB_DEEP_tune_29OCT_M3', 'setup_paths');
% register_tracker('ECO_tune_29OCT_M4', 'ECO_augment', 'OTB_DEEP_tune_29OCT_M4', 'setup_paths');
% register_tracker('ECO_tune_29OCT_M5', 'ECO_augment', 'OTB_DEEP_tune_29OCT_M5', 'setup_paths');
register_tracker('ECO_tune_29OCT_M2_G', 'ECO_augment', 'OTB_DEEP_tune_29OCT_M2_G', 'setup_paths');


trackers = global_trackers;
end

function register_tracker(tName, tDirName, tFunHandle, tSetupFun)
    global global_trackers;
    tPath = fullfile(get_global_variable('workspace_path'),'trackers',tDirName);
    if ~exist(tPath, 'dir')
        warning(['Tracker Dir not exist : ' tPath]);
    end
    t = struct();
    t.name = tName;
    t.path = tPath;
    t.runfile = tFunHandle;
    t.fsetup = tSetupFun;
    % t.params = tParams;
    global_trackers{end+1} = t;
end
