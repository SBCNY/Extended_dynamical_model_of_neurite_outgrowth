clc;
clear;
close all;

%Analytical prediction specific input

NOG_analytical_predefine_conditions;
velocity_per_hour = 20;
effective_tubulin = 8;
kappaYV_pm = 3e-06; %8.5e-07;
kappaXU_g = 8e-06; %7.73e-06;


NOG_analytical_predict_concentrations_and_parameter;

%write file
if (velocity_per_hour>=10)
   velocity_per_hour_string = strcat('0',num2str(velocity_per_hour)); 
else
   velocity_per_hour_string = strcat('00',num2str(velocity_per_hour)); 
end
if (cycling_rate>=1)
    backward_flux_string = strcat('0',num2str(cycling_rate*100));
else
    backward_flux_string = strcat('0',num2str(cycling_rate*100));
end

identifier_file_name = strcat('backwardFlux',backward_flux_string,'_fraction010_velocity',velocity_per_hour_string);
complete_conc_file_name = strcat('C:\Users\Captain Nora\Desktop\June1st_NOG_Model\NOG_adoptVariables_',identifier_file_name,'.m');

fid = fopen(complete_conc_file_name,'wt');

fprintf(fid,strcat('parameters(index_with_MTC_growth) = ',num2str(with_MTC_growth),';'));
fprintf(fid,'\n'); 

if (MTC_length_at_start<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_MTC_length_at_start) = ',num2str(MTC_length_at_start),';'));

fprintf(fid,'\n'); 
if (anterograde_vesicle_surface_area<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_antero_vesicle_surface_area) = ',num2str(anterograde_vesicle_surface_area),';'));

fprintf(fid,'\n'); 
if (SNARE_complexes_per_vesicle_fusion<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_snare_complexes_per_vesicle_fusion) = ',num2str(SNARE_complexes_per_vesicle_fusion),';'));

fprintf(fid,'\n'); 
if (spm<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_spm) = ',num2str(spm),';'));


fprintf(fid,'\n'); 
if (sg<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_sg) = ',num2str(sg),';'));


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
if (fraction_bound_dd_a2b2_mtc<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_fraction_bound_dd_a2b2_mtc) = ',num2str(fraction_bound_dd_a2b2_mtc),';'));
fprintf(fid,'\n'); 

if (fraction_bound_kk_a1b1_mtc<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_fraction_bound_kk_a1b1_mtc) = ',num2str(fraction_bound_kk_a1b1_mtc),';'));
fprintf(fid,'\n'); 

if (nucleation_rate<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_nucleation_rate) = ',num2str(nucleation_rate),';'));
fprintf(fid,'\n'); 

if (stabilization_rate<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('parameters(index_stabilization_rate) = ',num2str(stabilization_rate),';'));
fprintf(fid,'\n'); 

if (effective_tubulin<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_effective_tubulin) = ',num2str(effective_tubulin),';'));
fprintf(fid,'\n'); 

if (dyn_MTs<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_dyn_MTs) = ',num2str(dyn_MTs),';'));
fprintf(fid,'\n'); 

if (stbl_MTs_length<0) 
    ME = MException('see above' ); throw(ME)
end
fprintf(fid,strcat('statevar(indexS_stbl_MTs_length) = ',num2str(stbl_MTs_length),';'));
fprintf(fid,'\n'); 

fclose(fid);


