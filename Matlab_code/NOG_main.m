clc;
clear;
close all;

tic;
% Main

global Output_fluxes Output_time

tspan = [0 1500];

NOG_initialConc;
NOG_analytical_predefine_conditions;
            
% velocity_per_hour = 10; %out of balance
% kappaYV_pm = 2.6455e-06; %out of balance
% initial_velocity = velocity_per_hour; %out of balance
% initial_kappaYV_pm = kappaYV_pm; %out of balance

NOG_analytical_predict_concentrations_and_parameter;
if (~accepted_combination)
   ME = MException('see above');
   throw(ME);
end

% NOG_analytical_outOfBalance_setFirstPredictedValues; %out of balance
% 
% velocity_per_hour = 5; %out of balance
% kappaYV_pm = 2.328e-06; %out of balance
% NOG_analytical_predict_concentrations_and_parameter; %out of balance
% if (~accepted_combination) %out of balance
%    ME = MException('see above'); %out of balance
%    throw(ME); %out of balance
% end %out of balance
% NOG_analytical_outOfBalance_resetVariablesFromFirstPrediction; %out of balance
% kappaYV_pm = initial_kappaYV_pm; %out of balance

NOG_parameter_vector_set;
NOG_statevar_set;

statevar_input = statevar;

Output_fluxes = [];
Output_time = [];
timepoint_of_last_common_nucleation1 = 0;
[t,statevar_timelines] = ode15s(@(t,statevar)NOG_function1(t,statevar,parameters,statevar_input,statevar_buffer),tspan, statevar_input);
statevar_last_timepoints = statevar_timelines(end,:)';

NOG_define_expVSpredic;
NOG_plot_statevar_vs_time;
NOG_plot_selectedValues_vs_statevar_paper_figure;
NOG_plot_fluxes_vs_time;

Print_concentration_parameter;
toc;

