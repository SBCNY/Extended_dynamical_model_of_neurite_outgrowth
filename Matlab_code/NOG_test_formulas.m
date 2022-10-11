
close all;
NOG_initial_concentrations_steady_state_test;
NOG_statevar_set;
NOG_parameters_set_vector;


yy_g = statevar(indexS_yy_g);
vv_g = statevar(indexS_vv_g);
xx_g = statevar(indexS_xx_g);
uu_g = statevar(indexS_uu_g);
sg = statevar(indexS_sg);

snare_binding_spots_per_vesicle_area = parameters(index_snare_binding_spots_per_vesicle_area);


%%%%%%% test for different snare binding spots per vesicle area
yy_gs = [1:1:1000];
length_yy_gs = length(yy_gs);

snare_binding_spots_per_vesicle_area_array = (60:10:180) / antero_vesicle_surface_area;
length_snare_binding_spots = length(snare_binding_spots_per_vesicle_area_array);

syb1_array = zeros(length_yy_gs,length_snare_binding_spots);
svb1_array = zeros(length_yy_gs,length_snare_binding_spots);
sxb1_array = zeros(length_yy_gs,length_snare_binding_spots);
sub1_array = zeros(length_yy_gs,length_snare_binding_spots);

for indexBS = 1: length_snare_binding_spots
    snare_binding_spots_per_vesicle_area = snare_binding_spots_per_vesicle_area_array(indexBS);
    for indexCond = 1:length_yy_gs
        yy_g = yy_gs(indexCond);
        vv_g = yy_g;

        y_g = yy_g / sg;
        v_g = vv_g / sg;
        x_g = xx_g / sg;
        u_g = uu_g / sg;
        snare_saturation_denom_1b = (1 + x_g/kxb  + u_g/kub  + y_g/kyb  + v_g/kvb);
        syb1 = snare_binding_spots_per_vesicle_area * y_g/kyb / snare_saturation_denom_1b;
        svb1 = snare_binding_spots_per_vesicle_area * v_g/kvb / snare_saturation_denom_1b;
        sxb1 = snare_binding_spots_per_vesicle_area * x_g/kxb / snare_saturation_denom_1b;
        sub1 = snare_binding_spots_per_vesicle_area * u_g/kxb / snare_saturation_denom_1b;
        syb1_array(indexCond,indexBS) = syb1 * antero_vesicle_surface_area;
        svb1_array(indexCond,indexBS) = svb1 * antero_vesicle_surface_area;
        sxb1_array(indexCond,indexBS) = sxb1 * antero_vesicle_surface_area;
        sub1_array(indexCond,indexBS) = sub1 * antero_vesicle_surface_area;
    end
end

subplot(3,1,1);
hold on;
for indexBS = 1:length_snare_binding_spots
    if (indexBS==1) 
       Color = 'r'; 
    else
       Color = 'b';
    end
    plot(yy_gs/sg,syb1_array(:,indexBS),'Color',Color);
    hold on;
end
xlabel('yy g');
ylabel('yy per vesicle');
title('SNARE YY');

subplot(3,1,2);
hold on;
for indexBS = 1:length_snare_binding_spots
    if (indexBS==1) 
       Color = 'r'; 
    else
       Color = 'b';
    end
    plot(yy_gs,sxb1_array(:,indexBS),'Color',Color);
    hold on;
end
xlabel('yy g');
ylabel('xx per vesicle');
title('SNARE XX');

subplot(3,1,3);
hold on;
for indexBS = 1:length_snare_binding_spots
    if (indexBS==1) 
       Color = 'r'; 
    else
       Color = 'b';
    end
    plot(yy_gs,sxb1_array(:,indexBS)+sub1_array(:,indexBS)+syb1_array(:,indexBS)+svb1_array(:,indexBS),'Color',Color);
    hold on;
end
xlabel('yy g');
ylabel('SNAREs per vesicle');
title('All SNAREs');

%%%%%%% test for different kyb values
close all;
NOG_initial_concentrations_steady_state_test;
NOG_statevar_set;
NOG_parameters_set_vector;

yy_g = statevar(indexS_yy_g);
vv_g = statevar(indexS_vv_g);
xx_g = statevar(indexS_xx_g);
uu_g = statevar(indexS_uu_g);
sg = statevar(indexS_sg);

snare_binding_spots_per_vesicle_area = parameters(index_snare_binding_spots_per_vesicle_area);

yy_gs = 1:1:1000;
length_yy_gs = length(yy_gs);

kyb_array = [10 1 0.75 0.5 0.25 0.1 0.01];
length_kyb_array = length(kyb_array);

syb1_array = zeros(length_yy_gs,length_kyb_array);
svb1_array = zeros(length_yy_gs,length_kyb_array);
sxb1_array = zeros(length_yy_gs,length_kyb_array);
sub1_array = zeros(length_yy_gs,length_kyb_array);

for indexKYB = 1:length_kyb_array
    kyb = kyb_array(indexKYB);
    for indexCond = 1:length_yy_gs
        yy_g = yy_gs(indexCond);
        vv_g = yy_g;

        y_g = yy_g / sg;
        v_g = vv_g / sg;
        x_g = xx_g / sg;
        u_g = uu_g / sg;
        snare_saturation_denom_1b = (1 + x_g/kxb  + u_g/kub  + y_g/kyb  + v_g/kvb);
        syb1 = snare_binding_spots_per_vesicle_area * y_g/kyb / snare_saturation_denom_1b;
        svb1 = snare_binding_spots_per_vesicle_area * v_g/kvb / snare_saturation_denom_1b;
        sxb1 = snare_binding_spots_per_vesicle_area * x_g/kxb / snare_saturation_denom_1b;
        sub1 = snare_binding_spots_per_vesicle_area * u_g/kxb / snare_saturation_denom_1b;
        syb1_array(indexCond,indexKYB) = syb1 * antero_vesicle_surface_area;
        svb1_array(indexCond,indexKYB) = svb1 * antero_vesicle_surface_area;
        sxb1_array(indexCond,indexKYB) = sxb1 * antero_vesicle_surface_area;
        sub1_array(indexCond,indexKYB) = sub1 * antero_vesicle_surface_area;
    end
end

subplot(3,1,1);
hold on;
for indexBS = 1:length_kyb_array
    if (indexBS==1) 
       Color = 'r'; 
    else
       Color = 'b';
    end
    plot(yy_gs/sg,syb1_array(:,indexBS),'Color',Color);
    hold on;
end
xlabel('yy g');
ylabel('yy per vesicle');
title('SNARE YY');

subplot(3,1,2);
hold on;
for indexBS = 1:length_kyb_array
    if (indexBS==1) 
       Color = 'r'; 
    else
       Color = 'b';
    end
    plot(yy_gs,sxb1_array(:,indexBS),'Color',Color);
    hold on;
end
xlabel('yy g');
ylabel('xx per vesicle');
title('SNARE XX');

subplot(3,1,3);
hold on;
for indexBS = 1:length_kyb_array
    if (indexBS==1) 
       Color = 'r'; 
    else
       Color = 'b';
    end
    plot(yy_gs,sxb1_array(:,indexBS)+sub1_array(:,indexBS)+syb1_array(:,indexBS)+svb1_array(:,indexBS),'Color',Color);
    hold on;
end
xlabel('yy g');
ylabel('SNAREs per vesicle');
title('All SNAREs');

