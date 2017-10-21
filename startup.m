function startup
clc; clear; close all; warning off all;

workspace_path = fileparts(mfilename('fullpath'));
set_global_variable('workspace_path', workspace_path);

addpath(fullfile(workspace_path, 'util'));
addpath(fullfile(workspace_path, 'rstEval'));

set_global_variable('eval_type', 'OPE');

end