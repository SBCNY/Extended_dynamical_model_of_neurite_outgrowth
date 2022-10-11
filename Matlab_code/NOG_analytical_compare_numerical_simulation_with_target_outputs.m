clc;
clear;
close all;

global Output_fluxes Output_time timepoint_of_last_common_nucleation1

%Analytical prediction specific input

%Set demanded rates
NOG_analytical_predefine_conditions;
velocities_per_hour = [5 10];


max_time = 5000;
tspan = [0 max_time];
timepoints_for_comparison = 1000:1000:max_time;
length_timepoints_for_comparison = length(timepoints_for_comparison);

suppl_figure_labels = {'Suppl Fig 4A - Num_vs_ana','Suppl Fig 4B - Num_vs_ana','Suppl Fig 4C - Num_vs_ana','Suppl Fig 4D - Num_vs_ana','Suppl Fig 4E - Num_vs_ana','Suppl Fig 4F - Num_vs_ana','Suppl Fig 4G - Num_vs_ana','Suppl Fig 4H - Num_vs_ana','Suppl Fig 4I - Num_vs_ana'};

kappaYV_pms = dlmread('selected_kappaYV_pms_for_validation.tab');
velocities_of_kappaYV_pms = dlmread('velocities_for_selected_kappaYV_pms.tab');

out_of_balance_analysis = true;

length_tests = size(kappaYV_pms,2);

%velocities_per_hour = [20]; %[2.5 5 7.5 10 12.5 15 17.5 20];
length_velocities = length(velocities_per_hour);

if (out_of_balance_analysis)
    startIndexVelocity = 2;
else
    startIndexVelocity = 1;
end


for indexVelocity = startIndexVelocity:length_velocities
    length_predictions = 7;
    predictedValue_barlabels = cell(length_predictions,1);
    predictedValue_titels = cell(length_predictions,1);
    predictedValue_ylabels = cell(length_predictions,1);
    predictedValue_unit = cell(length_predictions,1);
    predictedValue_sum = zeros(length_predictions,1);
    predictedValue_new_subplot = zeros(length_predictions,1);
    predictedValue_barcolors = zeros(length_predictions,3);
    predictedValue_barWidths = zeros(length_predictions,3);
    predictedValue_sdcolors = zeros(length_predictions,3);
    predictedValue_sumOfSquares = zeros(length_predictions,1);
    predictedValue_targetOutputs = zeros(length_predictions,1);
    predictedValue_upper_ylims = zeros(length_predictions,1);
    predictedValue_left_xlims = zeros(length_predictions,1);
    wrong_velocity_per_hour = velocities_per_hour(indexVelocity-1);  % out of balance
    current_velocity_per_hour = velocities_per_hour(indexVelocity);
    performed_tests = 0;
    for indexTest = 1:length_tests
        indexSelected = 1;

        %Real/anticipated selection
        velocity_of_current_kappaYV_pms = velocities_of_kappaYV_pms(indexSelected);
        while (velocity_of_current_kappaYV_pms ~= current_velocity_per_hour);
            indexSelected = indexSelected + 1;
            velocity_of_current_kappaYV_pms = velocities_of_kappaYV_pms(indexSelected);
        end
        current_kappaYV_pms = kappaYV_pms(indexSelected,:);
        kappaYV_pm = current_kappaYV_pms(indexTest);

        %Missed selection for out of balance - Begin
        indexWrongSelection = 1;
        velocity_of_current_kappaYV_pms = velocities_of_kappaYV_pms(indexWrongSelection);
        while (velocity_of_current_kappaYV_pms ~= current_velocity_per_hour);
            indexWrongSelection = indexWrongSelection + 1;
            velocity_of_current_kappaYV_pms = velocities_of_kappaYV_pms(indexSelected);
        end
        current_wrong_kappaYV_pms = kappaYV_pms(indexWrongSelection,:);
        wrong_kappaYV_pm = current_wrong_kappaYV_pms(indexTest);
        %Missed selection for out of balance - End
        
        if (  (kappaYV_pm~=0)...
            &&(  (~out_of_balance_analysis)...
               ||(wrong_kappaYV_pm~=0)))
            anticipated_backwardFlux_a2_mtc_into_cg = cycling_rate;
            anticipated_fraction_bound_nb1_mtc = anticipated_fraction_of_bound_b1_vesicles_in_mtc;
   
            %Predict real variables - Begin
            NOG_initialConc;
            NOG_parameters_set;
            NOG_analytical_predefine_conditions;

            velocity_per_hour = current_velocity_per_hour;

            NOG_analytical_predict_concentrations_and_parameter;
            if (~accepted_combination)
               ME = MException('see above');
               throw(ME);
            end
            %Predict real variables - End

            if (out_of_balance_analysis)
                NOG_analytical_outOfBalance_setFirstPredictedValues;
                %Predict out of balance variables - Begin
                NOG_initialConc;
                NOG_parameters_set;
                NOG_analytical_predefine_conditions;

                velocity_per_hour = wrong_velocity_per_hour;
                kappaYV_pm = wrong_kappaYV_pm;
                NOG_analytical_predict_concentrations_and_parameter;
                if (~accepted_combination)
                   ME = MException('see above');
                   throw(ME);
                end
                velocity_per_hour = current_velocity_per_hour;
                NOG_analytical_outOfBalance_resetVariablesFromFirstPrediction;
                %Predict out of balance variables - End
            end
            
            
            NOG_parameter_vector_set;
            NOG_statevar_set;

            statevar_input = statevar;

            Output_fluxes = [];
            Output_time = [];
            timepoint_of_last_common_nucleation1 = 0;
            [t,statevar_timelines] = ode15s(@(t,statevar)NOG_function1(t,statevar,parameters,statevar_input,statevar_buffer),tspan, statevar_input);
            statevar_last_timepoints = statevar_timelines(end,:)';

            
            
            %NOG_define_expVSpredic;
            %NOG_plot_statevar_vs_time;
            %NOG_plot_selectedValues_vs_statevar_paper_figure;
            %NOG_plot_fluxes_vs_time;
            
            
            bar_width = 0.5;
            reference_xlims = 5;
            indexStatevarTime = 1;
            indexFluxTime = 1;

            
            for indexCheck = 1:length_timepoints_for_comparison
                current_timepoint = timepoints_for_comparison(indexCheck);
                while (current_timepoint > t(indexStatevarTime))
                   indexStatevarTime = indexStatevarTime + 1; 
                end
                while (current_timepoint > Output_time(indexFluxTime))
                   indexFluxTime = indexFluxTime + 1; 
                end
                indexPredictedValue = 0;
                performed_tests = performed_tests + 1;

                %%%%%%%Define reference time and indexes
                reference_time_period = 500;
                tend = t(indexStatevarTime);
                tstart = tend - reference_time_period;
                tstart_index = -1;

                %%%%%%%Define reference time and indexes
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

                reference_time_period = t(indexStatevarTime) - t(tstart_index);

                
                indexPredictedValue = indexPredictedValue + 1;
                predicted_s3_change = statevar_timelines(indexStatevarTime,indexS_s3) - statevar_timelines(tstart_index,indexS_s3);
                predictedValue_barlabels{indexPredictedValue} = 'Neurite shaft';
                predictedValue_titles{indexPredictedValue} = {'Neurite shaft';'growth velocity'};
                predictedValue_ylabels{indexPredictedValue} = {'Length increase';'[\mum/h]'};
                predictedValue_unit{indexPredictedValue} = '[\mum/h]';
                predictedValue_barcolors(indexPredictedValue,:) = [0 155/255 0];
                predictedValue_sdcolors(indexPredictedValue,:) = [0 55/255 0];
                predictedValue_new_subplot(indexPredictedValue) = true;
                predValue = (60 * predicted_s3_change/(2*pi*radius_neurite)) / reference_time_period;
                predictedValue_sum(indexPredictedValue) = predictedValue_sum(indexPredictedValue) + predValue;
                predictedValue_sumOfSquares(indexPredictedValue) = predictedValue_sumOfSquares(indexPredictedValue) + predValue^2;
                predictedValue_targetOutputs(indexPredictedValue) = velocity_per_hour;
                predictedValue_upper_ylims(indexPredictedValue) = max(velocities_per_hour) * 1.2;
                predictedValue_left_xlims(indexPredictedValue) = 2;
                predictedValue_barWidths(indexPredictedValue) = reference_xlims * bar_width/(2*predictedValue_left_xlims(indexPredictedValue)+1);

                indexPredictedValue = indexPredictedValue + 1;
                predicted_cycling_membrane = Output_fluxes(indexFluxTime,12);
                predictedValue_barlabels{indexPredictedValue} = 'Cycling membrane';
                predictedValue_titles{indexPredictedValue} = {'Cycling';'membrane'};
                predictedValue_ylabels{indexPredictedValue} = {'Surface area';'[\mum^2/min]'};
                predictedValue_unit{indexPredictedValue} = '[\mum/min]';
                predictedValue_barcolors(indexPredictedValue,:) = [0 155/255 0];
                predictedValue_sdcolors(indexPredictedValue,:) = [0 55/255 0];
                predictedValue_new_subplot(indexPredictedValue) = true;
                predValue = predicted_cycling_membrane;
                predictedValue_sum(indexPredictedValue) = predictedValue_sum(indexPredictedValue) + predValue;
                predictedValue_sumOfSquares(indexPredictedValue) = predictedValue_sumOfSquares(indexPredictedValue) + predValue^2;
                predictedValue_targetOutputs(indexPredictedValue) = cycling_rate;
                predictedValue_upper_ylims(indexPredictedValue) = 0.7;
                predictedValue_left_xlims(indexPredictedValue) = 2;
                predictedValue_barWidths(indexPredictedValue) = reference_xlims * bar_width/(2*predictedValue_left_xlims(indexPredictedValue)+1);

                indexPredictedValue = indexPredictedValue + 1;
                predictedValue_barlabels{indexPredictedValue} = 'TGN';
                predictedValue_titles{indexPredictedValue} = 'TGN';
                predictedValue_ylabels{indexPredictedValue} = {'Surface area';'[\mum^2]'};
                predictedValue_unit{indexPredictedValue} = '[\mum^2]';
                predicted_sg = statevar_timelines(indexStatevarTime,indexS_sg);
                predictedValue_barcolors(indexPredictedValue,:) = [0 155/255 0];    
                predictedValue_sdcolors(indexPredictedValue,:) = [0 55/255 0];
                predictedValue_new_subplot(indexPredictedValue) = true;
                predValue = predicted_sg;
                predictedValue_sum(indexPredictedValue) = predictedValue_sum(indexPredictedValue) + predValue;
                predictedValue_sumOfSquares(indexPredictedValue) = predictedValue_sumOfSquares(indexPredictedValue) + predValue^2;
                predictedValue_targetOutputs(indexPredictedValue) = 50;
                predictedValue_upper_ylims(indexPredictedValue) = 100;%predictedValue_targetOutputs(indexPredictedValue) * 1.2;
                predictedValue_left_xlims(indexPredictedValue) = 2;
                predictedValue_barWidths(indexPredictedValue) = reference_xlims * bar_width/(2*predictedValue_left_xlims(indexPredictedValue)+1);

                indexPredictedValue = indexPredictedValue + 1;
                fraction_bound_nb1_mtc = Output_fluxes(indexFluxTime,159);
                predictedValue_barlabels{indexPredictedValue} = 'MTC';%'Percent of moving b1 vesicles in MTC';
                predictedValue_titles{indexPredictedValue} = {'Moving';'b1 vesicles'};
                predictedValue_ylabels{indexPredictedValue} = {'Percent';'[%]'};
                predictedValue_unit{indexPredictedValue} = '[%]';
                predictedValue_barcolors(indexPredictedValue,:) = [255/255 130/255 0];
                predictedValue_sdcolors(indexPredictedValue,:) = [200/255 100/255 0];
                predictedValue_new_subplot(indexPredictedValue) = true;
                predValue = fraction_bound_nb1_mtc * 100;
                predictedValue_sum(indexPredictedValue) = predictedValue_sum(indexPredictedValue) + predValue;
                predictedValue_sumOfSquares(indexPredictedValue) = predictedValue_sumOfSquares(indexPredictedValue) + predValue^2;
                predictedValue_targetOutputs(indexPredictedValue) = anticipated_fraction_of_bound_b1_vesicles_in_mtc * 100;
                predictedValue_upper_ylims(indexPredictedValue) = 15;
                predictedValue_left_xlims(indexPredictedValue) = 3;
                predictedValue_barWidths(indexPredictedValue) = reference_xlims * bar_width/(predictedValue_left_xlims(indexPredictedValue)+1);

                fraction_of_fusing_vesicles_b1_cpm_pm = Output_fluxes(indexFluxTime,8) / statevar_timelines(indexStatevarTime,indexS_nb1_cpm);
                indexPredictedValue = indexPredictedValue + 1;
                predictedValue_barlabels{indexPredictedValue} = 'GCC';%'Percent of fusing b1 vesicles in growth cone';
                predictedValue_titles{indexPredictedValue} = {'Moving';'b1 vesicles'};
                predictedValue_ylabels{indexPredictedValue} = {'Percent','[%]'};
                predictedValue_unit{indexPredictedValue} = '[%]';
                predictedValue_barcolors(indexPredictedValue,:) = [255/255 130/255 0];
                predictedValue_sdcolors(indexPredictedValue,:) = [200/255 100/255 0];
                predictedValue_new_subplot(indexPredictedValue) = false;
                predValue = fraction_of_fusing_vesicles_b1_cpm_pm * 110;
                predictedValue_sum(indexPredictedValue) = predictedValue_sum(indexPredictedValue) + predValue;
                predictedValue_sumOfSquares(indexPredictedValue) = predictedValue_sumOfSquares(indexPredictedValue) + predValue^2;
                predictedValue_targetOutputs(indexPredictedValue) = anticipated_fraction_of_bound_b1_vesicles_in_mtc * 100;
                predictedValue_upper_ylims(indexPredictedValue) = 15;
                predictedValue_left_xlims(indexPredictedValue) = 3;
                predictedValue_barWidths(indexPredictedValue) = reference_xlims * bar_width/(predictedValue_left_xlims(indexPredictedValue)+1);

                fraction_bound_na2_mtc = Output_fluxes(indexFluxTime,161);
                indexPredictedValue = indexPredictedValue + 1;
                predictedValue_barlabels{indexPredictedValue} = 'MTC';'Percent of moving a2 vesicles in MTC';
                predictedValue_titles{indexPredictedValue} = {'Moving';'a2 vesicles'};
                predictedValue_ylabels{indexPredictedValue} = {'Percent','[%]'};
                predictedValue_unit{indexPredictedValue} = '[%]';
                predictedValue_barcolors(indexPredictedValue,:) = [0/255 100/255 200/255];
                predictedValue_sdcolors(indexPredictedValue,:) = [0/255 0/255 200/255];
                predictedValue_new_subplot(indexPredictedValue) = true;
                predValue = fraction_bound_na2_mtc * 100;
                predictedValue_sum(indexPredictedValue) = predictedValue_sum(indexPredictedValue) + predValue;
                predictedValue_sumOfSquares(indexPredictedValue) = predictedValue_sumOfSquares(indexPredictedValue) + predValue^2;
                predictedValue_targetOutputs(indexPredictedValue) = anticipated_fraction_of_bound_a2_vesicles_in_mtc * 100;
                predictedValue_upper_ylims(indexPredictedValue) = 120;
                predictedValue_left_xlims(indexPredictedValue) = 3;
                predictedValue_barWidths(indexPredictedValue) = reference_xlims * bar_width/(predictedValue_left_xlims(indexPredictedValue)+1);

                fraction_of_fusing_vesicles_a2_cg_g = Output_fluxes(indexFluxTime,9) / statevar_timelines(indexStatevarTime,indexS_na2_cg);
                indexPredictedValue = indexPredictedValue + 1;
                predictedValue_barlabels{indexPredictedValue} = 'CG';%'Percent of fusing a2 vesicles in cell body';
                predictedValue_titles{indexPredictedValue} = {'Moving';'a2 vesicles'};
                predictedValue_ylabels{indexPredictedValue} = {'Percent';'[%]'};
                predictedValue_unit{indexPredictedValue} = '[%]';
                predictedValue_barcolors(indexPredictedValue,:) = [0/255 100/255 200/255];
                predictedValue_sdcolors(indexPredictedValue,:) = [0/255 0/255 200/255];
                predictedValue_new_subplot(indexPredictedValue) = false;
                predValue = fraction_of_fusing_vesicles_a2_cg_g * 100;
                predictedValue_sum(indexPredictedValue) = predictedValue_sum(indexPredictedValue) + predValue;
                predictedValue_sumOfSquares(indexPredictedValue) = predictedValue_sumOfSquares(indexPredictedValue) + predValue^2;
                predictedValue_targetOutputs(indexPredictedValue) = anticipated_fraction_of_bound_a2_vesicles_in_mtc * 100;
                predictedValue_upper_ylims(indexPredictedValue) = 120;
                predictedValue_left_xlims(indexPredictedValue) = 3;
                predictedValue_barWidths(indexPredictedValue) = reference_xlims * bar_width/(predictedValue_left_xlims(indexPredictedValue)+1);
            end
        end
    end    

    predictedValue_means = predictedValue_sum / performed_tests;
    predictedValue_sample_sds = sqrt(predictedValue_sumOfSquares / performed_tests - predictedValue_means.^2);
    predictedValue_sample_sds = predictedValue_sample_sds * (performed_tests-1) / performed_tests;

    figure;
    subplots_count = 0;
    for indexPredicted = 1:length_predictions 
       if (predictedValue_new_subplot(indexPredicted))
          subplots_count = subplots_count + 1;
       end
    end

    subplot_rows = 2;
    subplot_cols = 3;%subplots_count;
    title_font_size = 12;
    xaxis_label_font_size = 9;
    yaxis_label_font_size = 9;
    yaxis_scale_font_size = 9;
    plotIndex_of_subfigure = 0;
    errorbar_width = 2;
    referenceLineWidth = 1;

    for indexPredicted = 1:length_predictions 
       if (predictedValue_new_subplot(indexPredicted))
           firstIndexPredicted = indexPredicted;
           color = predictedValue_barcolors(indexPredicted,:);
       end
       if (  (indexPredicted==length_predictions)...
           ||(predictedValue_new_subplot(indexPredicted+1)))
           plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
           subplot(subplot_rows,subplot_cols,plotIndex_of_subfigure);
           means = predictedValue_means(firstIndexPredicted:indexPredicted);
           sds = predictedValue_sample_sds(firstIndexPredicted:indexPredicted);
           bar_width = predictedValue_barWidths(firstIndexPredicted);
           b = bar(means,'FaceColor',predictedValue_barcolors(firstIndexPredicted,:),'EdgeColor',predictedValue_barcolors(firstIndexPredicted,:),'BarWidth',bar_width);
           hold;
           hline = refline([0 predictedValue_targetOutputs(indexPredicted)]);%,'LineWidth',referenceLineWidth);%,'Color',predictedValue_sdcolors(firstIndexPredicted,:));
           set(hline,'Color',predictedValue_sdcolors(firstIndexPredicted,:));
           set(hline,'LineWidth',referenceLineWidth);
           %hline_upper = refline([0 predictedValue_targetOutputs(indexPredicted)*1.1]);%,'LineWidth',referenceLineWidth);%,'Color',predictedValue_sdcolors(firstIndexPredicted,:));
           %set(hline_upper,'Color',predictedValue_sdcolors(firstIndexPredicted,:));
           %set(hline_upper,'LineWidth',referenceLineWidth);
           %hline_lower = refline([0 predictedValue_targetOutputs(indexPredicted)*0.9]);%,'LineWidth',referenceLineWidth);%,'Color',predictedValue_sdcolors(firstIndexPredicted,:));
           %set(hline_lower,'Color',predictedValue_sdcolors(firstIndexPredicted,:));
           %set(hline_lower,'LineWidth',referenceLineWidth);
           ylim([0 predictedValue_upper_ylims(firstIndexPredicted)]);
           xlim([0 predictedValue_left_xlims(firstIndexPredicted)]);
           for indexBar = 1:(indexPredicted-firstIndexPredicted+1)
               x = get(get(b,'children'),'xdata'); 
               barsx = mean(x,1);
               h1 = errorbar(barsx(indexBar)',means(indexBar),sds(indexBar),'Color',predictedValue_sdcolors(firstIndexPredicted,:),'LineWidth',errorbar_width);
           end
            %errorbar(b,means,predictedValue_sample_sds(firstIndexPredicted:indexPredicted));
           set(gca,'XTickLabel',predictedValue_barlabels(firstIndexPredicted:indexPredicted),'FontSize',xaxis_label_font_size);
           title(predictedValue_titles{firstIndexPredicted},'FontSize',title_font_size);
           ylabel(predictedValue_ylabels{firstIndexPredicted},'FontSize',yaxis_label_font_size);
           %plot(targetOutputs(1),[30 30]');
           %errorbar(means,sample_sds);
       end
    end

    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 2*subplot_cols 2*subplot_rows])
    print(char(suppl_figure_labels{indexVelocity}),'-dpng','-r600');
end
