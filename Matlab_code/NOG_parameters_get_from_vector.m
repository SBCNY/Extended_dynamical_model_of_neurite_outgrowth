%% parameters related to sensitivity analysis and parameter estimation


% Define constants parameters

index = 0;

index = index + 1;
Max_size_spm = parameters(index);

index = index + 1;
radius_neurite = parameters(index);

index = index +1;
growth_cone_length = parameters(index);

index = index + 1;
cg_length = parameters(index);

index = index + 1;
distance_mtc_growthConeTip = parameters(index);

index = index + 1;
MTC_length_at_start = parameters(index);

index = index + 1;
MTs_per_crosssection = parameters(index);

index = index + 1;
with_MTC_growth = parameters(index);


% index = index + 1;
% mtBlock_length = parameters(index);
% 
% index = index + 1;
% mtBlock_tubulinDimers = parameters(index);

index = index + 1;
scale_initial_a = parameters(index);

index = index + 1;
scale_exp_a = parameters(index);

index = index + 1;
scale_initial_b = parameters(index);

index = index + 1;
scale_exp_b = parameters(index);

index = index + 1;
shape_m = parameters(index);

index = index + 1;
shape_b = parameters(index);

index = index + 1;
dynMT_degradation_exp_b = parameters(index);

index = index + 1;
dynMT_degradation_multiplier_a = parameters(index);

% Constant Kinesin and dynein velocities
index = index + 1;
velocity_k = parameters(index);

index = index + 1;
velocity_d = parameters(index);

% Constant vesicle surface areas
index = index + 1;
antero_vesicle_surface_area = parameters(index);

index = index + 1;
retro_vesicle_surface_area = parameters(index);

% parameters for SNARE dissociation from coat proteins
index = index + 1;
kxa = parameters(index);

index = index + 1;
kua = parameters(index);

index = index + 1;
kxb = parameters(index);

index = index + 1;
kub = parameters(index);

index = index + 1;
kya = parameters(index);

index = index + 1;
kva = parameters(index);

index = index + 1;
kyb = parameters(index);

index = index + 1;
kvb = parameters(index);

index = index + 1;
snare_binding_spots_per_vesicle_area = parameters(index);

% parameterss for cargo dissociation from coat proteins
index = index + 1;
kc1a = parameters(index);

index = index + 1;
kc1b = parameters(index);

index = index + 1;
kc2a = parameters(index);

index = index + 1;
kc2b = parameters(index);
 
index = index + 1;
cargo_binding_spots_per_vesicle_area = parameters(index);

% parameters for motor protein dissociation from coat proteins
index = index + 1;
kkb = parameters(index);

index = index + 1;
kda = parameters(index);

index = index + 1;
kka = parameters(index);

index = index + 1;
kdb = parameters(index);

index = index + 1;
motor_binding_spots_per_vesicle_area = parameters(index);

% Transmembrane protein production rates
index = index + 1;
k_yy_production = parameters(index);

index = index + 1;
k_vv_production = parameters(index);

index = index + 1;
k_xx_production = parameters(index);

index = index + 1;
k_uu_production = parameters(index);

index = index + 1;
k_kk_production = parameters(index);

index = index + 1;
k_dd_production = parameters(index);

index = index + 1;
k_cc1_production = parameters(index);

index = index + 1;
k_cc2_production = parameters(index);

% Budding rate constants
                
index = index + 1;
wa_g = parameters(index);

index = index + 1;
wa_pm = parameters(index);

index = index + 1;
wb_g = parameters(index);

index = index + 1;
wb_pm = parameters(index);

%Fraction of bound kinesin molecules
index = index + 1;
fraction_bound_kk_a1b1_cg = parameters(index);

index = index + 1;
fraction_bound_kk_a1b1_mtc = parameters(index);

index = index + 1;
fraction_bound_kk_a1b1_cpm = parameters(index);

%Fraction of bound dynein molecules
index = index + 1;
fraction_bound_dd_a2b2_cpm = parameters(index);

index = index + 1;
fraction_bound_dd_a2b2_mtc = parameters(index);

index = index + 1;
fraction_bound_dd_a2b2_cg = parameters(index);

% SNARE complex formation rates
index = index + 1;
kappaXU_g = parameters(index);

index = index + 1;
kappaXU_pm = parameters(index);

index = index + 1;
kappaYV_g = parameters(index);

index = index + 1;
kappaYV_pm = parameters(index);

index = index + 1;
snare_complexes_per_vesicle_fusion = parameters(index);

%%%%%%%%%%% Define special parameters

index = index + 1;
k_membrane_production = parameters(index);

index = index + 1;
nucleation_rate = parameters(index);

index = index + 1;
stabilization_rate = parameters(index);
