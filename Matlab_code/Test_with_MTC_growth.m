clc;
clear;
close all;

%Set demanded rates
NOG_parameters_set_general;
MTC_length_at_start = 5;
velocity_per_hour = 0;
growth_related_k_membrane_production = velocity_per_hour/60 * 2 * pi * radius_neurite;
cycling_rate = 0.5;
a2_pm_into_cpm = cycling_rate;
anticipated_fraction_of_bound_b1_vesicles_in_mtc = 0.1;
anticipated_fraction_of_bound_a2_vesicles_in_mtc = 0.9;
anterograde_vesicle_surface_area = 0.05;
SNARE_complexes_per_vesicle_fusion = 5;
spm = 50;
sg = 50;
s3 = MTC_length_at_start * 2 * pi * radius_neurite;
xx_pm = 0.4;%8.7579;
xx_g = 20000;%1.9908e+04;
yy_pm = 20000;%2.0097e+04;
yy_g = 0.4;%0.4573;
kappaYV_pm = 8.1e-07; %8.5e-07;
kappaXU_g = 8.1e-06; %7.73e-06;
with_MTC_growth = true;
fraction_bound_dd_a2b2_mtc = 0.84;
fraction_bound_kk_a1b1_mtc = 0.0815;

%Calculate rate of lost surface area in MTC
final_backtransport_rate = cycling_rate;
a2_travel_time_new_MTC = velocity_per_hour / (velocity_d*60);
rate_lost_na2_mtc = final_backtransport_rate * a2_travel_time_new_MTC / anticipated_fraction_of_bound_a2_vesicles_in_mtc;
initial_backtransport_rate = final_backtransport_rate + rate_lost_na2_mtc;

final_forward_transport_rate = initial_backtransport_rate + growth_related_k_membrane_production;
b1_travel_time_new_MTC = velocity_per_hour / (velocity_k*60);
rate_lost_nb1_mtc = final_forward_transport_rate * b1_travel_time_new_MTC / anticipated_fraction_of_bound_b1_vesicles_in_mtc;
initial_forward_transport_rate = final_forward_transport_rate + rate_lost_nb1_mtc;

rate_lost_surface_area_in_mtc = rate_lost_nb1_mtc + rate_lost_na2_mtc;

%Calculate first parameters

ratio_membrane_movement = final_forward_transport_rate / final_backtransport_rate;
sqrt_ratio = sqrt(ratio_membrane_movement);

kappaXU_g = kappaXU_g * sqrt_ratio;%1.7361e-05 * sqrt_ratio;
kappaXU_pm = kappaXU_g * factor_for_site_specific_SNARE_complex_formation;
kappaYV_pm = kappaYV_pm * sqrt_ratio;%0.85*1e-6 * sqrt_ratio;
kappaYV_g = kappaYV_pm * factor_for_site_specific_SNARE_complex_formation;

%Calculate membrane production and budding rates
k_membrane_production = growth_related_k_membrane_production + rate_lost_surface_area_in_mtc;
cc1_g = 100;
wb_g = initial_forward_transport_rate/(cc1_g*sg);  %option to increase cargo is ignored
cc2_pm = 100;
wa_pm = initial_backtransport_rate/(cc2_pm*spm);   %option to increase cargo is ignored
wb_pm = wb_g * factor_for_site_specific_budding;
wa_g = wa_pm * factor_for_site_specific_budding;

%2) Calculate initial vesicle surface areas in compartments
b1_travel_time_mtu_at_start = MTC_length_at_start/velocity_k;
nb1_mtc = final_forward_transport_rate * b1_travel_time_mtu_at_start / anticipated_fraction_of_bound_b1_vesicles_in_mtc;
nb1_cpm = final_forward_transport_rate / anticipated_fraction_of_bound_b1_vesicles_in_mtc;
nb1_cg = 0.1;

na2_cg = final_backtransport_rate / anticipated_fraction_of_bound_a2_vesicles_in_mtc;
a2_travel_time_mtc_at_start = MTC_length_at_start/velocity_d;
na2_mtc = final_backtransport_rate * a2_travel_time_mtc_at_start / anticipated_fraction_of_bound_a2_vesicles_in_mtc;
na2_cpm = 0.1;

%3) Calculate needed vesicle SNAREs in cpm in dependence of Y-SNAREs at pm and kappa_YV_pm
YV_SNARE_complexes_cpm_pm = (final_forward_transport_rate / anterograde_vesicle_surface_area) * SNARE_complexes_per_vesicle_fusion;
vv_b1_cpm = YV_SNARE_complexes_cpm_pm / (kappaYV_pm * yy_pm); %not all SNAREs are available for SNARE complex formation
v_b1_cpm = vv_b1_cpm / nb1_cpm;

%4) Calculate v_forward
v_forward = v_b1_cpm;
vv_final_forward = v_forward * final_forward_transport_rate;
vv_initial_forward = v_forward * initial_forward_transport_rate;
vv_initial_backward = vv_final_forward;
v_backward = vv_initial_backward / initial_backtransport_rate;
rate_lost_vv_b1_mtc = rate_lost_nb1_mtc * v_forward;

%6) Calculate needed vesicle SNAREs in cg in dependence of X-SNAREs at g and kappa_XU_g
XU_SNARE_complexes_cg_g = (final_backtransport_rate / anterograde_vesicle_surface_area) * SNARE_complexes_per_vesicle_fusion;
uu_a2_cg = XU_SNARE_complexes_cg_g / (kappaXU_g * xx_g); %not all SNAREs are available for SNARE complex formation
u_a2_cg = uu_a2_cg / na2_cg;

%7) Calculate uu_backward and uu_forward flux
u_backward = u_a2_cg;%210;
uu_final_backward = u_backward * final_backtransport_rate;
uu_initial_backward = u_backward * initial_backtransport_rate;

uu_final_forward = uu_initial_backward;
u_forward = uu_final_forward / final_forward_transport_rate;
uu_initial_forward = initial_forward_transport_rate * u_forward;

%8) Calculate uu_pm and vv_pm
y_pm = yy_pm / spm;
x_pm = xx_pm / spm;
const_pm = 1 + y_pm/kya + x_pm/kxa;
bs = initial_backtransport_rate * snare_binding_spots_per_vesicle_area;
u_pm =     (uu_initial_backward * const_pm * kua * vv_initial_backward)...
         / ((bs - vv_initial_backward) * (bs - uu_initial_backward) - vv_initial_backward * uu_initial_backward)...
       +   (uu_initial_backward * const_pm * kua)...
         / ((bs - uu_initial_backward) -   (uu_initial_backward * vv_initial_backward)...
                                 / (bs - vv_initial_backward));

uu_pm = u_pm * spm;                             

v_pm =     vv_initial_backward * (u_pm/kua + const_pm) * kva...
         / (bs - vv_initial_backward);
vv_pm = v_pm * spm;

%9) Calculate uu_g and vv_g
y_g = yy_g / sg;
x_g = xx_g / sg;
const_g = 1 + y_g/kyb + x_g/kxb;
fs = initial_forward_transport_rate * snare_binding_spots_per_vesicle_area;
u_g =     (uu_initial_forward * const_g * kub * vv_initial_forward)...
        / ((fs - vv_initial_forward) * (fs - uu_initial_forward) - vv_initial_forward * uu_initial_forward)...
      +   (uu_initial_forward * const_g * kub)...
        / ((fs - uu_initial_forward) -   (uu_initial_forward * vv_initial_forward)...
                               / (fs - vv_initial_forward));

uu_g = u_g * sg;
                              
v_g =    vv_initial_forward * (u_g/kub + const_g) * kvb...
      / (fs - vv_initial_forward);
vv_g = v_g * sg;

%Calculate y and x movements
snare_saturation_denom_1b = (1 + x_g/kxb  + u_g/kub  + y_g/kyb  + v_g/kvb);

syb1 = snare_binding_spots_per_vesicle_area * (y_g/kyb) / snare_saturation_denom_1b;
yy_initial_forward = initial_forward_transport_rate * syb1;
y_forward = yy_initial_forward / initial_forward_transport_rate;

sxb1 = snare_binding_spots_per_vesicle_area * (x_g/kxb) / snare_saturation_denom_1b;
xx_initial_forward = initial_forward_transport_rate * sxb1;
x_forward = xx_initial_forward / initial_forward_transport_rate;

snare_saturation_denom_2a = (1 + x_pm/kxa + u_pm/kua + y_pm/kya + v_pm/kva);

sya2 = snare_binding_spots_per_vesicle_area * (y_pm/kya) / snare_saturation_denom_2a;
yy_initial_backward = initial_backtransport_rate * sxb1;
y_backward = yy_initial_backward / initial_backtransport_rate;

sxa2 = snare_binding_spots_per_vesicle_area * (x_pm/kxa) / snare_saturation_denom_2a;
xx_initial_backward = initial_backtransport_rate * sxa2;
x_backward = xx_initial_backward / initial_backtransport_rate;

%Calculate protein production rates for SNAREs and adopt SNARE amounts at TGN
k_uu_production = rate_lost_nb1_mtc * u_forward + rate_lost_na2_mtc * u_backward; 
k_vv_production = rate_lost_nb1_mtc * v_forward + rate_lost_na2_mtc * v_backward; 
k_yy_production = rate_lost_nb1_mtc * y_forward + rate_lost_na2_mtc * y_backward;
k_xx_production = rate_lost_nb1_mtc * x_forward + rate_lost_na2_mtc * x_backward;

vv_g = max([0 vv_g - k_vv_production]);
uu_g = max([0 uu_g - k_uu_production]);
yy_g = max([0 yy_g - k_yy_production]);
xx_g = max([0 xx_g - k_xx_production]);

%10) Calculate missing variables for vesicular transport
vv_b1_cg = nb1_cg * v_forward;
vv_b1_mtc = nb1_mtc * v_forward;
uu_b1_cg = nb1_cg * u_forward;
uu_b1_mtc = nb1_mtc * u_forward;
uu_b1_cpm = nb1_cpm * u_forward;

vv_a2_cpm = na2_cpm * v_backward;
vv_a2_mtc = na2_mtc * v_backward;
vv_a2_cg = na2_cg * v_backward;
uu_a2_cpm = na2_cpm * u_backward;
uu_a2_mtc = na2_mtc * u_backward;






%10) Calculate kinesin 
k_per_vesicle_b1_mtc = log(1 - anticipated_fraction_of_bound_b1_vesicles_in_mtc) / log(1-fraction_bound_kk_a1b1_mtc);
k_b1_mtc = k_per_vesicle_b1_mtc / anterograde_vesicle_surface_area;
k_forward = k_b1_mtc;
kk_initial_forward = k_forward * initial_forward_transport_rate;
kk_final_forward = k_forward * final_forward_transport_rate;
kk_initial_backward = kk_final_forward;
k_backward = kk_initial_backward / initial_backtransport_rate;

k_g  = kkb * kk_initial_forward / (initial_forward_transport_rate * motor_binding_spots_per_vesicle_area - kk_initial_forward);
k_pm = kka * kk_initial_backward / (initial_backtransport_rate * motor_binding_spots_per_vesicle_area - kk_initial_backward);

kk_g = k_g * sg;
kk_pm = k_pm * spm;
kk_b1_cg = k_forward * nb1_cg;
kk_b1_mtc = k_forward * nb1_mtc;
kk_b1_cpm = k_forward * nb1_cpm;
kk_a2_cg = k_backward * na2_cg;
kk_a2_mtc = k_backward * na2_mtc;
kk_a2_cpm = k_backward * na2_cpm;

k_kk_production = rate_lost_nb1_mtc * k_forward + rate_lost_na2_mtc * k_backward; 

%10) Calculate dynein
d_per_vesicle_a2_mtc = log(1 - anticipated_fraction_of_bound_a2_vesicles_in_mtc) / log(1-fraction_bound_dd_a2b2_mtc);
d_a2_mtc = d_per_vesicle_a2_mtc / anterograde_vesicle_surface_area;
d_backward = d_a2_mtc;
dd_initial_backward = d_backward * initial_backtransport_rate;
dd_final_forward = dd_initial_backward;
d_forward = dd_final_forward / final_forward_transport_rate;
dd_initial_forward = d_forward * initial_forward_transport_rate;

d_g  = kdb * dd_initial_forward / (initial_forward_transport_rate * motor_binding_spots_per_vesicle_area - dd_initial_forward);
d_pm = kda * dd_initial_backward / (initial_backtransport_rate * motor_binding_spots_per_vesicle_area    - dd_initial_backward);

dd_g = d_g * sg;
dd_pm = d_pm * spm;
dd_b1_cg = d_forward * nb1_cg;
dd_b1_mtc = d_forward * nb1_mtc;
dd_b1_cpm = d_forward * nb1_cpm;
dd_a2_cg = d_backward * na2_cg;
dd_a2_mtc = d_backward * na2_mtc;
dd_a2_cpm = d_backward * na2_cpm;

k_dd_production = rate_lost_nb1_mtc * d_forward + rate_lost_na2_mtc * d_backward; 

%10) Calculate cargo
c1_g = cc1_g / sg;
sc1b1 = cargo_binding_spots_per_vesicle_area * (c1_g/kc1b) / (1+c1_g/kc1b);
c1_forward = sc1b1;
cc1_final_forward = final_forward_transport_rate * c1_forward;
cc1_initial_backward = cc1_final_forward;
c1_backward = cc1_initial_backward / initial_backtransport_rate;
c1_pm = kc1a * cc1_initial_backward / (initial_backtransport_rate * cargo_binding_spots_per_vesicle_area - cc1_initial_backward);

cc1_pm = c1_pm * spm;
cc1_b1_cg = c1_forward * nb1_cg;
cc1_b1_mtc = c1_forward * nb1_mtc;
cc1_b1_cpm = c1_forward * nb1_cpm;
cc1_a2_cg = c1_backward * na2_cg;
cc1_a2_mtc = c1_backward * na2_mtc;
cc1_a2_cpm = c1_backward * na2_cpm;

k_cc1_production = rate_lost_nb1_mtc * c1_forward + rate_lost_na2_mtc * c1_backward; 

c2_pm = cc2_pm / sg;
sc2a2 = cargo_binding_spots_per_vesicle_area * (c2_pm/kc2a) / (1+c2_pm/kc2a);
c2_backward = sc2a2;
cc2_initial_backward = initial_backtransport_rate * c2_backward;
cc2_final_forward = cc2_initial_backward;
c2_forward = cc2_final_forward / final_forward_transport_rate;
cc2_initial_forward = c2_forward * initial_forward_transport_rate;
c2_g = kc2b * cc2_initial_forward / (initial_forward_transport_rate * cargo_binding_spots_per_vesicle_area - cc2_initial_forward);

cc2_g = c2_g * sg;
cc2_b1_cg = c2_forward * nb1_cg;
cc2_b1_mtc = c2_forward * nb1_mtc;
cc2_b1_cpm = c2_forward * nb1_cpm;
cc2_a2_cg = c2_backward * na2_cg;
cc2_a2_mtc = c2_backward * na2_mtc;
cc2_a2_cpm = c2_backward * na2_cpm;

k_cc2_production = rate_lost_nb1_mtc * c2_forward + rate_lost_na2_mtc * c2_backward; 








%write file
identifier_file_name = 'backwardFlux050_fraction010_velocity005';

complete_conc_file_name = strcat('C:\Users\Arjun\Desktop\April19th_NOG_Model\NOG_adoptVariables_',identifier_file_name,'.m');

fid = fopen(complete_conc_file_name,'wt');

fprintf(fid,strcat('parameters(index_with_MTC_growth) = ',num2str(with_MTC_growth),';'));
fprintf(fid,'\n'); 
if (MTC_length_at_start<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_MTC_length_at_start) = ',num2str(MTC_length_at_start),';'));
fprintf(fid,'\n'); 
if (s3<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_s3) = ',num2str(s3),';'));
fprintf(fid,'\n'); 
if (nb1_cg<0) 
    ME = MException('see above' ); throw(ME)
end
if (nb1_cg<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_nb1_cg) = ',num2str(nb1_cg),';'));
fprintf(fid,'\n'); 
if (nb1_mtc<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_nb1_mtc) = ',num2str(nb1_mtc),';'));
fprintf(fid,'\n'); 
if (nb1_cpm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_nb1_cpm) = ',num2str(nb1_cpm),';'));
fprintf(fid,'\n'); 
if (na2_cg<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_na2_cg) = ',num2str(na2_cg),';'));
fprintf(fid,'\n'); 
if (na2_mtc<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_na2_mtc) = ',num2str(na2_mtc),';'));
fprintf(fid,'\n');
if (na2_cpm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_na2_cpm) = ',num2str(na2_cpm),';'));
fprintf(fid,'\n'); 
if (xx_g<0) 
%   ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_xx_g) = ',num2str(xx_g),';'));
fprintf(fid,'\n'); 
if (yy_g<0) 
 %   ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_yy_g) = ',num2str(yy_g),';'));
fprintf(fid,'\n'); 
if (xx_pm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_xx_pm) = ',num2str(xx_pm),';'));
fprintf(fid,'\n'); 
if (yy_pm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_yy_pm) = ',num2str(yy_pm),';'));
fprintf(fid,'\n'); 
if (vv_g<0) 
%    ME = MException('see above' ); throw(ME)
end

fprintf(fid,strcat('statevar(indexS_vv_g) = ',num2str(vv_g),';'));
fprintf(fid,'\n'); 
if (vv_b1_cg<0) 
    ME = MException('see above' ); throw(ME)
end

fprintf(fid,strcat('statevar(indexS_vv_b1_cg) = ',num2str(vv_b1_cg),';'));
fprintf(fid,'\n'); 
if (vv_b1_mtc<0) 
    ME = MException('see above' ); throw(ME)
end

fprintf(fid,strcat('statevar(indexS_vv_b1_mtc) = ',num2str(vv_b1_mtc),';'));
fprintf(fid,'\n'); 
if (vv_b1_cpm<0) 
    ME = MException('see above' ); throw(ME)
end

fprintf(fid,strcat('statevar(indexS_vv_b1_cpm) = ',num2str(vv_b1_cpm),';'));
fprintf(fid,'\n');
if (vv_pm<0) 
    ME = MException('see above' ); throw(ME)
end

fprintf(fid,strcat('statevar(indexS_vv_pm) = ',num2str(vv_pm),';'));
fprintf(fid,'\n'); 
if (uu_b1_cg<0) 
    ME = MException('see above' ); throw(ME)
end

fprintf(fid,strcat('statevar(indexS_uu_b1_cg) = ',num2str(uu_b1_cg),';'));
fprintf(fid,'\n'); 
if (uu_b1_mtc<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_uu_b1_mtc) = ',num2str(uu_b1_mtc),';'));
fprintf(fid,'\n'); 
if (uu_b1_cpm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_uu_b1_cpm) = ',num2str(uu_b1_cpm),';'));
fprintf(fid,'\n'); 
if (uu_g<0) 
%    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_uu_g) = ',num2str(uu_g),';'));
fprintf(fid,'\n'); 
if (uu_a2_cg<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_uu_a2_cg) = ',num2str(uu_a2_cg),';'));
fprintf(fid,'\n'); 
if (uu_a2_mtc<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_uu_a2_mtc) = ',num2str(uu_a2_mtc),';'));
fprintf(fid,'\n'); 
if (uu_a2_cpm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_uu_a2_cpm) = ',num2str(uu_a2_cpm),';'));
fprintf(fid,'\n'); 
if (uu_pm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_uu_pm) = ',num2str(uu_pm),';'));
fprintf(fid,'\n'); 
if (kk_g<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_kk_g) = ',num2str(kk_g),';'));
fprintf(fid,'\n'); 
if (kk_b1_cg<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_kk_b1_cg) = ',num2str(kk_b1_cg),';'));
fprintf(fid,'\n'); 
if (kk_b1_mtc<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_kk_b1_mtc) = ',num2str(kk_b1_mtc),';'));
fprintf(fid,'\n'); 
if (kk_b1_cpm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_kk_b1_cpm) = ',num2str(kk_b1_cpm),';'));
fprintf(fid,'\n'); 
if (kk_pm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_kk_pm) = ',num2str(kk_pm),';'));
fprintf(fid,'\n'); 
if (kk_a2_cg<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_kk_a2_cg) = ',num2str(kk_a2_cg),';'));
fprintf(fid,'\n'); 
if (kk_a2_mtc<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_kk_a2_mtc) = ',num2str(kk_a2_mtc),';'));
fprintf(fid,'\n'); 
if (kk_a2_cpm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_kk_a2_cpm) = ',num2str(kk_a2_cpm),';'));
fprintf(fid,'\n'); 
if (dd_g<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_dd_g) = ',num2str(dd_g),';'));
fprintf(fid,'\n'); 
if (dd_b1_cg<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_dd_b1_cg) = ',num2str(dd_b1_cg),';'));
fprintf(fid,'\n'); 
if (dd_b1_mtc<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_dd_b1_mtc) = ',num2str(dd_b1_mtc),';'));
fprintf(fid,'\n'); 
if (dd_b1_cpm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_dd_b1_cpm) = ',num2str(dd_b1_cpm),';'));
fprintf(fid,'\n'); 
if (dd_pm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_dd_pm) = ',num2str(dd_pm),';'));
fprintf(fid,'\n'); 
if (dd_a2_cg<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_dd_a2_cg) = ',num2str(dd_a2_cg),';'));
fprintf(fid,'\n'); 
if (dd_a2_mtc<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_dd_a2_mtc) = ',num2str(dd_a2_mtc),';'));
fprintf(fid,'\n'); 
if (dd_a2_cpm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_dd_a2_cpm) = ',num2str(dd_a2_cpm),';'));
fprintf(fid,'\n'); 
fprintf(fid,'\n'); 

if (cc1_g<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_cc1_g) = ',num2str(cc1_g),';'));
fprintf(fid,'\n'); 
if (cc1_b1_cg<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_cc1_b1_cg) = ',num2str(cc1_b1_cg),';'));
fprintf(fid,'\n'); 
if (cc1_b1_mtc<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_cc1_b1_mtc) = ',num2str(cc1_b1_mtc),';'));
fprintf(fid,'\n'); 
if (cc1_b1_cpm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_cc1_b1_cpm) = ',num2str(cc1_b1_cpm),';'));
fprintf(fid,'\n'); 
if (cc1_pm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_cc1_pm) = ',num2str(cc1_pm),';'));
fprintf(fid,'\n'); 
if (cc1_a2_cg<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_cc1_a2_cg) = ',num2str(cc1_a2_cg),';'));
fprintf(fid,'\n'); 
if (cc1_a2_cg<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_cc1_a2_mtc) = ',num2str(cc1_a2_mtc),';'));
fprintf(fid,'\n'); 
if (cc1_a2_cpm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_cc1_a2_cpm) = ',num2str(cc1_a2_cpm),';'));
fprintf(fid,'\n'); 
fprintf(fid,'\n'); 

if (cc2_g<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_cc2_g) = ',num2str(cc2_g),';'));
fprintf(fid,'\n'); 
if (cc2_b1_cg<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_cc2_b1_cg) = ',num2str(cc2_b1_cg),';'));
fprintf(fid,'\n'); 
if (cc2_b1_mtc<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_cc2_b1_mtc) = ',num2str(cc2_b1_mtc),';'));
fprintf(fid,'\n'); 
if (cc2_b1_cpm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_cc2_b1_cpm) = ',num2str(cc2_b1_cpm),';'));
fprintf(fid,'\n'); 
if (cc2_pm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_cc2_pm) = ',num2str(cc2_pm),';'));
fprintf(fid,'\n'); 
if (cc2_a2_cg<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_cc2_a2_cg) = ',num2str(cc2_a2_cg),';'));
fprintf(fid,'\n'); 
if (cc2_a2_mtc<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_cc2_a2_mtc) = ',num2str(cc2_a2_mtc),';'));
fprintf(fid,'\n'); 
if (cc2_a2_cpm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_cc2_a2_cpm) = ',num2str(cc2_a2_cpm),';'));
fprintf(fid,'\n'); 
fprintf(fid,'\n'); 

if (k_membrane_production<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_k_membrane_production) = ',num2str(k_membrane_production),';'));
fprintf(fid,'\n'); 

if (k_vv_production<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_k_vv_production) = ',num2str(k_vv_production),';'));
fprintf(fid,'\n'); 

if (k_yy_production<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_k_yy_production) = ',num2str(k_yy_production),';'));
fprintf(fid,'\n'); 

if (k_xx_production<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_k_xx_production) = ',num2str(k_xx_production),';'));
fprintf(fid,'\n'); 

if (k_uu_production<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_k_uu_production) = ',num2str(k_uu_production),';'));
fprintf(fid,'\n'); 

if (k_kk_production<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_k_kk_production) = ',num2str(k_kk_production),';'));
fprintf(fid,'\n'); 

if (k_dd_production<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_k_dd_production) = ',num2str(k_dd_production),';'));
fprintf(fid,'\n'); 

if (wb_g<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_wb_g) = ',num2str(wb_g),';'));
fprintf(fid,'\n'); 
if (wa_g<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_wa_g) = ',num2str(wa_g),';'));
fprintf(fid,'\n'); 
if (wb_pm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_wb_pm) = ',num2str(wb_pm),';'));
fprintf(fid,'\n'); 
if (wa_pm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_wa_pm) = ',num2str(wa_pm),';'));
fprintf(fid,'\n'); 
if (kappaXU_g<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_kappaXU_g) = ',num2str(kappaXU_g),';'));
fprintf(fid,'\n'); 
if (kappaYV_pm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_kappaYV_pm) = ',num2str(kappaYV_pm),';'));
fprintf(fid,'\n'); 
if (kappaXU_g<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_kappaXU_g) = ',num2str(kappaXU_g),';'));
fprintf(fid,'\n'); 
if (kappaYV_g<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_kappaYV_g) = ',num2str(kappaYV_g),';'));
fprintf(fid,'\n'); 

fclose(fid);



