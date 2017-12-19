
function trackers=configTrackersOTB100
global global_trackers;
global_trackers = {};

%  register_tracker(tName, tDirName, tFunHandle, tSetupFun)
% register_tracker('CN', 'ECO_augment', 'ANA_DEEP_cn', 'setup_paths');
% register_tracker('Norm1', 'ECO_augment', 'ANA_DEEP_norm1', 'setup_paths');
% register_tracker('ReLU5', 'ECO_augment', 'ANA_DEEP_relu5', 'setup_paths');
% register_tracker('HOG', 'ECO_augment', 'ANA_DEEP_hog', 'setup_paths');

% register_tracker('CN_45', 'ECO_augment', 'ANA_DEEP_cn_45', 'setup_paths');
% register_tracker('Norm1_45', 'ECO_augment', 'ANA_DEEP_norm1_45', 'setup_paths');
% register_tracker('ReLU5_45', 'ECO_augment', 'ANA_DEEP_relu5_45', 'setup_paths');
% register_tracker('HOG_45', 'ECO_augment', 'ANA_DEEP_hog_45', 'setup_paths');

% register_tracker('CN_aug_OTB', 'ECO_augment', 'ANA_DEEP_cn_aug', 'setup_paths');
% register_tracker('Norm1_aug_OTB', 'ECO_augment', 'ANA_DEEP_norm1_aug', 'setup_paths');
% register_tracker('ReLU5_aug_OTB', 'ECO_augment', 'ANA_DEEP_relu5_aug', 'setup_paths');
% register_tracker('HOG_aug_OTB', 'ECO_augment', 'ANA_DEEP_hog_aug', 'setup_paths');

% register_tracker('CN_aug_OTB_3', 'ECO_augment', 'ANA_DEEP_cn_aug_3', 'setup_paths');
% register_tracker('Norm1_aug_OTB_3', 'ECO_augment', 'ANA_DEEP_norm1_aug_3', 'setup_paths');
% register_tracker('ReLU5_aug_OTB_3', 'ECO_augment', 'ANA_DEEP_relu5_aug_3', 'setup_paths');
% register_tracker('HOG_aug_OTB_3', 'ECO_augment', 'ANA_DEEP_hog_aug_3', 'setup_paths');

% register_tracker('CN_cubic', 'ECO_augment', 'ANA_DEEP_cn_cubic', 'setup_paths');
% register_tracker('Norm1_cubic', 'ECO_augment', 'ANA_DEEP_norm1_cubic', 'setup_paths');
% register_tracker('ReLU5_cubic', 'ECO_augment', 'ANA_DEEP_relu5_cubic', 'setup_paths');
% register_tracker('HOG_cubic', 'ECO_augment', 'ANA_DEEP_hog_cubic', 'setup_paths');

%%%%

%% PE EVALUATION
% register_tracker('CN_PE', 'ECO_augment', 'ANA_cn_PE', 'setup_paths');
% register_tracker('CONV1_PE', 'ECO_augment', 'ANA_conv1_PE', 'setup_paths');
% register_tracker('CONV5_PE', 'ECO_augment', 'ANA_conv5_PE', 'setup_paths');
% register_tracker('HOG_PE', 'ECO_augment', 'ANA_hog_PE', 'setup_paths');

% new use a larger uniform iwndow that is almost the whole image
% register_tracker('CN_PE_NEW', 'ECO_augment', 'ANA_cn_PE', 'setup_paths');
% register_tracker('CONV1_PE_NEW', 'ECO_augment', 'ANA_conv1_PE', 'setup_paths');
% register_tracker('CONV5_PE_NEW', 'ECO_augment', 'ANA_conv5_PE', 'setup_paths');
% register_tracker('HOG_PE_NEW', 'ECO_augment', 'ANA_hog_PE', 'setup_paths');

register_tracker('CN_PE_NEW2', 'ECO_augment', 'ANA_cn_PE', 'setup_paths');
register_tracker('CONV1_PE_NEW2', 'ECO_augment', 'ANA_conv1_PE', 'setup_paths');
register_tracker('CONV5_PE_NEW2', 'ECO_augment', 'ANA_conv5_PE', 'setup_paths');
register_tracker('HOG_PE_NEW2', 'ECO_augment', 'ANA_hog_PE', 'setup_paths');

%% RESPONSE
% register_tracker('CN_R', 'ECO_augment', 'ANA_cn_R', 'setup_paths');
% register_tracker('CONV1_R', 'ECO_augment', 'ANA_conv1_R', 'setup_paths');
% register_tracker('CONV5_R', 'ECO_augment', 'ANA_conv5_R', 'setup_paths');
% register_tracker('HOG_R', 'ECO_augment', 'ANA_hog_R', 'setup_paths');

%% RESPONSE WITH AUGMNET
% register_tracker('CN_RA', 'ECO_augment', 'ANA_cn_RA', 'setup_paths');
% register_tracker('CONV1_RA', 'ECO_augment', 'ANA_conv1_RA', 'setup_paths');
% register_tracker('CONV5_RA', 'ECO_augment', 'ANA_conv5_RA', 'setup_paths');
% register_tracker('HOG_RA', 'ECO_augment', 'ANA_hog_RA', 'setup_paths');

% register_tracker('CONV1_RA_1', 'ECO_augment', 'ANA_conv1_RA_1', 'setup_paths');
% register_tracker('CONV1_RA_5', 'ECO_augment', 'ANA_conv1_RA_5', 'setup_paths');
% register_tracker('CONV1_RA_7', 'ECO_augment', 'ANA_conv1_RA_7', 'setup_paths');
% register_tracker('CONV1_RA_9', 'ECO_augment', 'ANA_conv1_RA_9', 'setup_paths');

% register_tracker('CONV1_RAU_1', 'ECO_augment', 'ANA_conv1_RAU_1', 'setup_paths');
% register_tracker('CONV1_RAU_2', 'ECO_augment', 'ANA_conv1_RAU_2', 'setup_paths');
% register_tracker('CONV1_RAU_3', 'ECO_augment', 'ANA_conv1_RAU_3', 'setup_paths');
% register_tracker('CONV1_RAU_4', 'ECO_augment', 'ANA_conv1_RAU_4', 'setup_paths');

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
