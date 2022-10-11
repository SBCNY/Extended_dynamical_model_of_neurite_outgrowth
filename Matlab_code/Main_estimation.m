%% main estimation code
close all;
clc;
clear;

%Global output

NOG_parameters_set_general;
NOG_parameters_vector_set;
NOG_initialConc;
NOG_statevar_set;

statevar_input = statevar;

mean_growth_velocities = [1/60 2/60 4/60 8/60 16/60 20/60];
sd_growth_velocities = mean_growth_velocities * 0.01;
length_growth_velocities = length(mean_growth_velocities);

k_membrane_production = 2 * pi * radius_neurite * mean_growth_velocities(1) * 1.5;
wb = (k_membrane_production + 0.7 * wa * cc2_pm * spm) / (cc1_g * sg);
fraction_bound_kk_a1b1_cg = parameters(index_fraction_bound_kk_a1b1_cg);
fraction_bound_kk_a1b1_mtc = parameters(index_fraction_bound_kk_a1b1_mtc);
kappaYV = parameters(index_kappaYV);

factor_snaresyyvv = statevar(indexS_yy_g); %equals vv_g
kk_g = statevar(indexS_kk_g);

p0 = [ 1 1 1 1 1 1 ];
P_estimate_all = [];

for indexV = 1:1%length_growth_velocities
    sprintf(['run ' num2str(indexV) ' of ' num2str(length_growth_velocities)])
    data = [mean_growth_velocities(indexV) sd_growth_velocities(indexV)];
    
    p0_upper = p0 * 2^(log2(1.05));
    p0_lower = p0 * 2^(-log2(1.05));

    options = optimoptions('fmincon',...
        'Algorithm','sqp','Display','iter','ConstraintTolerance',1e-9);
    options = optimoptions(options,'StepTolerance',1e-9);
    nonlcon = @unitdisk;
    [P_estimate,fval,exitflag,output] = fmincon(@(p) objective(p),p0,[],[],[],[],...                   
                   p0_lower,p0_upper, nonlcon, options);%p0_upper
    P_estimate_all = vertcat(P_estimate_all,P_estimate);
    if (indexV < length_growth_velocity)
        p0 = P_estimate * growth_velocity(indexV + 1) / growth_velocity(indexV);
    end
end
               
               
