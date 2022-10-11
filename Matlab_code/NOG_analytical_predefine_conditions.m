%Set fixed rates
NOG_parameters_set_general;

MTC_length_at_start = 20;
cycling_rate = 0.5;
anticipated_fraction_of_bound_b1_vesicles_in_mtc = 0.1;
anticipated_fraction_of_fusing_b1_vesicles_in_cpm = 0.1;
anticipated_fraction_of_bound_a2_vesicles_in_mtc = 0.9;
anticipated_fraction_of_fusing_a2_vesicles_in_cg = 0.9;
%anticipated_fraction_of_bound_b1_vesicles_in_cg = 0.95;
%anticipated_fraction_of_bound_a2_vesicles_in_cpm = 0.95;

nb1_cg = 0.03;%initial_forward_transport_rate / anticipated_fraction_of_bound_b1_vesicles_in_cg;
na2_cpm = 0.14;%initial_backtransport_rate / anticipated_fraction_of_bound_a2_vesicles_in_cpm;

effective_tubulin = 9;
effective_dyn_MTs_length = MTC_length_at_start;
max_effective_tubulin = 10;

anterograde_vesicle_surface_area = 0.05;
SNARE_complexes_per_vesicle_fusion = 5;
spm = 50;
sg = 50;
s3 = MTC_length_at_start * 2 * pi * radius_neurite;
xx_g_start = 20000;%1.9908e+04;
yy_pm_start = 20000;%2.0097e+04;
with_MTC_growth = true;
fraction_bound_dd_a2b2_mtc = 0.84;
fraction_bound_kk_a1b1_mtc = 0.0815;


max_target_snares_at_one_compartment = 1e20000;
max_vesicle_snares_at_one_compartment = 2e6;
max_total_vesicle_snares_V_for_figures = 2e4;

%Set varying values
kappaYV_pm_start = 5e-06; %8.5e-07;
kappaXU_g = 8e-06; %7.73e-06;
velocities_per_hour = [0 2.5 5 7.5 10 12.5 15 17.5 20];%[0 2.5 5 7.5 10 12.5 15 17.5 20];
kappaYV_decrements = [0.01e-7 0.01e-7 0.01e-7 0.005e-7 0.005e-7 0.005e-7 0.005e-7 0.005e-7 0.005e-7];

%Set values for single run
velocity_per_hour = 5;
kappaYV_pm = 2e-06; %2e-06 is standard
xx_g = xx_g_start;
yy_pm = yy_pm_start;