%% objective function
function SSE = objective(para_est)
tic;

NOG_parameters_set_vector;
NOG_initial_concentrations_steady_state_velocity0;
NOG_statevar_set;

statevar_input = statevar;

parameters(index_wb) = parameters(index_wb) * para_est(1);
parameters(index_wa) = parameters(index_wa) * para_est(2);

parameters(index_kappaYV) = parameters(index_kappaYV) * para_est(3);
statevar_input(indexS_yy_g) = statevar_input(indexS_yy_g) * para_est(3);
statevar_input(indexS_vv_g) = statevar_input(indexS_vv_g) * para_est(3);
statevar_input(indexS_yy_pm) = statevar_input(indexS_yy_pm) * para_est(3);
statevar_input(indexS_vv_pm) = statevar_input(indexS_vv_pm) * para_est(3);

parameters(index_kappaXU) = parameters(index_kappaXU) * para_est(4);
statevar_input(indexS_xx_g) = statevar_input(indexS_xx_g) * para_est(4);
statevar_input(indexS_uu_g) = statevar_input(indexS_uu_g) * para_est(4);
statevar_input(indexS_xx_pm) = statevar_input(indexS_xx_pm) * para_est(4);
statevar_input(indexS_uu_pm) = statevar_input(indexS_uu_pm) * para_est(4);

statevar_input(indexS_kk_g) = statevar_input(indexS_kk_g) * para_est(5);
statevar_input(indexS_kk_pm) = statevar_input(indexS_kk_pm) * para_est(5);

statevar_input(indexS_dd_g) = statevar_input(indexS_dd_g) * para_est(6);
statevar_input(indexS_dd_pm) = statevar_input(indexS_dd_pm) * para_est(6);


% % 
% % parameters(27) = para_est(1); %wb ;
% % % Binding rates of vesicles to motor transport compartment
% % parameters(28) = para_est(2); %lambda1;
% % parameters(29) = para_est(3); %lambda2;
% % % SNARE complex formation rates
% % %kappaXU = parameters(24); % 
% % parameters(32) = para_est(4); %kappaXU
% % % %kappaYV = parameters(25);
% % parameters(33) = para_est(5); %kappaYV 
% % 
% % %%%%%%%%%%
% % % Define special parameters
% % k_membrane_production = para_est(6); %membrane_production; 
% % parameters(34) = k_membrane_production;
% % 
% % nucleation_rate = 0.01; 
% % parameters(35) = nucleation_rate;
% % 
% % stabilization_rate = para_est(7); % stabilization rate 
% % parameters(36) = stabilization_rate;
% % 
% % % tspan = [0 3240];

tspan = [0 3240];

parameters0 = parameters;

[t,statevar_timelines] = ode15s(@(t,statevar)NOG_function1(t,statevar,parameters0),tspan, statevar_input);

NOG_statevar_get_timelines;
 
toc;

NOG_define_expVSpredic;

%Check, if steady state is reached
% length_statevar_timelines = length(statevar_timelines(1,:));
% for indexStatevar = 1:length_statevar_timelines
%    if AND((indexStatevar ~= indexS_s3),...
%           (indexStatevar ~= indexS_stbl_MTs_length),...
%           (indexStatevar ~= indexS_nb1_mtc),(indexStatevar ~= indexS_yy_b1_mtc),(indexStatevar ~= indexS_vv_b1_mtc),(indexStatevar ~= indexS_xx_b1_mtc),(indexStatevar ~= indexS_uu_b1_mtc),(indexStatevar ~= indexS_kk_b1_mtc),(indexStatevar ~= indexS_dd_b1_mtc),(indexStatevar ~= indexS_cc1_b1_mtc),(indexStatevar ~= indexS_cc2_b1_mtc),...
%           (indexStatevar ~= indexS_nb2_mtc),(indexStatevar ~= indexS_yy_b2_mtc),(indexStatevar ~= indexS_vv_b2_mtc),(indexStatevar ~= indexS_xx_b2_mtc),(indexStatevar ~= indexS_uu_b2_mtc),(indexStatevar ~= indexS_kk_b2_mtc),(indexStatevar ~= indexS_dd_b2_mtc),(indexStatevar ~= indexS_cc1_b2_mtc),(indexStatevar ~= indexS_cc2_b2_mtc),...
%           (indexStatevar ~= indexS_na1_mtc),(indexStatevar ~= indexS_yy_a1_mtc),(indexStatevar ~= indexS_vv_a1_mtc),(indexStatevar ~= indexS_xx_a1_mtc),(indexStatevar ~= indexS_uu_a1_mtc),(indexStatevar ~= indexS_kk_a1_mtc),(indexStatevar ~= indexS_dd_a1_mtc),(indexStatevar ~= indexS_cc1_a1_mtc),(indexStatevar ~= indexS_cc2_a1_mtc),...
%           (indexStatevar ~= indexS_na2_mtc),(indexStatevar ~= indexS_yy_a2_mtc),(indexStatevar ~= indexS_vv_a2_mtc),(indexStatevar ~= indexS_xx_a2_mtc),(indexStatevar ~= indexS_uu_a2_mtc),(indexStatevar ~= indexS_kk_a2_mtc),(indexStatevar ~= indexS_dd_a2_mtc),(indexStatevar ~= indexS_cc1_a2_mtc),(indexStatevar ~= indexS_cc2_a2_mtc),...
%           (abs(log2(statevar_timelines(tstart_index,indexStatevar) / statevar_timelines(end,indexStatevar))) > log2_tolerance_deviation))
%            sprintf(['indexStatevar ' num2str(indexStatevar)])
%            sprintf(char(statevar_names{indexStatevar}))
%            ME = MException('differences are out of tolerance');
%            throw(ME);
%    end
% end


%Compare predicted data with experimental data (sr = squared residuals)
sr_sum = 0;
considered_conditions = 0;

for indexPDS = 1:expPreDataStatevar_length
    if expPreDataStatevar_consider(indexPDS)
        mean = expPreDataStatevar_means(indexPDS);
        sd = expPreDataStatevar_sds(indexPDS);
        exp_value = expPreDataStatevar_preValue(indexPDS);
        sr_sum = sr_sum + ((exp_value - mean)/sd)^2;
        considered_conditions = considered_conditions + 1;
    end
end

for indexPDF = 1:expPreDataFluxes_length
    if expPreDataFluxes_consider(indexPDF)
        mean = expPreDataFluxes_means(indexPDF);
        sd = expPreDataFluxes_sds(indexPDF);
        exp_value = expPreDataFluxes_statevarPreValue(indexPDF);
        sr_sum = sr_sum + ((exp_value - mean)/sd)^2;
        considered_conditions = considered_conditions + 1;
    end
end

SSE = sr_sum / considered_conditions;

toc;
