clc;
clear;
close all;

%Set fixed rates
NOG_analytical_predefine_conditions;

investigate_SNAREs1_motorProtein2 = 1;

if (investigate_SNAREs1_motorProtein2==1)
    %Set varying values for investigation of SNAREs
    set_kappaYV_pms = [1.5e-06 2.0e-06 2.5e-06 3.0e-06];% 3.5e-06 4.0e-06 4.5e-06 5.5e-06
    anticipated_percentages_of_buffered_b1_membrane = 5;
    anticipated_cycling_rates = 0.1:0.005:1;
    anticipated_fractions_bound_kk_a1b1_mtc = 0.08;
end

if (investigate_SNAREs1_motorProtein2==2)
    %Set varying values for investigation of motor proteins
    set_kappaYV_pms = [2.5e-06];
    anticipated_cycling_rates = 0.75;
    anticipated_percentages_of_buffered_b1_membrane = 0.01:0.05:30;
    anticipated_fractions_bound_kk_a1b1_mtc = 0.05:0.1:0.35;
end

%Set general values
anticipated_fraction_of_fusing_b1_vesicles_to_GC = 0.10;
anticipated_fraction_of_fusing_a2_vesicles_to_TGN = 0.9;
velocities_per_hour = [2.5 5 7.5 10 12.5 15 17.5 20];
effective_tubulin = 9;
effective_dyn_MT_length = 10;
max_target_snares_at_one_compartment = 1e200000;
max_vesicle_snares_at_one_compartment = 1e60;

%Set lengths
length_set_kappaYV_pms = length(set_kappaYV_pms);
length_anticipated_percentages_of_buffered_b1_membrane = length(anticipated_percentages_of_buffered_b1_membrane);
length_percentages_of_buffered_b1_membrane = length(anticipated_percentages_of_buffered_b1_membrane);
length_velocities = length(velocities_per_hour);
length_cycling_rates = length(anticipated_cycling_rates);
length_anticipated_fractions_bound_kk_a1b1_mtc = length(anticipated_fractions_bound_kk_a1b1_mtc);

%Set general figure options
title_fontSize = 10;
axis_label_fontSize = 7;
axis_tick_fontSize = 6;

%Initiate arrays for storage of results
max_combinations = 200000;
velocities_per_hour_of_combination = repmat(-1,max_combinations*length_velocities,1);
percentages_of_buffered_b1_membrane = repmat(-1,max_combinations*length_velocities,1);
cycling_rates = repmat(-1,max_combinations*length_velocities,1);
start_total_xxs = zeros(max_combinations*length_velocities,1);
start_total_yys = zeros(max_combinations*length_velocities,1);
start_total_uus = zeros(max_combinations*length_velocities,1);
start_total_vvs = zeros(max_combinations*length_velocities,1);
vv_b1_cpms = zeros(max_combinations*length_velocities,1);
yy_b1_cpms = zeros(max_combinations*length_velocities,1);
xx_b1_cpms = zeros(max_combinations*length_velocities,1);
uu_b1_cpms = zeros(max_combinations*length_velocities,1);
nb1_cpms = zeros(max_combinations*length_velocities,1);
v_forwards = zeros(max_combinations*length_velocities,1);
v_backwards = zeros(max_combinations*length_velocities,1);
u_forwards = zeros(max_combinations*length_velocities,1);
u_backwards = zeros(max_combinations*length_velocities,1);
start_total_kks = zeros(max_combinations*length_velocities,1);
start_total_dds = zeros(max_combinations*length_velocities,1);
start_total_cc1s = zeros(max_combinations*length_velocities,1);
start_total_cc2s = zeros(max_combinations*length_velocities,1);
k_vv_productions = zeros(max_combinations*length_velocities,1);
k_uu_productions = zeros(max_combinations*length_velocities,1);
k_xx_productions = zeros(max_combinations*length_velocities,1);
k_yy_productions = zeros(max_combinations*length_velocities,1);
k_dd_productions = zeros(max_combinations*length_velocities,1);
k_kk_productions = zeros(max_combinations*length_velocities,1);
k_cc1_productions = zeros(max_combinations*length_velocities,1);
k_cc2_productions = zeros(max_combinations*length_velocities,1);
initial_forward_transport_rates = zeros(max_combinations*length_velocities,1);
initial_backward_transport_rates = zeros(max_combinations*length_velocities,1);
final_forward_transport_rates = zeros(max_combinations*length_velocities,1);
final_backward_transport_rates = zeros(max_combinations*length_velocities,1);
k_membrane_productions = zeros(max_combinations*length_velocities,1);
fractions_bound_kk_a1b1_mtc = zeros(max_combinations*length_velocities,1);
kappaXU_gs = zeros(max_combinations*length_velocities,1);
kappaYV_pms = zeros(max_combinations*length_velocities,1);

indexCombination = 0;

for indexK = 1:length_set_kappaYV_pms
    kappaYV_pm = set_kappaYV_pms(indexK);
    for indexV = 1:length_velocities
        velocity_per_hour = velocities_per_hour(indexV);
        accepted_combination = true;
        for indexF = 1:length_anticipated_fractions_bound_kk_a1b1_mtc
            fraction_bound_kk_a1b1_mtc = anticipated_fractions_bound_kk_a1b1_mtc(indexF);
            for indexBM = 1:length_percentages_of_buffered_b1_membrane
                anticipated_percentage_of_buffered_b1_membrane = anticipated_percentages_of_buffered_b1_membrane(indexBM);
                for indexC = 1:length_cycling_rates
                    cycling_rate = anticipated_cycling_rates(indexC);

                    xx_g = xx_g_start;%1.9908e+04;
                    yy_pm = yy_pm_start;%2.0097e+04;

                    %NOG_analytical_predict_concentrations_and_parameter_2;
                    NOG_analytical_predict_concentrations_and_parameter;
                    if (accepted_combination)
                        indexCombination = indexCombination + 1;
                        velocities_per_hour_of_combination(indexCombination) = velocity_per_hour;
                        percentages_of_buffered_b1_membrane(indexCombination) = anticipated_percentage_of_buffered_b1_membrane;
                        cycling_rates(indexCombination) = cycling_rate;

                        start_total_xxs(indexCombination) = xx_g + xx_b1_cg + xx_b1_mtc + xx_b1_cpm + xx_pm + xx_a2_cpm + xx_a2_mtc + xx_a2_cg;
                        start_total_yys(indexCombination) = yy_g + yy_b1_cg + yy_b1_mtc + yy_b1_cpm + yy_pm + yy_a2_cpm + yy_a2_mtc + yy_a2_cg;
                        start_total_uus(indexCombination) = uu_g + uu_b1_cg + uu_b1_mtc + uu_b1_cpm + uu_pm + uu_a2_cpm + uu_a2_mtc + uu_a2_cg;
                        start_total_vvs(indexCombination) = vv_g + vv_b1_cg + vv_b1_mtc + vv_b1_cpm + vv_pm + vv_a2_cpm + vv_a2_mtc + vv_a2_cg;
                        vv_b1_cpms(indexCombination) = vv_b1_cpm;
                        yy_b1_cpms(indexCombination) = yy_b1_cpm;
                        xx_b1_cpms(indexCombination) = xx_b1_cpm;
                        uu_b1_cpms(indexCombination) = uu_b1_cpm;
                        nb1_cpms(indexCombination) = nb1_cpm;
                        v_forwards(indexCombination) = v_forward;
                        v_backwards(indexCombination) = v_backward;
                        uu_b1_cpms(indexCombination) = uu_b1_cpm;
                        u_forwards(indexCombination) = u_forward;
                        u_backwards(indexCombination) = u_backward;
                        start_total_kks(indexCombination) = kk_g + kk_b1_cg + kk_b1_mtc + kk_b1_cpm + kk_pm + kk_a2_cpm + kk_a2_mtc + kk_a2_cg;
                        start_total_dds(indexCombination) = dd_g + dd_b1_cg + dd_b1_mtc + dd_b1_cpm + dd_pm + dd_a2_cpm + dd_a2_mtc + dd_a2_cg;
                        start_total_cc1s(indexCombination) = cc1_g + cc1_b1_cg + cc1_b1_mtc + cc1_b1_cpm + cc1_pm + cc1_a2_cpm + cc1_a2_mtc + cc1_a2_cg;
                        start_total_cc2s(indexCombination) = cc2_g + cc2_b1_cg + cc2_b1_mtc + cc2_b1_cpm + cc2_pm + cc2_a2_cpm + cc2_a2_mtc + cc2_a2_cg;
                        fractions_bound_kk_a1b1_mtc(indexCombination) = fraction_bound_kk_a1b1_mtc;
                        k_xx_productions(indexCombination) = k_xx_production;
                        k_uu_productions(indexCombination) = k_uu_production;
                        k_vv_productions(indexCombination) = k_vv_production;
                        k_yy_productions(indexCombination) = k_yy_production;
                        k_kk_productions(indexCombination) = k_kk_production;
                        k_dd_productions(indexCombination) = k_dd_production;
                        k_cc1_productions(indexCombination) = k_cc1_production;
                        k_cc2_productions(indexCombination) = k_cc2_production;
                        k_membrane_productions(indexCombination) = k_membrane_production;
                        initial_forward_transport_rates(indexCombination) = initial_forward_transport_rate;
                        initial_backward_transport_rates(indexCombination) = initial_backtransport_rate;
                        final_forward_transport_rates(indexCombination) = final_forward_transport_rate;
                        final_backward_transport_rates(indexCombination) = final_backtransport_rate;
                        kappaXU_gs(indexCombination) = kappaXU_g;
                        kappaYV_pms(indexCombination) = kappaYV_pm;
                     end
                end
            end
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

percentage_of_buffered_b1_membrane_for_figure=anticipated_percentages_of_buffered_b1_membrane(1);

%Plot cycling rate vs velocity
velocity_colors = zeros(length_velocities,3);
for indexColor = 1:length_velocities
    red = ((indexColor-1) * (255/length_velocities))/255;
    green = ((indexColor-1) * 90/length_velocities)/255;
    blue = (255 - (indexColor-1) * 255/length_velocities)/255;
    velocity_colors(indexColor,:) = [red green blue];
end

%Plot cycling rate vs velocity

same_cycling_rates_table = tabulate(cycling_rates);
indexKeep = find(same_cycling_rates_table(:,1) >= 0);
same_cycling_rates_table = same_cycling_rates_table(indexKeep,:);
length_cycling_rates = size(same_cycling_rates_table,1);
cycling_rate_colors = zeros(length_cycling_rates,3);
for indexColor = 1:length_cycling_rates
    red = ((indexColor-1) * (255/length_cycling_rates))/255;
    green = ((indexColor-1) * 90/length_cycling_rates)/255;
    blue = (255 - (indexColor-1) * 255/length_cycling_rates)/255;
    cycling_rate_colors(indexColor,:) = [red green blue];
end


for indexK = 1:length_set_kappaYV_pms
    current_kappaYV_pm = set_kappaYV_pms(indexK);
    
    %v-SNARE V
    max_x = max(velocities_per_hour);
    max_y = max(cycling_rates);
    max_z = 20000;%max(start_total_vvs) * 1.1;

    figure;
    plotIndex_of_subfigure = 0;
    figureColumns = 2;
    figureRows = 3;
    
    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);
    percentage_of_buffered_b1_membrane = percentage_of_buffered_b1_membrane_for_figure;
    
    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);
   
        indexCurrent = find( (percentages_of_buffered_b1_membrane==percentage_of_buffered_b1_membrane)...
                            &(velocities_per_hour_of_combination==current_velocity)...
                            &(kappaYV_pms==current_kappaYV_pm));
        x = velocities_per_hour_of_combination(indexCurrent);
        y = cycling_rates(indexCurrent);
        z = start_total_vvs(indexCurrent);% + k_vv_productions(indexCurrentVelocity); %
        %plot3(x,y,z,'.','Color',velocity_colors(indexV,:));
        length_current_values = length(indexCurrent);
        for indexCurrent = 1:length_current_values
            x_line = [x(indexCurrent) x(indexCurrent)];
            y_line = [y(indexCurrent) y(indexCurrent)];
            z_line = [0 z(indexCurrent)];
            plot3(x_line,y_line,z_line,'b','Color',cycling_rate_colors(indexCurrent,:));
            hold on;
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title('v-SNARE V','FontSize',title_fontSize);
        xlabel({'velocity';'[\mum/h NOG]'},'FontSize',axis_label_fontSize);
        ylabel({'Cycling rate';'[\mum{^2}/min]'},'FontSize',axis_label_fontSize);
        zlabel({'Initial v-SNARE V';'[molecules]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end

    %kinesin R
    max_x = max(velocities_per_hour);
    max_y = max(cycling_rates);
    max_z = 1000;%max(start_total_kks) * 1.1;

    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);
    percentage_of_buffered_b1_membrane = percentage_of_buffered_b1_membrane_for_figure;

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);
        indexCurrent = find( (percentages_of_buffered_b1_membrane==percentage_of_buffered_b1_membrane)...
                            &(velocities_per_hour_of_combination==current_velocity)...
                            &(kappaYV_pms==current_kappaYV_pm));
        x = velocities_per_hour_of_combination(indexCurrent);
        y = cycling_rates(indexCurrent);
        z = start_total_kks(indexCurrent);% + k_vv_productions(indexCurrentVelocity); %
        length_current_values = length(indexCurrent);
        for indexCurrent = 1:length_current_values
            x_line = [x(indexCurrent) x(indexCurrent)];
            y_line = [y(indexCurrent) y(indexCurrent)];
            z_line = [0 z(indexCurrent)];
            plot3(x_line,y_line,z_line,'b','Color',cycling_rate_colors(indexCurrent,:));
            hold on;
        end
        %plot3(x,y,z,'.','Color',velocity_colors(indexV,:));
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title('Kinesin receptor','FontSize',title_fontSize);
        xlabel({'velocity';'[\mum/h NOG]'},'FontSize',axis_label_fontSize);
        ylabel({'Cycling rate';'[\mum{^2}/min]'},'FontSize',axis_label_fontSize);
        zlabel({'Initial kinesin R';'[molecules]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end


    %v-SNARE U
    max_x = max(velocities_per_hour);
    max_y = max(cycling_rates);
    max_z = 20000;%max(start_total_uus) * 1.1;

    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);
    percentage_of_buffered_b1_membrane = percentage_of_buffered_b1_membrane_for_figure;

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);
        indexCurrent = find( (percentages_of_buffered_b1_membrane==percentage_of_buffered_b1_membrane)...
                            &(velocities_per_hour_of_combination==current_velocity)...
                            &(kappaYV_pms==current_kappaYV_pm));
        x = velocities_per_hour_of_combination(indexCurrent);
        y = cycling_rates(indexCurrent);
        z = start_total_uus(indexCurrent);% + k_vv_productions(indexCurrentVelocity); %
        length_current_values = length(indexCurrent);
        for indexCurrent = 1:length_current_values
            x_line = [x(indexCurrent) x(indexCurrent)];
            y_line = [y(indexCurrent) y(indexCurrent)];
            z_line = [0 z(indexCurrent)];
            plot3(x_line,y_line,z_line,'b','Color',cycling_rate_colors(indexCurrent,:));
            hold on;
        end
        %plot3(x,y,z,'.','Color',velocity_colors(indexV,:));
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title('v-SNARE U','FontSize',title_fontSize);
        xlabel({'velocity';'[\mum/h NOG]'},'FontSize',axis_label_fontSize);
        ylabel({'Cycling rate';'[\mum{^2}/min]'},'FontSize',axis_label_fontSize);
        zlabel({'Initial v-SNARE U';'[molecules]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end

    %dynein receptor
    max_x = max(velocities_per_hour);
    max_y = max(cycling_rates);
    max_z = 1000;%max(start_total_dds) * 1.1;

    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);
    percentage_of_buffered_b1_membrane = percentage_of_buffered_b1_membrane_for_figure;

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);
        indexCurrent = find( (percentages_of_buffered_b1_membrane==percentage_of_buffered_b1_membrane)...
                            &(velocities_per_hour_of_combination==current_velocity)...
                            &(kappaYV_pms==current_kappaYV_pm));
        x = velocities_per_hour_of_combination(indexCurrent);
        y = cycling_rates(indexCurrent);
        z = start_total_dds(indexCurrent);% + k_vv_productions(indexCurrentVelocity); %
        length_current_values = length(indexCurrent);
        for indexCurrent = 1:length_current_values
            x_line = [x(indexCurrent) x(indexCurrent)];
            y_line = [y(indexCurrent) y(indexCurrent)];
            z_line = [0 z(indexCurrent)];
            plot3(x_line,y_line,z_line,'b','Color',cycling_rate_colors(indexCurrent,:));
            hold on;
        end
        %plot3(x,y,z,'.','Color',velocity_colors(indexV,:));
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title('Dynein receptor','FontSize',title_fontSize);
        xlabel({'velocity';'[\mum/h NOG]'},'FontSize',axis_label_fontSize);
        ylabel({'Cycling rate';'[\mum{^2}/min]'},'FontSize',axis_label_fontSize);
        zlabel({'Initial dynein R';'[molecules]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end

    %v-SNARE V + v-SNARE U
    max_x = max(velocities_per_hour);
    max_y = max(cycling_rates);
    max_z = 40000;%max(start_total_uus) * 1.1;

    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);
    percentage_of_buffered_b1_membrane = percentage_of_buffered_b1_membrane_for_figure;

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);
        indexCurrent = find( (percentages_of_buffered_b1_membrane==percentage_of_buffered_b1_membrane)...
                            &(velocities_per_hour_of_combination==current_velocity)...
                            &(kappaYV_pms==current_kappaYV_pm));
        x = velocities_per_hour_of_combination(indexCurrent);
        y = cycling_rates(indexCurrent);
        z = start_total_vvs(indexCurrent) + start_total_uus(indexCurrent);% + k_vv_productions(indexCurrentVelocity); %
        %plot3(x,y,z,'.','Color',velocity_colors(indexV,:));
        length_current_values = length(indexCurrent);
        for indexCurrent = 1:length_current_values
            x_line = [x(indexCurrent) x(indexCurrent)];
            y_line = [y(indexCurrent) y(indexCurrent)];
            z_line = [0 z(indexCurrent)];
            plot3(x_line,y_line,z_line,'b','Color',cycling_rate_colors(indexCurrent,:));
            hold on;
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title('v-SNAREs V + U','FontSize',title_fontSize);
        xlabel({'velocity';'[\mum/h NOG]'},'FontSize',axis_label_fontSize);
        ylabel({'Cycling rate';'[\mum{^2}/min]'},'FontSize',axis_label_fontSize);
        zlabel({'Initial v-SNARE U';'[molecules]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end

    %kinesin + dynein receptor
    max_x = max(velocities_per_hour);
    max_y = max(cycling_rates);
    max_z = 1500;%max(start_total_dds) * 1.1;

    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);
    percentage_of_buffered_b1_membrane = percentage_of_buffered_b1_membrane_for_figure;

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);
        indexCurrent = find( (percentages_of_buffered_b1_membrane==percentage_of_buffered_b1_membrane)...
                            &(velocities_per_hour_of_combination==current_velocity)...
                            &(kappaYV_pms==current_kappaYV_pm));
        x = velocities_per_hour_of_combination(indexCurrent);
        y = cycling_rates(indexCurrent);
        z = start_total_kks(indexCurrent) + start_total_dds(indexCurrent);% + k_vv_productions(indexCurrentVelocity); %
        %plot3(x,y,z,'.','Color',velocity_colors(indexV,:));
        length_current_values = length(indexCurrent);
        for indexCurrent = 1:length_current_values
            x_line = [x(indexCurrent) x(indexCurrent)];
            y_line = [y(indexCurrent) y(indexCurrent)];
            z_line = [0 z(indexCurrent)];
            plot3(x_line,y_line,z_line,'b','Color',cycling_rate_colors(indexCurrent,:));
            hold on;
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title('Dynein + kinesin receptor','FontSize',title_fontSize);
        xlabel({'velocity';'[\mum/h NOG]'},'FontSize',axis_label_fontSize);
        ylabel({'Cycling rate';'[\mum{^2}/min]'},'FontSize',axis_label_fontSize);
        zlabel({'Initial Receptors';'[molecules]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end

    figure_label = strcat('3Dplot_start_molecules_kappaYV_pm_',num2str(current_kappaYV_pm),'.png');
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 3.3*figureColumns 2*figureRows])
    print(figure_label,'-dpng','-r600');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%% Plot production rates
    figure;
    plotIndex_of_subfigure = 0;
    figureColumns = 2;
    figureRows = 2;
    title_fontSize = 10;
    axis_label_fontSize = 8;
    cycling_rate_for_figure = 1;

    %%% Plot vv production rates
    max_x = max(velocities_per_hour);
    max_y = max(percentages_of_buffered_b1_membrane);
    max_z = 100;%max(k_vv_productions) * 1.1;

    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);
        indexCurrent = find( (cycling_rates==cycling_rate_for_figure)...
                            &(velocities_per_hour_of_combination==current_velocity)...
                            &(kappaYV_pms==current_kappaYV_pm));
        x = velocities_per_hour_of_combination(indexCurrent);
        y = percentages_of_buffered_b1_membrane(indexCurrent);
        z = k_vv_productions(indexCurrent); %
        %plot3(x,y,z,'.','Color',velocity_colors(indexV,:));
        length_current_values = length(indexCurrent);
        for indexCurrent = 1:length_current_values
            x_line = [x(indexCurrent) x(indexCurrent)];
            y_line = [y(indexCurrent) y(indexCurrent)];
            z_line = [0 z(indexCurrent)];
            plot3(x_line,y_line,z_line,'b','Color',cycling_rate_colors(indexCurrent,:));
            hold on;
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title('v-SNARE V production rate','FontSize',title_fontSize);
        xlabel({'velocity';'[\mum/h NOG]'},'FontSize',axis_label_fontSize);
        ylabel({'Percentage of';'buffered membrane in MTC'},'FontSize',axis_label_fontSize);
        zlabel({'production rate';'[molecules/min]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end

    %%% Plot uu production rates
    max_x = max(velocities_per_hour);
    max_y = max(percentages_of_buffered_b1_membrane);
    max_z = 100;%max(k_uu_productions) * 1.1;

    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);
        indexCurrent = find( (cycling_rates==cycling_rate_for_figure)...
                            &(velocities_per_hour_of_combination==current_velocity)...
                            &(kappaYV_pms==current_kappaYV_pm));
        x = velocities_per_hour_of_combination(indexCurrent);
        y = percentages_of_buffered_b1_membrane(indexCurrent);
        z = k_uu_productions(indexCurrent); %
        %plot3(x,y,z,'.','Color',velocity_colors(indexV,:));
        length_current_values = length(indexCurrent);
        for indexCurrent = 1:length_current_values
            x_line = [x(indexCurrent) x(indexCurrent)];
            y_line = [y(indexCurrent) y(indexCurrent)];
            z_line = [0 z(indexCurrent)];
            plot3(x_line,y_line,z_line,'b','Color',cycling_rate_colors(indexCurrent,:));
            hold on;
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title('v-SNARE U production rate','FontSize',title_fontSize);
        xlabel({'velocity';'[\mum/h NOG]'},'FontSize',axis_label_fontSize);
        ylabel({'Percentage of';'buffered membrane in MTC'},'FontSize',axis_label_fontSize);
        zlabel({'production rate';'[molecules/min]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end

    %%% Plot kk production rates
    max_x = max(velocities_per_hour);
    max_y = max(percentages_of_buffered_b1_membrane);
    max_z = 30;%max(k_kk_productions) * 1.1;

    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);
        indexCurrent = find( (cycling_rates==cycling_rate_for_figure)...
                            &(velocities_per_hour_of_combination==current_velocity)...
                            &(kappaYV_pms==current_kappaYV_pm));
        x = velocities_per_hour_of_combination(indexCurrent);
        y = percentages_of_buffered_b1_membrane(indexCurrent);
        z = k_kk_productions(indexCurrent); %
        %plot3(x,y,z,'.','Color',velocity_colors(indexV,:));
        length_current_values = length(indexCurrent);
        for indexCurrent = 1:length_current_values
            x_line = [x(indexCurrent) x(indexCurrent)];
            y_line = [y(indexCurrent) y(indexCurrent)];
            z_line = [0 z(indexCurrent)];
            plot3(x_line,y_line,z_line,'b','Color',cycling_rate_colors(indexCurrent,:));
            hold on;
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title('Kinesin receptor production rate','FontSize',title_fontSize);
        xlabel({'velocity';'[\mum/h NOG]'},'FontSize',axis_label_fontSize);
        ylabel({'Percentage of';'buffered membrane in MTC'},'FontSize',axis_label_fontSize);
        zlabel({'production rate';'[molecules/min]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end


    %%% Plot dd production rates
    max_x = max(velocities_per_hour);
    max_y = max(percentages_of_buffered_b1_membrane);
    max_z = 5;%max(k_dd_productions) * 1.1;

    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);
        indexCurrent = find( (cycling_rates==cycling_rate_for_figure)...
                            &(velocities_per_hour_of_combination==current_velocity)...
                            &(kappaYV_pms==current_kappaYV_pm));
        x = velocities_per_hour_of_combination(indexCurrent);
        y = percentages_of_buffered_b1_membrane(indexCurrent);
        z = k_dd_productions(indexCurrent); %
        %plot3(x,y,z,'.','Color',velocity_colors(indexV,:));
        length_current_values = length(indexCurrent);
        for indexCurrent = 1:length_current_values
            x_line = [x(indexCurrent) x(indexCurrent)];
            y_line = [y(indexCurrent) y(indexCurrent)];
            z_line = [0 z(indexCurrent)];
            plot3(x_line,y_line,z_line,'b','Color',cycling_rate_colors(indexCurrent,:));
            hold on;
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title('Dynein receptor production rate','FontSize',title_fontSize);
        xlabel({'velocity';'[\mum/h NOG]'},'FontSize',axis_label_fontSize);
        ylabel({'Percentage of';'buffered membrane in MTC'},'FontSize',axis_label_fontSize);
        zlabel({'production rate';'[molecules/min]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end


    figure_label = strcat('3Dplot_production_rates_kappaYV_pm_',num2str(current_kappaYV_pm),'.png');
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 3.3*figureColumns 2*figureRows])
    print(figure_label,'-dpng','-r600');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (investigate_SNAREs1_motorProtein2==1)
    %Plot initial v-SNAREs vs cycling rate and kappaYV_pm

    kappaYV_colors = zeros(length_set_kappaYV_pms,3);
    for indexColor = 1:length_set_kappaYV_pms
         red = ((indexColor-1) * (255/length_set_kappaYV_pms))/255;
         green = ((indexColor-1) * 90/length_set_kappaYV_pms)/255;
         blue = (255 - (indexColor-1) * 255/length_set_kappaYV_pms)/255;
         kappaYV_colors(indexColor,:) = [red green blue];
    end
 
    cycling_colors = zeros(length_cycling_rates,3);
    for indexColor = 1:length_cycling_rates
         red = ((indexColor-1) * (255/length_cycling_rates))/255;
         green = ((indexColor-1) * 90/length_cycling_rates)/255;
         blue = (255 - (indexColor-1) * 255/length_cycling_rates)/255;
         cycling_colors(indexColor,:) = [red green blue];
    end
 
    figure;
    plotIndex_of_subfigure = 0;
    figureColumns = length_velocities;
    figureRows = 3;

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);

        %v-SNARE V
        max_x = max(kappaYV_pms);
        max_y = max(cycling_rates);
        max_z = 20000;%max(max(start_total_vvs),max(start_total_uus)) * 1.1;

        plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
        subplot(figureRows,figureColumns,plotIndex_of_subfigure);

        for indexC = 1:length_cycling_rates
            current_cycling_rate = anticipated_cycling_rates(indexC);

            indexCurrent = find( (velocities_per_hour_of_combination==current_velocity)...
                                &(cycling_rates==current_cycling_rate));
            x = kappaYV_pms(indexCurrent);
            y = cycling_rates(indexCurrent);
            z = start_total_vvs(indexCurrent);
            length_current_values = length(indexCurrent);
            if (length_current_values>0)
                for indexCurrent = 1:length_current_values
                    x_line = [x(indexCurrent) x(indexCurrent)];
                    y_line = [y(indexCurrent) y(indexCurrent)];
                    z_line = [0 z(indexCurrent)];
                    plot3(x_line,y_line,z_line,'b','Color',cycling_colors(indexC,:));
                    hold on;
                end
            end
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        set(gca,'FontSize',axis_tick_fontSize);
        title({'v-SNARE V';char(strcat('at',{' '},num2str(current_velocity),'\mum/h NOG'))},'FontSize',title_fontSize);
        xlabel({'tethering at GC';'[/molecule]'},'FontSize',axis_label_fontSize);
        ylabel({'Cycling rate';'[\mum{^2}/min]'},'FontSize',axis_label_fontSize);
        zlabel({'Initial v-SNARE V';'[molecules]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;
    end

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);
        %v-SNARE U
        max_x = max(kappaYV_pms);
        max_y = max(cycling_rates);
        max_z = 20000;
        plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
        subplot(figureRows,figureColumns,plotIndex_of_subfigure);

        for indexC = 1:length_cycling_rates
            current_cycling_rate = anticipated_cycling_rates(indexC);

            indexCurrent = find( (velocities_per_hour_of_combination==current_velocity)...
                                &(cycling_rates==current_cycling_rate));
            x = kappaYV_pms(indexCurrent);
            y = cycling_rates(indexCurrent);
            z = start_total_uus(indexCurrent);
            length_current_values = length(indexCurrent);
            if (length_current_values>0)
                for indexCurrent = 1:length_current_values
                    x_line = [x(indexCurrent) x(indexCurrent)];
                    y_line = [y(indexCurrent) y(indexCurrent)];
                    z_line = [0 z(indexCurrent)];
                    plot3(x_line,y_line,z_line,'b','Color',cycling_colors(indexC,:));
                    hold on;
                end
            end
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        set(gca,'FontSize',axis_tick_fontSize);
        title({'v-SNARE U';char(strcat('at',{' '},num2str(current_velocity),'\mum/h NOG'))},'FontSize',title_fontSize);
        xlabel({'tethering at GC';'[/molecule]'},'FontSize',axis_label_fontSize);
        ylabel({'Cycling rate';'[\mum{^2}/min]'},'FontSize',axis_label_fontSize);
        zlabel({'Initial v-SNARE U';'[molecules]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;
    end

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);

        %v-SNAREs V + U
        max_x = max(kappaYV_pms);
        max_y = max(cycling_rates);
        max_z = 40000;

        plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
        subplot(figureRows,figureColumns,plotIndex_of_subfigure);

        for indexC = 1:length_cycling_rates
            current_cycling_rate = anticipated_cycling_rates(indexC);

            indexCurrent = find( (velocities_per_hour_of_combination==current_velocity)...
                                &(cycling_rates==current_cycling_rate));
            x = kappaYV_pms(indexCurrent);
            y = cycling_rates(indexCurrent);
            z = start_total_vvs(indexCurrent) + start_total_uus(indexCurrent);
            length_current_values = length(indexCurrent);
            if (length_current_values>0)
                for indexCurrent = 1:length_current_values
                    x_line = [x(indexCurrent) x(indexCurrent)];
                    y_line = [y(indexCurrent) y(indexCurrent)];
                    z_line = [0 z(indexCurrent)];
                    plot3(x_line,y_line,z_line,'b','Color',cycling_colors(indexC,:));
                    hold on;
                end
            end
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        set(gca,'FontSize',axis_tick_fontSize);
        title({'v-SNAREs V+U';char(strcat('at',{' '},num2str(current_velocity),'\mum/h NOG'))},'FontSize',title_fontSize);
        xlabel({'tethering at GC';'[/molecule]'},'FontSize',axis_label_fontSize);
        ylabel({'Cycling rate';'[\mum{^2}/min]'},'FontSize',axis_label_fontSize);
        zlabel({'Initial v-SNAREs V + U';'[molecules]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;
    end

    figure_label = 'SNAREs_initial';
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 3.3*figureColumns 2*figureRows])
    print(figure_label,'-dpng','-r600');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %Plot initial v-SNAREs vs cycling rate and kappaYV_pm
    current_percentage_of_buffered_b1_membrane = 10;

    kappaYV_colors = zeros(length_set_kappaYV_pms,3);
    for indexColor = 1:length_set_kappaYV_pms
         red = ((indexColor-1) * (255/length_set_kappaYV_pms))/255;
         green = ((indexColor-1) * 90/length_set_kappaYV_pms)/255;
         blue = (255 - (indexColor-1) * 255/length_set_kappaYV_pms)/255;
         kappaYV_colors(indexColor,:) = [red green blue];
    end

    figure;
    plotIndex_of_subfigure = 0;
    figureColumns = length_velocities;
    figureRows = 3;

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);

        %v-SNARE V
        max_x = max(kappaYV_pms);
        max_y = max(cycling_rates);
        max_z = 50;
        plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
        subplot(figureRows,figureColumns,plotIndex_of_subfigure);

        for indexC = 1:length_cycling_rates
            current_cycling_rate = anticipated_cycling_rates(indexC);

            indexCurrent = find( (velocities_per_hour_of_combination==current_velocity)...
                                &(cycling_rates==current_cycling_rate));
            x = kappaYV_pms(indexCurrent);
            y = cycling_rates(indexCurrent);
            z = k_vv_productions(indexCurrent);
            length_current_values = length(indexCurrent);
            if (length_current_values>0)
                for indexCurrent = 1:length_current_values
                    x_line = [x(indexCurrent) x(indexCurrent)];
                    y_line = [y(indexCurrent) y(indexCurrent)];
                    z_line = [0 z(indexCurrent)];
                    plot3(x_line,y_line,z_line,'b','Color',cycling_colors(indexC,:));
                    hold on;
                end
            end
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        set(gca,'FontSize',axis_tick_fontSize);
        title({'v-SNARE V';char(strcat('at',{' '},num2str(current_velocity),'\mum/h NOG'))},'FontSize',title_fontSize);
        xlabel({'tethering at GC';'[/molecule]'},'FontSize',axis_label_fontSize);
        ylabel({'Cycling rate';'[\mum{^2}/min]'},'FontSize',axis_label_fontSize);
        zlabel({'v-SNARE V production';'[molecules/min]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);
        
        %v-SNARE U
        max_x = max(kappaYV_pms);
        max_y = max(cycling_rates);
        max_z = 50;

        plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
        subplot(figureRows,figureColumns,plotIndex_of_subfigure);

        for indexC = 1:length_cycling_rates
            current_cycling_rate = anticipated_cycling_rates(indexC);

            indexCurrent = find( (velocities_per_hour_of_combination==current_velocity)...
                                &(cycling_rates==current_cycling_rate));
            x = kappaYV_pms(indexCurrent);
            y = cycling_rates(indexCurrent);
            z = k_uu_productions(indexCurrent);
            length_current_values = length(indexCurrent);
            if (length_current_values>0)
                for indexCurrent = 1:length_current_values
                    x_line = [x(indexCurrent) x(indexCurrent)];
                    y_line = [y(indexCurrent) y(indexCurrent)];
                    z_line = [0 z(indexCurrent)];
                    plot3(x_line,y_line,z_line,'b','Color',cycling_colors(indexC,:));
                    hold on;
                end
            end
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        set(gca,'FontSize',axis_tick_fontSize);
        title({'v-SNARE U';char(strcat('at',{' '},num2str(current_velocity),'\mum/h NOG'))},'FontSize',title_fontSize);
        xlabel({'tethering at GC';'[/molecule]'},'FontSize',axis_label_fontSize);
        ylabel({'Cycling rate';'[\mum{^2}/min]'},'FontSize',axis_label_fontSize);
        zlabel({'v-SNARE U production';'[molecules/min]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;
    end

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);

        %v-SNAREs V + U
        max_x = max(kappaYV_pms);
        max_y = max(cycling_rates);
        max_z = 100;%max(k_uu_production + k_vv_production) * 1.1;

        plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
        subplot(figureRows,figureColumns,plotIndex_of_subfigure);

        for indexC = 1:length_cycling_rates
            current_cycling_rate = anticipated_cycling_rates(indexC);

            indexCurrent = find( (velocities_per_hour_of_combination==current_velocity)...
                                &(cycling_rates==current_cycling_rate));
            x = kappaYV_pms(indexCurrent);
            y = cycling_rates(indexCurrent);
            z = k_vv_productions(indexCurrent) + k_uu_productions(indexCurrent); %
            length_current_values = length(indexCurrent);
            if (length_current_values>0)
                for indexCurrent = 1:length_current_values
                    x_line = [x(indexCurrent) x(indexCurrent)];
                    y_line = [y(indexCurrent) y(indexCurrent)];
                    z_line = [0 z(indexCurrent)];
                    plot3(x_line,y_line,z_line,'b','Color',cycling_colors(indexC,:));
                    hold on;
                end
            end
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title({'v-SNAREs V+U';char(strcat('at',{' '},num2str(current_velocity),'\mum/h NOG'))},'FontSize',title_fontSize);
        xlabel({'tethering at GC';'[/molecule]'},'FontSize',axis_label_fontSize);
        ylabel({'Cycling rate';'[\mum{^2}/min]'},'FontSize',axis_label_fontSize);
        zlabel({'v-SNAREs V + U production rate';'[molecules/min]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;
    end

    figure_label = 'SNAREs_production_rates';
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 3.3*figureColumns 2*figureRows])
    print(figure_label,'-dpng','-r600');
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if (investigate_SNAREs1_motorProtein2==2)
    %Plot initial kinesin and dynein R vs cycling rate and percentage of buffered membrane
    percentage_colors = zeros(length_anticipated_percentages_of_buffered_b1_membrane,3);
    for indexColor = 1:length_anticipated_percentages_of_buffered_b1_membrane
         red = ((indexColor-1) * (255/length_anticipated_percentages_of_buffered_b1_membrane))/255;
         green = ((indexColor-1) * 90/length_anticipated_percentages_of_buffered_b1_membrane)/255;
         blue = (255 - (indexColor-1) * 255/length_anticipated_percentages_of_buffered_b1_membrane)/255;
         percentage_colors(indexColor,:) = [red green blue];
    end

    figure;
    plotIndex_of_subfigure = 0;
    figureColumns = length_velocities;
    figureRows = 3;

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);

        %Kinesin R
        max_y = max(percentages_of_buffered_b1_membrane);
        max_x = max(fractions_bound_kk_a1b1_mtc) * 100;
        max_z = 1000;%max(max(start_total_vvs),max(start_total_uus)) * 1.1;

        plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
        subplot(figureRows,figureColumns,plotIndex_of_subfigure);

        for indexP = 1:length_anticipated_percentages_of_buffered_b1_membrane
            current_current_percentage_of_buffered_b1_membrane = anticipated_percentages_of_buffered_b1_membrane(indexP);

            indexCurrent = find( (percentages_of_buffered_b1_membrane==current_current_percentage_of_buffered_b1_membrane)...
                                &(velocities_per_hour_of_combination==current_velocity));
            y = percentages_of_buffered_b1_membrane(indexCurrent);
            x = fractions_bound_kk_a1b1_mtc(indexCurrent) * 100;
            z = start_total_kks(indexCurrent);% + k_vv_productions(indexCurrentVelocity); %
            %plot3(x,y,z,'.','Color',velocity_colors(indexV,:));
            length_current_values = length(indexCurrent);
            if (length_current_values>0)
                for indexCurrent = 1:length_current_values
                    x_line = [x(indexCurrent) x(indexCurrent)];
                    y_line = [y(indexCurrent) y(indexCurrent)];
                    z_line = [0 z(indexCurrent)];
                    plot3(x_line,y_line,z_line,'b','Color',percentage_colors(indexP,:));
                    hold on;
                end
            end
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        set(gca,'FontSize',axis_tick_fontSize);
        title({'Kinesin R';char(strcat('at',{' '},num2str(current_velocity),'\mum/h NOG'))},'FontSize',title_fontSize);
        ylabel({'Buffered membrane';'[%]'},'FontSize',axis_label_fontSize);
        xlabel({'Bound kinesin in MTC';'[%]'},'FontSize',axis_label_fontSize);
        zlabel({'Initial kinesin R';'[molecules]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

        hold off;
    end

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);

        %Dynein R
        max_y = max(percentages_of_buffered_b1_membrane);
        max_x = max(fractions_bound_kk_a1b1_mtc) * 100;
        max_z = 1000;%max(max(start_total_vvs),max(start_total_uus)) * 1.1;

        plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
        subplot(figureRows,figureColumns,plotIndex_of_subfigure);

        for indexP = 1:length_anticipated_percentages_of_buffered_b1_membrane
            current_current_percentage_of_buffered_b1_membrane = anticipated_percentages_of_buffered_b1_membrane(indexP);

            indexCurrent = find( (percentages_of_buffered_b1_membrane==current_current_percentage_of_buffered_b1_membrane)...
                                &(velocities_per_hour_of_combination==current_velocity));
            y = percentages_of_buffered_b1_membrane(indexCurrent);
            x = fractions_bound_kk_a1b1_mtc(indexCurrent) * 100;
            z = start_total_dds(indexCurrent);% + k_vv_productions(indexCurrentVelocity); %
            %plot3(x,y,z,'.','Color',velocity_colors(indexV,:));
            length_current_values = length(indexCurrent);
            if (length_current_values>0)
                for indexCurrent = 1:length_current_values
                    x_line = [x(indexCurrent) x(indexCurrent)];
                    y_line = [y(indexCurrent) y(indexCurrent)];
                    z_line = [0 z(indexCurrent)];
                    plot3(x_line,y_line,z_line,'b','Color',percentage_colors(indexP,:));
                    hold on;
                end
            end
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        set(gca,'FontSize',axis_tick_fontSize);
        title({'Dynein R';char(strcat('at',{' '},num2str(current_velocity),'\mum/h NOG'))},'FontSize',title_fontSize);
        ylabel({'Buffered membrane';'[%]'},'FontSize',axis_label_fontSize);
        xlabel({'Bound kinesin in MTC';'[%]'},'FontSize',axis_label_fontSize);
        zlabel({'Initial dynein R';'[molecules]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;
    end

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);

        %Dynein R
        max_y = max(percentages_of_buffered_b1_membrane);
        max_x = max(fractions_bound_kk_a1b1_mtc) * 100;
        max_z = 2000;%max(max(start_total_vvs),max(start_total_uus)) * 1.1;

        plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
        subplot(figureRows,figureColumns,plotIndex_of_subfigure);

        for indexP = 1:length_anticipated_percentages_of_buffered_b1_membrane
            current_current_percentage_of_buffered_b1_membrane = anticipated_percentages_of_buffered_b1_membrane(indexP);

            indexCurrent = find( (percentages_of_buffered_b1_membrane==current_current_percentage_of_buffered_b1_membrane)...
                                &(velocities_per_hour_of_combination==current_velocity));
            y = percentages_of_buffered_b1_membrane(indexCurrent);
            x = fractions_bound_kk_a1b1_mtc(indexCurrent) * 100;
            z = start_total_kks(indexCurrent) + start_total_dds(indexCurrent);% + k_vv_productions(indexCurrentVelocity); %
            %plot3(x,y,z,'.','Color',velocity_colors(indexV,:));
            length_current_values = length(indexCurrent);
            if (length_current_values>0)
                for indexCurrent = 1:length_current_values
                    x_line = [x(indexCurrent) x(indexCurrent)];
                    y_line = [y(indexCurrent) y(indexCurrent)];
                    z_line = [0 z(indexCurrent)];
                    plot3(x_line,y_line,z_line,'b','Color',percentage_colors(indexP,:));
                    hold on;
                end
            end
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        set(gca,'FontSize',axis_tick_fontSize);
        title({'Dynein R + Kinesin R';char(strcat('at',{' '},num2str(current_velocity),'\mum/h NOG'))},'FontSize',title_fontSize);
        ylabel({'Buffered membrane';'[%]'},'FontSize',axis_label_fontSize);
        xlabel({'Bound kinesin in MTC';'[%]'},'FontSize',axis_label_fontSize);
        zlabel({'Initial R';'[molecules]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;
    end

    figure_label = 'Motor_proteins_initial';
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 3.3*figureColumns 2*figureRows])
    print(figure_label,'-dpng','-r600');
    
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %Plot production rates    
    
    
    figure;
    plotIndex_of_subfigure = 0;
    figureColumns = length_velocities;
    figureRows = 4;

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);

        %v-SNARE V
        max_y = max(percentages_of_buffered_b1_membrane);
        max_x = max(fractions_bound_kk_a1b1_mtc) * 100;
        max_z = max(max(k_vv_productions),max(k_uu_productions)) * 1.1;

        plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
        subplot(figureRows,figureColumns,plotIndex_of_subfigure);

        for indexP = 1:length_anticipated_percentages_of_buffered_b1_membrane
            current_current_percentage_of_buffered_b1_membrane = anticipated_percentages_of_buffered_b1_membrane(indexP);

            indexCurrent = find( (percentages_of_buffered_b1_membrane==current_current_percentage_of_buffered_b1_membrane)...
                                &(velocities_per_hour_of_combination==current_velocity));
            y = percentages_of_buffered_b1_membrane(indexCurrent);
            x = fractions_bound_kk_a1b1_mtc(indexCurrent) * 100;
            z = k_vv_productions(indexCurrent);% + k_vv_productions(indexCurrentVelocity); %
            %plot3(x,y,z,'.','Color',velocity_colors(indexV,:));
            length_current_values = length(indexCurrent);
            if (length_current_values>0)
                for indexCurrent = 1:length_current_values
                    x_line = [x(indexCurrent) x(indexCurrent)];
                    y_line = [y(indexCurrent) y(indexCurrent)];
                    z_line = [0 z(indexCurrent)];
                    plot3(x_line,y_line,z_line,'b','Color',percentage_colors(indexP,:));
                    hold on;
                end
            end
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        set(gca,'FontSize',axis_tick_fontSize);
        title({'v-SNARE V';char(strcat('at',{' '},num2str(current_velocity),'\mum/h NOG'))},'FontSize',title_fontSize);
        ylabel({'Buffered membrane';'[%]'},'FontSize',axis_label_fontSize);
        xlabel({'Bound kinesin in MTC';'[%]'},'FontSize',axis_label_fontSize);
        zlabel({'Production rate';'[molecules/min]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

        hold off;
    end

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);

        %v-SNARE U
        max_y = max(percentages_of_buffered_b1_membrane);
        max_x = max(fractions_bound_kk_a1b1_mtc) * 100;
        max_z = max(max(k_vv_productions),max(k_uu_productions)) * 1.1;

        plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
        subplot(figureRows,figureColumns,plotIndex_of_subfigure);

        for indexP = 1:length_anticipated_percentages_of_buffered_b1_membrane
            current_current_percentage_of_buffered_b1_membrane = anticipated_percentages_of_buffered_b1_membrane(indexP);

            indexCurrent = find( (percentages_of_buffered_b1_membrane==current_current_percentage_of_buffered_b1_membrane)...
                                &(velocities_per_hour_of_combination==current_velocity));
            y = percentages_of_buffered_b1_membrane(indexCurrent);
            x = fractions_bound_kk_a1b1_mtc(indexCurrent) * 100;
            z = k_uu_productions(indexCurrent);% + k_vv_productions(indexCurrentVelocity); %
            %plot3(x,y,z,'.','Color',velocity_colors(indexV,:));
            length_current_values = length(indexCurrent);
            if (length_current_values>0)
                for indexCurrent = 1:length_current_values
                    x_line = [x(indexCurrent) x(indexCurrent)];
                    y_line = [y(indexCurrent) y(indexCurrent)];
                    z_line = [0 z(indexCurrent)];
                    plot3(x_line,y_line,z_line,'b','Color',percentage_colors(indexP,:));
                    hold on;
                end
            end
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        set(gca,'FontSize',axis_tick_fontSize);
        title({'v-SNARE U';char(strcat('at',{' '},num2str(current_velocity),'\mum/h NOG'))},'FontSize',title_fontSize);
        ylabel({'Buffered membrane';'[%]'},'FontSize',axis_label_fontSize);
        xlabel({'Bound kinesin in MTC';'[%]'},'FontSize',axis_label_fontSize);
        zlabel({'Production rate';'[molecules/min]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;
    end

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);

        %Kinesin R
        max_y = max(percentages_of_buffered_b1_membrane);
        max_x = max(fractions_bound_kk_a1b1_mtc) * 100;
        max_z = max(max(k_kk_productions),max(k_dd_productions)) * 1.1;

        plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
        subplot(figureRows,figureColumns,plotIndex_of_subfigure);

        for indexP = 1:length_anticipated_percentages_of_buffered_b1_membrane
            current_current_percentage_of_buffered_b1_membrane = anticipated_percentages_of_buffered_b1_membrane(indexP);

            indexCurrent = find( (percentages_of_buffered_b1_membrane==current_current_percentage_of_buffered_b1_membrane)...
                                &(velocities_per_hour_of_combination==current_velocity));
            y = percentages_of_buffered_b1_membrane(indexCurrent);
            x = fractions_bound_kk_a1b1_mtc(indexCurrent) * 100;
            z = k_kk_productions(indexCurrent);%
            length_current_values = length(indexCurrent);
            if (length_current_values>0)
                for indexCurrent = 1:length_current_values
                    x_line = [x(indexCurrent) x(indexCurrent)];
                    y_line = [y(indexCurrent) y(indexCurrent)];
                    z_line = [0 z(indexCurrent)];
                    plot3(x_line,y_line,z_line,'b','Color',percentage_colors(indexP,:));
                    hold on;
                end
            end
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        set(gca,'FontSize',axis_tick_fontSize);
        title({'Kinesin R';char(strcat('at',{' '},num2str(current_velocity),'\mum/h NOG'))},'FontSize',title_fontSize);
        ylabel({'Buffered membrane';'[%]'},'FontSize',axis_label_fontSize);
        xlabel({'Bound kinesin in MTC';'[%]'},'FontSize',axis_label_fontSize);
        zlabel({'Production rate';'[molecules/min]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;
    end

    for indexV = 1:length_velocities
        current_velocity = velocities_per_hour(indexV);

        %Dynein R
        max_y = max(percentages_of_buffered_b1_membrane);
        max_x = max(fractions_bound_kk_a1b1_mtc) * 100;
        max_z = max(max(k_kk_productions),max(k_dd_productions)) * 1.1;

        plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
        subplot(figureRows,figureColumns,plotIndex_of_subfigure);

        for indexP = 1:length_anticipated_percentages_of_buffered_b1_membrane
            current_current_percentage_of_buffered_b1_membrane = anticipated_percentages_of_buffered_b1_membrane(indexP);

            indexCurrent = find( (percentages_of_buffered_b1_membrane==current_current_percentage_of_buffered_b1_membrane)...
                                &(velocities_per_hour_of_combination==current_velocity));
            y = percentages_of_buffered_b1_membrane(indexCurrent);
            x = fractions_bound_kk_a1b1_mtc(indexCurrent) * 100;
            z = k_dd_productions(indexCurrent);%
            length_current_values = length(indexCurrent);
            if (length_current_values>0)
                for indexCurrent = 1:length_current_values
                    x_line = [x(indexCurrent) x(indexCurrent)];
                    y_line = [y(indexCurrent) y(indexCurrent)];
                    z_line = [0 z(indexCurrent)];
                    plot3(x_line,y_line,z_line,'b','Color',percentage_colors(indexP,:));
                    hold on;
                end
            end
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        set(gca,'FontSize',axis_tick_fontSize);
        title({'Dynein R';char(strcat('at',{' '},num2str(current_velocity),'\mum/h NOG'))},'FontSize',title_fontSize);
        ylabel({'Buffered membrane';'[%]'},'FontSize',axis_label_fontSize);
        xlabel({'Bound kinesin in MTC';'[%]'},'FontSize',axis_label_fontSize);
        zlabel({'Production rate';'[molecules/min]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;
    end

    figure_label = 'Production_rates';
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 3.3*figureColumns 2*figureRows])
    print(figure_label,'-dpng','-r600');
    
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%Plot cycling rate vs kappa_YV
kappaYV_colors = zeros(length_set_kappaYV_pms,3);
for indexColor = 1:length_set_kappaYV_pms
    red = ((indexColor-1) * (255/length_set_kappaYV_pms))/255;
    green = ((indexColor-1) * 90/length_set_kappaYV_pms)/255;
    blue = (255 - (indexColor-1) * 255/length_set_kappaYV_pms)/255;
    kappaYV_colors(indexColor,:) = [red green blue];
end

for indexV = 1:length_velocities
    current_velocity = velocities_per_hour(indexV);
    
    figure;
    plotIndex_of_subfigure = 0;
    figureColumns = 2;
    figureRows = 3;

    %v-SNARE V
    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);
    max_x = max(kappaYV_pms);
    max_y = max(cycling_rates);
    max_z = 20000;%max(start_total_kks) * 1.1;
    
    for indexK = 1:length_set_kappaYV_pms
        current_kappaYV_pm = set_kappaYV_pms(indexK);
    
        indexCurrent = find( (percentages_of_buffered_b1_membrane==percentage_of_buffered_b1_membrane)...
                            &(velocities_per_hour_of_combination==current_velocity)...
                            &(kappaYV_pms==current_kappaYV_pm));
        x = kappaYV_pms(indexCurrent);
        y = cycling_rates(indexCurrent);
        z = start_total_vvs(indexCurrent);% + k_vv_productions(indexCurrentVelocity); %
        %plot3(x,y,z,'.','Color',velocity_colors(indexV,:));
        length_current_values = length(indexCurrent);
        for indexCurrent = 1:length_current_values
            x_line = [x(indexCurrent) x(indexCurrent)];
            y_line = [y(indexCurrent) y(indexCurrent)];
            z_line = [0 z(indexCurrent)];
            plot3(x_line,y_line,z_line,'b','Color',kappaYV_colors(indexK,:));
            hold on;
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title('v-SNARE V','FontSize',title_fontSize);
        xlabel({'tethering at GC';'[/molecule]'},'FontSize',axis_label_fontSize);
        ylabel({'Cycling rate';'[\mum{^2}/min]'},'FontSize',axis_label_fontSize);
        zlabel({'Initial v-SNARE V';'[molecules]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end

    %kinesin R
    max_x = max(kappaYV_pms);
    max_y = max(cycling_rates);
    max_z = 1000;%max(start_total_kks) * 1.1;

    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);
    percentage_of_buffered_b1_membrane = percentage_of_buffered_b1_membrane_for_figure;

    for indexK = 1:length_set_kappaYV_pms
        current_kappaYV_pm = set_kappaYV_pms(indexK);
        indexCurrent = find( (percentages_of_buffered_b1_membrane==percentage_of_buffered_b1_membrane)...
                            &(velocities_per_hour_of_combination==current_velocity)...
                            &(kappaYV_pms==current_kappaYV_pm));
        x = kappaYV_pms(indexCurrent);
        y = cycling_rates(indexCurrent);
        z = start_total_kks(indexCurrent);% + k_vv_productions(indexCurrentVelocity); %
        length_current_values = length(indexCurrent);
        for indexCurrent = 1:length_current_values
            x_line = [x(indexCurrent) x(indexCurrent)];
            y_line = [y(indexCurrent) y(indexCurrent)];
            z_line = [0 z(indexCurrent)];
            plot3(x_line,y_line,z_line,'b','Color',kappaYV_colors(indexK,:));
            hold on;
        end
        %plot3(x,y,z,'.','Color',kappaYV_colors(indexV,:));
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title('Kinesin receptor','FontSize',title_fontSize);
        xlabel({'tethering at GC';'[/molecule]'},'FontSize',axis_label_fontSize);
        ylabel({'Cycling rate';'[\mum{^2}/min]'},'FontSize',axis_label_fontSize);
        zlabel({'Initial kinesin R';'[molecules]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end


    %v-SNARE U
    max_x = max(kappaYV_pms);
    max_y = max(cycling_rates);
    max_z = 20000;%max(start_total_uus) * 1.1;

    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);
    percentage_of_buffered_b1_membrane = percentage_of_buffered_b1_membrane_for_figure;

    for indexK = 1:length_set_kappaYV_pms
        current_kappaYV_pm = set_kappaYV_pms(indexK);
        indexCurrent = find( (percentages_of_buffered_b1_membrane==percentage_of_buffered_b1_membrane)...
                            &(velocities_per_hour_of_combination==current_velocity)...
                            &(kappaYV_pms==current_kappaYV_pm));
        x = kappaYV_pms(indexCurrent);
        y = cycling_rates(indexCurrent);
        z = start_total_uus(indexCurrent);% + k_vv_productions(indexCurrentVelocity); %
        length_current_values = length(indexCurrent);
        for indexCurrent = 1:length_current_values
            x_line = [x(indexCurrent) x(indexCurrent)];
            y_line = [y(indexCurrent) y(indexCurrent)];
            z_line = [0 z(indexCurrent)];
            plot3(x_line,y_line,z_line,'b','Color',kappaYV_colors(indexK,:));
            hold on;
        end
        %plot3(x,y,z,'.','Color',kappaYV_colors(indexV,:));
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title('v-SNARE U','FontSize',title_fontSize);
        xlabel({'tethering at GC';'[/molecule]'},'FontSize',axis_label_fontSize);
        ylabel({'Cycling rate';'[\mum{^2}/min]'},'FontSize',axis_label_fontSize);
        zlabel({'Initial v-SNARE U';'[molecules]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end

    %dynein receptor
    max_x = max(kappaYV_pms);
    max_y = max(cycling_rates);
    max_z = 1000;%max(start_total_dds) * 1.1;

    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);
    percentage_of_buffered_b1_membrane = percentage_of_buffered_b1_membrane_for_figure;

    for indexK = 1:length_set_kappaYV_pms
        current_kappaYV_pm = set_kappaYV_pms(indexK);
        indexCurrent = find( (percentages_of_buffered_b1_membrane==percentage_of_buffered_b1_membrane)...
                            &(velocities_per_hour_of_combination==current_velocity)...
                            &(kappaYV_pms==current_kappaYV_pm));
        x = kappaYV_pms(indexCurrent);
        y = cycling_rates(indexCurrent);
        z = start_total_dds(indexCurrent);% + k_vv_productions(indexCurrentVelocity); %
        length_current_values = length(indexCurrent);
        for indexCurrent = 1:length_current_values
            x_line = [x(indexCurrent) x(indexCurrent)];
            y_line = [y(indexCurrent) y(indexCurrent)];
            z_line = [0 z(indexCurrent)];
            plot3(x_line,y_line,z_line,'b','Color',kappaYV_colors(indexK,:));
            hold on;
        end
        %plot3(x,y,z,'.','Color',kappaYV_colors(indexV,:));
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title('Dynein receptor','FontSize',title_fontSize);
        xlabel({'tethering at GC';'[/molecule]'},'FontSize',axis_label_fontSize);
        ylabel({'Cycling rate';'[\mum{^2}/min]'},'FontSize',axis_label_fontSize);
        zlabel({'Initial dynein R';'[molecules]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end

    %v-SNARE V + v-SNARE U
    max_x = max(kappaYV_pms);
    max_y = max(cycling_rates);
    max_z = 40000;%max(start_total_uus) * 1.1;

    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);
    percentage_of_buffered_b1_membrane = percentage_of_buffered_b1_membrane_for_figure;

    for indexK = 1:length_set_kappaYV_pms
        current_kappaYV_pm = set_kappaYV_pms(indexK);
        indexCurrent = find( (percentages_of_buffered_b1_membrane==percentage_of_buffered_b1_membrane)...
                            &(velocities_per_hour_of_combination==current_velocity)...
                            &(kappaYV_pms==current_kappaYV_pm));
        x = kappaYV_pms(indexCurrent);
        y = cycling_rates(indexCurrent);
        z = start_total_vvs(indexCurrent) + start_total_uus(indexCurrent);% + k_vv_productions(indexCurrentVelocity); %
        %plot3(x,y,z,'.','Color',kappaYV_colors(indexV,:));
        length_current_values = length(indexCurrent);
        for indexCurrent = 1:length_current_values
            x_line = [x(indexCurrent) x(indexCurrent)];
            y_line = [y(indexCurrent) y(indexCurrent)];
            z_line = [0 z(indexCurrent)];
            plot3(x_line,y_line,z_line,'b','Color',kappaYV_colors(indexK,:));
            hold on;
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title('v-SNAREs V + U','FontSize',title_fontSize);
        xlabel({'tethering at GC';'[/molecule]'},'FontSize',axis_label_fontSize);
        ylabel({'Cycling rate';'[\mum{^2}/min]'},'FontSize',axis_label_fontSize);
        zlabel({'Initial v-SNARE U';'[molecules]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end

    %kinesin + dynein receptor
    max_x = max(kappaYV_pms);
    max_y = max(cycling_rates);
    max_z = 1500;%max(start_total_dds) * 1.1;

    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);
    percentage_of_buffered_b1_membrane = percentage_of_buffered_b1_membrane_for_figure;

    for indexK = 1:length_set_kappaYV_pms
        current_kappaYV_pm = set_kappaYV_pms(indexK);
        indexCurrent = find( (percentages_of_buffered_b1_membrane==percentage_of_buffered_b1_membrane)...
                            &(velocities_per_hour_of_combination==current_velocity)...
                            &(kappaYV_pms==current_kappaYV_pm));
        x = kappaYV_pms(indexCurrent);
        y = cycling_rates(indexCurrent);
        z = start_total_kks(indexCurrent) + start_total_dds(indexCurrent);% + k_vv_productions(indexCurrentVelocity); %
        %plot3(x,y,z,'.','Color',kappaYV_colors(indexV,:));
        length_current_values = length(indexCurrent);
        for indexCurrent = 1:length_current_values
            x_line = [x(indexCurrent) x(indexCurrent)];
            y_line = [y(indexCurrent) y(indexCurrent)];
            z_line = [0 z(indexCurrent)];
            plot3(x_line,y_line,z_line,'b','Color',kappaYV_colors(indexK,:));
            hold on;
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title('Dynein + kinesin receptor','FontSize',title_fontSize);
        xlabel({'tethering at GC';'[/molecule]'},'FontSize',axis_label_fontSize);
        ylabel({'Cycling rate';'[\mum{^2}/min]'},'FontSize',axis_label_fontSize);
        zlabel({'Initial Receptors';'[molecules]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end

    figure_label = strcat('3Dplot_start_molecules_velocity_',num2str(current_velocity),'.png');
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 3.3*figureColumns 2*figureRows])
    print(figure_label,'-dpng','-r600');

    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%% Plot production rates
    figure;
    plotIndex_of_subfigure = 0;
    figureColumns = 2;
    figureRows = 2;
    title_fontSize = 10;
    axis_label_fontSize = 8;
    cycling_rate_for_figure = 1;

    %%% Plot vv production rates
    max_x = max(kappaYV_pms);
    max_y = max(percentages_of_buffered_b1_membrane);
    max_z = max(k_vv_productions) * 1.1;

    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);

    for indexK = 1:length_set_kappaYV_pms
        current_kappaYV_pm = set_kappaYV_pms(indexK);
        indexCurrent = find( (cycling_rates==cycling_rate_for_figure)...
                            &(velocities_per_hour_of_combination==current_velocity)...
                            &(kappaYV_pms==current_kappaYV_pm));
        x = kappaYV_pms(indexCurrent);
        y = percentages_of_buffered_b1_membrane(indexCurrent);
        z = k_vv_productions(indexCurrent); %
        %plot3(x,y,z,'.','Color',kappaYV_colors(indexV,:));
        length_current_values = length(indexCurrent);
        for indexCurrent = 1:length_current_values
            x_line = [x(indexCurrent) x(indexCurrent)];
            y_line = [y(indexCurrent) y(indexCurrent)];
            z_line = [0 z(indexCurrent)];
            plot3(x_line,y_line,z_line,'b','Color',kappaYV_colors(indexK,:));
            hold on;
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title('v-SNARE V production rate','FontSize',title_fontSize);
        xlabel({'tethering at GC';'[/molecule]'},'FontSize',axis_label_fontSize);
        ylabel({'Percentage of';'buffered membrane in MTC'},'FontSize',axis_label_fontSize);
        zlabel({'production rate';'[molecules/min]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end

    %%% Plot uu production rates
    max_x = max(kappaYV_pms);
    max_y = max(percentages_of_buffered_b1_membrane);
    max_z = max(k_uu_productions) * 1.1;

    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);

    for indexK = 1:length_set_kappaYV_pms
        current_kappaYV_pm = set_kappaYV_pms(indexK);
        indexCurrent = find( (cycling_rates==cycling_rate_for_figure)...
                            &(velocities_per_hour_of_combination==current_velocity)...
                            &(kappaYV_pms==current_kappaYV_pm));
        x = kappaYV_pms(indexCurrent);
        y = percentages_of_buffered_b1_membrane(indexCurrent);
        z = k_uu_productions(indexCurrent); %
        %plot3(x,y,z,'.','Color',kappaYV_colors(indexV,:));
        length_current_values = length(indexCurrent);
        for indexCurrent = 1:length_current_values
            x_line = [x(indexCurrent) x(indexCurrent)];
            y_line = [y(indexCurrent) y(indexCurrent)];
            z_line = [0 z(indexCurrent)];
            plot3(x_line,y_line,z_line,'b','Color',kappaYV_colors(indexK,:));
            hold on;
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title('v-SNARE U production rate','FontSize',title_fontSize);
        xlabel({'tethering at GC';'[/molecule]'},'FontSize',axis_label_fontSize);
        ylabel({'Percentage of';'buffered membrane in MTC'},'FontSize',axis_label_fontSize);
        zlabel({'production rate';'[molecules/min]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end

    %%% Plot kk production rates
    max_x = max(kappaYV_pms);
    max_y = max(percentages_of_buffered_b1_membrane);
    max_z = max(k_kk_productions) * 1.1;

    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);

    for indexK = 1:length_set_kappaYV_pms
        current_kappaYV_pm = set_kappaYV_pms(indexK);
        indexCurrent = find( (cycling_rates==cycling_rate_for_figure)...
                            &(velocities_per_hour_of_combination==current_velocity)...
                            &(kappaYV_pms==current_kappaYV_pm));
        x = kappaYV_pms(indexCurrent);
        y = percentages_of_buffered_b1_membrane(indexCurrent);
        z = k_kk_productions(indexCurrent); %
        %plot3(x,y,z,'.','Color',kappaYV_colors(indexV,:));
        length_current_values = length(indexCurrent);
        for indexCurrent = 1:length_current_values
            x_line = [x(indexCurrent) x(indexCurrent)];
            y_line = [y(indexCurrent) y(indexCurrent)];
            z_line = [0 z(indexCurrent)];
            plot3(x_line,y_line,z_line,'b','Color',kappaYV_colors(indexK,:));
            hold on;
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title('Kinesin receptor production rate','FontSize',title_fontSize);
        xlabel({'tethering at GC';'[/molecule]'},'FontSize',axis_label_fontSize);
        ylabel({'Percentage of';'buffered membrane in MTC'},'FontSize',axis_label_fontSize);
        zlabel({'production rate';'[molecules/min]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end


    %%% Plot dd production rates
    max_x = max(kappaYV_pms);
    max_y = max(percentages_of_buffered_b1_membrane);
    max_z = max(k_dd_productions) * 1.1;

    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);

    for indexK = 1:length_set_kappaYV_pms
        current_kappaYV_pm = set_kappaYV_pms(indexK);
        indexCurrent = find( (cycling_rates==cycling_rate_for_figure)...
                            &(velocities_per_hour_of_combination==current_velocity)...
                            &(kappaYV_pms==current_kappaYV_pm));
        x = kappaYV_pms(indexCurrent);
        y = percentages_of_buffered_b1_membrane(indexCurrent);
        z = k_dd_productions(indexCurrent); %
        %plot3(x,y,z,'.','Color',kappaYV_colors(indexV,:));
        length_current_values = length(indexCurrent);
        for indexCurrent = 1:length_current_values
            x_line = [x(indexCurrent) x(indexCurrent)];
            y_line = [y(indexCurrent) y(indexCurrent)];
            z_line = [0 z(indexCurrent)];
            plot3(x_line,y_line,z_line,'b','Color',kappaYV_colors(indexK,:));
            hold on;
        end
        ylim([0 max_y]);
        xlim([0 max_x]);
        zlim([0 max_z]);
        title('Dynein receptor production rate','FontSize',title_fontSize);
        xlabel({'tethering at GC';'[/molecule]'},'FontSize',axis_label_fontSize);
        ylabel({'Percentage of';'buffered membrane in MTC'},'FontSize',axis_label_fontSize);
        zlabel({'production rate';'[molecules/min]'},'FontSize',axis_label_fontSize);

        grid on;
        hold on;

    end


    figure_label = strcat('3Dplot_production_rates_velocity_',num2str(current_velocity),'.png');
    set(gcf,'PaperUnits','inches','PaperPosition',[0 0 3.3*figureColumns 2*figureRows])
    print(figure_label,'-dpng','-r600');
end

