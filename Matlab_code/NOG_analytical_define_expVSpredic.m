
global Output_fluxes Output_time;


%%%%%%%Define reference time and indexes
reference_time_period = 500;
tend = t(end);
tstart = tend - reference_time_period;
tstart_index = -1;
%log2_tolerance_deviation_for_steady_test = log2(0.01);

length_t = length(t);
for indexT = 1:length_t
    if t(indexT)>=tstart
        if (tstart_index == -1)
            tstart_index = indexT;
        end
        break;
    end
end

if (tstart_index == length_t)
    tstart_index = length_t -1;
end

reference_time_period = t(end) - t(tstart_index);

%% Get parameter
antero_vesicle_surface_area = parameters(index_antero_vesicle_surface_area);

%%%%%%%Initialize arrays for experimental predicted statevar data
expPreDataStatevar_length = 6;
expPreDataStatevar_names = cell(expPreDataStatevar_length,1);
expPreDataStatevar_colors = zeros(expPreDataStatevar_length,3);
expPreDataStatevar_add_to_previous_figure = zeros(expPreDataStatevar_length,1);
expPreDataStatevar_ylables = cell(expPreDataStatevar_length,1);
expPreDataStatevar_means = zeros(expPreDataStatevar_length,1);
expPreDataStatevar_sds = zeros(expPreDataStatevar_length,1);
expPreDataStatevar_consider = zeros(expPreDataStatevar_length,1);
expPreDataStatevar_preValue = zeros(length(t),expPreDataStatevar_length);
expPreDataStatevar_deviations = zeros(length(t),expPreDataStatevar_length);

indexPDStatevar = 0;

%%%%%%%%%%%%

nb1_mtc = statevar_timelines(:,indexS_nb1_mtc);
nb2_mtc = statevar_timelines(:,indexS_nb2_mtc);
na1_mtc = statevar_timelines(:,indexS_na1_mtc);
na2_mtc = statevar_timelines(:,indexS_na2_mtc);
vesicles_mtc = (nb1_mtc + nb2_mtc + na1_mtc + na2_mtc) / antero_vesicle_surface_area;

indexPDStatevar = indexPDStatevar + 1;
indexPDStatevarEPD_vesicles_cpm = indexPDStatevar;
expPreDataStatevar_names{indexPDStatevar} = 'TGN [um^2]';
expPreDataStatevar_ylabels{indexPDStatevar} = {'';'TGN [um^2]'};
expPreDataStatevar_colors(indexPDStatevar,:) = [ 0 0 0 ];
expPreDataStatevar_add_to_previous_figure(indexPDStatevar) = false;
expPreDataStatevar_means(indexPDStatevar) = 105;
expPreDataStatevar_sds(indexPDStatevar) = 5;
expPreDataStatevar_consider(indexPDStatevar) = true;
expPreDataStatevar_preValue(:,indexPDStatevar) = vesicles_mtc;

%%%%%%%%%%%%

indexPDStatevar = indexPDStatevar + 1;
indexPDStatevarEPD_s3_length = indexPDStatevar;
expPreDataStatevar_names{indexPDStatevar} = {'Neurite shaft length'};
expPreDataStatevar_ylabels{indexPDStatevar} = 'length [\mum]';
expPreDataStatevar_colors(indexPDStatevar,:) = [0 0 0];
expPreDataStatevar_add_to_previous_figure(indexPDStatevar) = false;
expPreDataStatevar_means(indexPDStatevar) = 50;
expPreDataStatevar_sds(indexPDStatevar) = 5;
expPreDataStatevar_consider(indexPDStatevar) = true;
expPreDataStatevar_preValue(:,indexPDStatevar) = s3 / (2*pi*radius_neurite);


for indexPDFluxes = 1:expPreDataFluxes_length
    expPreDataStatevar_deviations(:,indexPDFluxes) = log2(expPreDataStatevar_preValue(:,indexPDFluxes) / expPreDataStatevar_means(indexPDFluxes));
end


%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%Initialize arrays for experimental predicted fluxes
output_t = Output_time;
expPreDataFluxes_length = 6;
expPreDataFluxes_names = cell(expPreDataFluxes_length,1);
expPreDataFluxes_units = cell(expPreDataStatevar_length,1);
expPreDataFluxes_means = zeros(expPreDataFluxes_length,1);
expPreDataFluxes_sds = zeros(expPreDataFluxes_length,1);
expPreDataFluxes_deviations = zeros(length(output_t),expPreDataFluxes_length);
expPreDataFluxes_consider = zeros(expPreDataFluxes_length,1);
expPreDataFluxes_preValue = zeros(length(output_t),expPreDataFluxes_length);
 
indexPDFluxes = 0;

%%%%%%%%%%%%

spm_into_s3 = Output_fluxes(:,211);
neurite_shaft_growth_velocity = spm_into_s3 / (2 * pi * radius_neurite);
 
indexPDFluxes = indexPDFluxes + 1;
indexPDFluxesEPD_neurite_shaft_growth_velocity = indexPDFluxes;
expPreDataFluxes_names{indexPDFluxes} = 'Neurite shaft growth velocity';
expPreDataFluxes_units{indexPDFluxes} = '[\mum/h]';
expPreDataFluxes_means(indexPDFluxes) = velocity_per_hour;
expPreDataFluxes_sds(indexPDFluxes) = 0.05;
expPreDataFluxes_consider(indexPDFluxes) = true;
expPreDataFluxes_preValue(:,indexPDFluxes) = spm_into_s3;
 
%%%%%%%%%%%%

fraction_bound_nb1_mtc = Output_fluxes(:,195);

indexPDFluxes = indexPDFluxes + 1;
indexPDFluxesEPD_fraction_bound_nb1_mtc = indexPDFluxes;
expPreDataFluxes_names{indexPDFluxes} = 'Percent of moving b1 vesicles in MTC';
expPreDataFluxes_units{indexPDFluxes} = '[%]';
expPreDataFluxes_means(indexPDFluxes) = anticipated_fraction_bound_nb1_mtc * 100;
expPreDataFluxes_sds(indexPDFluxes) = 0.01 * 100;
expPreDataFluxes_consider(indexPDFluxes) = true;
expPreDataFluxes_preValue(:,indexPDFluxes) = fraction_bound_nb1_mtc * 100;
fraction_bound_nb1_mtc = Output_fluxes(:,195);

%%%%%%%%%%%%

fraction_bound_na2_mtc = Output_fluxes(:,197);
 
indexPDFluxes = indexPDFluxes + 1;
indexPDFluxesEPD_fraction_bound_na2_mtc = indexPDFluxes;
expPreDataFluxes_names{indexPDFluxes} = 'Percent of moving a2 vesicles in MTC';
expPreDataFluxes_units{indexPDFluxes} = '[%]';
expPreDataFluxes_means(indexPDFluxes) = anticipated_fraction_bound_nb1_mtc * 100;;
expPreDataFluxes_sds(indexPDFluxes) = 0.01;
expPreDataFluxes_consider(indexPDFluxes) = true;
expPreDataFluxes_preValue(:,indexPDFluxes) = fraction_bound_na2_mtc;

%%%%%%%%%%%%

a2_mtc_into_cg = Output_fluxes(:,14);
 
indexPDFluxes = indexPDFluxes + 1;
indexPDFluxesEPD_a2_mtc_into_cg = indexPDFluxes;
expPreDataFluxes_names{indexPDFluxes} = 'Cycling membrane';
expPreDataFluxes_units{indexPDFluxes} = '[\mum/min]';
expPreDataFluxes_means(indexPDFluxes) = anticipated_backwardFlux_a2_mtc_into_cg;
expPreDataFluxes_sds(indexPDFluxes) = 0.05;
expPreDataFluxes_consider(indexPDFluxes) = true;
expPreDataFluxes_preValue(:,indexPDFluxes) = a2_mtc_into_cg;
 
%%%%%%%%%%%%

fraction_of_fusing_vesicles_b1_cpm_pm = Output_fluxes(:,10) / statevar_timelines(end,indexS_nb1_cpm);
 
indexPDFluxes = indexPDFluxes + 1;
indexPDFluxesEPD_fraction_of_fusing_vesicles_b1_cpm_pm = indexPDFluxes;
expPreDataFluxes_names{indexPDFluxes} = 'Percent of fusing b1 vesicles in growth cone';
expPreDataFluxes_units{indexPDFluxes} = '[%]';
expPreDataFluxes_means(indexPDFluxes) = anticipated_fraction_bound_nb1_mtc * 100;
expPreDataFluxes_sds(indexPDFluxes) = 0.01;
expPreDataFluxes_consider(indexPDFluxes) = true;
expPreDataFluxes_preValue(:,indexPDFluxes) = fraction_of_fusing_vesicles_b1_cpm_pm * 100;

%%%%%%%%%%%%

fraction_of_fusing_vesicles_a2_cg_g = Output_fluxes(:,15) / statevar_timelines(end,indexS_na2_cg);
 
indexPDFluxes = indexPDFluxes + 1;
indexPDFluxesEPD_fraction_of_fusing_vesicles_a2_cg_g = indexPDFluxes;
expPreDataFluxes_names{indexPDFluxes} = 'Percent of fusing b1 vesicles in growth cone';
expPreDataFluxes_units{indexPDFluxes} = '[%]';
expPreDataFluxes_means(indexPDFluxes) = anticipated_fraction_of_bound_b1_vesicles_in_mtc * 100;
expPreDataFluxes_consider(indexPDFluxes) = true;
expPreDataFluxes_preValue(:,indexPDFluxes) = fraction_of_fusing_vesicles_a2_cg_g * 100;

if (indexPDFluxes~=expPreDataFluxes_length)
     ME = MException('see above' );
     throw(ME)
end

for indexPDFluxes = 1:expPreDataFluxes_length
    expPreDataFluxes_deviations(:,indexPDFluxes) = log2(expPreDataFluxes_preValue(:,indexPDFluxes) / expPreDataFluxes_means(indexPDFluxes));
end

%%%%%%%%%%%%






%Calculate growth velocity
s3_start = statevar_timelines(tstart_index,indexS_s3);
s3_end = statevar_timelines(end,indexS_s3);
neurite_shaft_length = s3 / (2 * pi * radius_neurite);
neurite_shaft_length_start = s3_start / (2 * pi * radius_neurite);
neurite_shaft_length_end = s3_end / (2 * pi * radius_neurite);
growth_velocity = (neurite_shaft_length_end - neurite_shaft_length_start) / reference_time_period;
