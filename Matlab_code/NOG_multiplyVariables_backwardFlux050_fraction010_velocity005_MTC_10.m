xx_pm = 2.0102;
xx_g = 2.0107e+04;
yy_pm = 2.0109e+04;
yy_g = 2.0127;

nb1_cpm = 7.618;
nb1_mtc = 0.88;
nb1_cg = 0.009;


vv_g = 162.2637;

v_b1_cpm = 585.0468;
vv_pm = 200 * spm;%383.9901 * spm;%v_b1_cpm * spm;
vv_b1_cpm = v_b1_cpm * nb1_cpm * 1.2;
vv_b1_mtc = v_b1_cpm * nb1_mtc;
vv_b1_cg = v_b1_cpm * nb1_cg;

u_pm = 2.2579;
uu_pm = u_pm * spm;

u_g = 344.0105;
uu_g = u_g * sg * 0.1;
u_a2_cg = u_g * na2_cg;
u_a2_mtc = u_g * na2_mtc;
u_a2_cpm = u_g * na2_cpm;

velocity = 5;
k_membrane_production = velocity/60 * 2 * pi * radius_neurite;

parameters(index_k_membrane_production) = k_membrane_production;
parameters(index_wb) = parameters(index_wb) + k_membrane_production/5000;
parameters(index_kappaXU_g) = 1.3011e-05;

statevar(indexS_xx_pm) = xx_pm;
statevar(indexS_xx_g) = xx_g;
statevar(indexS_yy_pm) = yy_pm;
statevar(indexS_yy_g) = yy_g;

statevar(indexS_vv_g) = vv_g;
statevar(indexS_vv_b1_cg) = vv_b1_cg;
statevar(indexS_vv_b1_mtc) = vv_b1_mtc;
statevar(indexS_vv_b1_cpm) = vv_b1_cpm;
statevar(indexS_vv_pm) = vv_pm;

statevar(indexS_uu_g) = uu_g;
statevar(indexS_uu_a2_cg) = uu_a2_cg;
statevar(indexS_uu_a2_mtc) = uu_a2_mtc;
statevar(indexS_uu_a2_cpm) = uu_a2_cpm;
statevar(indexS_uu_pm) = uu_pm;

statevar(indexS_nb1_cpm) = nb1_cpm;
statevar(indexS_nb1_mtc) = nb1_mtc;
statevar(indexS_nb1_cg) = nb1_cg;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

statevar(indexS_kk_g) = 8;
statevar(indexS_kk_pm) = statevar(indexS_kk_g) * 100;

statevar(indexS_dd_pm) = 1;
statevar(indexS_dd_g) = statevar(indexS_dd_pm) * 100;

