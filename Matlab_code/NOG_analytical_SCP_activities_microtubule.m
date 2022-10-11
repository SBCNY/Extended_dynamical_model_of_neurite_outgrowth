clc;
clear;
close all;

%Set fixed rates
NOG_analytical_predefine_conditions;

%Set general values
anticipated_velocities_per_hour = [5 20];%[0 2.5 5 7.5 10 12.5 15 17.5 20];

anticipated_effective_tubulins = 8:0.001:10;

anticipated_effective_dynMTs_lengths = [5 10 15 20];

%Set lengths
length_anticipated_velocities = length(anticipated_velocities_per_hour);
length_anticipated_effective_tubulins = length(anticipated_effective_tubulins);
length_anticipated_effective_dynMTs_lengths = length(anticipated_effective_dynMTs_lengths);

%Set general figure options
title_fontSize = 10;
axis_label_fontSize = 7;
axis_tick_fontSize = 6;

%Initiate arrays for storage of results
max_combinations = 200000;
velocities_per_hour_of_combination = repmat(-1,max_combinations,1);
effective_tubulins = repmat(-1,max_combinations,1);
nucleation_rates = repmat(-1,max_combinations,1);
stabilization_rates = repmat(-1,max_combinations,1);
effective_dynMTs_lengths = repmat(-1,max_combinations,1);

indexCombination = 0;

for indexV = 1:length_anticipated_velocities
    velocity_per_hour = anticipated_velocities_per_hour(indexV);
    accepted_combination = true;
    for indexET = 1:length_anticipated_effective_tubulins
        effective_tubulin = anticipated_effective_tubulins(indexET);
            
        for indexDT = 1:length_anticipated_effective_dynMTs_lengths
            effective_dynMTs_length = anticipated_effective_dynMTs_lengths(indexDT);
            dynMTs = effective_dynMTs_length * MTs_per_crosssection;
        
            MT_growth_velocity = velocity_per_hour / 60;
            scale = scale_initial_a * exp(scale_exp_a*effective_tubulin) + scale_initial_b * exp(scale_exp_b*effective_tubulin);
            shape = shape_m * effective_tubulin + shape_b;
            average_dynMT_length = scale * shape;
            length_increase_of_stable_MTs = MT_growth_velocity * MTs_per_crosssection;
            degradation_rate = dynMT_degradation_multiplier_a * effective_tubulin^dynMT_degradation_exp_b;
            stabilization_rate = length_increase_of_stable_MTs / average_dynMT_length;
            nucleation_rate = (stabilization_rate + degradation_rate) / dynMTs;

            if (  (degradation_rate>0)...
                &&(stabilization_rate>0)...
                &&(nucleation_rate>0))

                indexCombination = indexCombination + 1;
                velocities_per_hour_of_combination(indexCombination) = velocity_per_hour;
                effective_tubulins(indexCombination) = effective_tubulin;
                nucleation_rates(indexCombination) = nucleation_rate;
                stabilization_rates(indexCombination) = stabilization_rate;
                effective_dynMTs_lengths(indexCombination) = effective_dynMTs_length;
            end
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;
plotIndex_of_subfigure = 0;
figureColumns = length_anticipated_velocities;
figureRows = 1;

effective_tubulin_colors = zeros(length_anticipated_effective_tubulins,3);
for indexColor = 1:length_anticipated_effective_tubulins
     red = ((indexColor-1) * (255/length_anticipated_effective_tubulins))/255;
     green = ((indexColor-1) * 90/length_anticipated_effective_tubulins)/255;
     blue = (255 - (indexColor-1) * 255/length_anticipated_effective_tubulins)/255;
     effective_tubulin_colors(indexColor,:) = [red green blue];
end

effective_colors = zeros(length_anticipated_effective_dynMTs_lengths,3);
for indexColor = 1:length_anticipated_effective_dynMTs_lengths
     red = ((indexColor-1) * (255/length_anticipated_effective_dynMTs_lengths))/255;
     green = ((indexColor-1) * 90/length_anticipated_effective_dynMTs_lengths)/255;
     blue = (255 - (indexColor-1) * 255/length_anticipated_effective_dynMTs_lengths)/255;
     effective_colors(indexColor,:) = [red green blue];
end

for indexV = 1:length_anticipated_velocities
    current_velocity = anticipated_velocities_per_hour(indexV);
    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);
    
    for indexD = 1:length_anticipated_effective_dynMTs_lengths
        current_effective_dynMTs_length = anticipated_effective_dynMTs_lengths(indexD);
        indexCurrent = find( (velocities_per_hour_of_combination==current_velocity)...
                            &(effective_dynMTs_lengths==current_effective_dynMTs_length));
        length_current_values = length(indexCurrent);
        if (length_current_values>0)
            z = stabilization_rates(indexCurrent);
            y = nucleation_rates(indexCurrent);
            x = effective_tubulins(indexCurrent);
            for indexCurrent = 1:length_current_values
                x_line = [x(indexCurrent) x(indexCurrent)];
                y_line = [y(indexCurrent) y(indexCurrent)];
                z_line = [0 z(indexCurrent)];
                plot3(x_line,y_line,z_line,'Color',effective_colors(indexD,:));
                hold on;
            end
        end
    end
    
    xlim([min(anticipated_effective_tubulins) max(effective_tubulins)]);
    ylim([0 max(nucleation_rates)]);
    zlim([0 max(stabilization_rates)]);
    set(gca,'FontSize',axis_tick_fontSize);
    title({'MT growth';char(strcat('at',{' '},num2str(current_velocity),'\mum/h NOG'))},'FontSize',title_fontSize);
    xlabel({'effective tubulin';'[\muM]'},'FontSize',axis_label_fontSize);
    ylabel({'nucleation rate';'[molecules]'},'FontSize',axis_label_fontSize);
    zlabel({'stabilization rate';'[molecules]'},'FontSize',axis_label_fontSize);

    grid on;
    hold on;
    
end

figure_label = 'Microtubules';
set(gcf,'PaperUnits','inches','PaperPosition',[0 0 3.3*figureColumns 2*figureRows])
print(figure_label,'-dpng','-r600');

