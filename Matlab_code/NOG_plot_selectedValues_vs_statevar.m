
figure;
figureColumns = 10;%plots_per_row; %set NOG_statevar_set
figureRows = 5;
title_font_size = 10;


plotIndex_of_subfigure = 0;
LineWidth = 2;
color_consider = 'r';
color_not_consider = [0.2 0.4 0.2];

%Plot subfigure 1
radius_neurite = parameters(index_radius_neurite);
s3 = statevar_timelines(:,indexS_s3);
plasma_membrane_neurite_length = s3 / (2 * pi * radius_neurite);
plasma_membrane_neurite_length_start = plasma_membrane_neurite_length(tstart_index);
plasma_membrane_neurite_length_end = plasma_membrane_neurite_length(end);
growth_velocity_per_min = (plasma_membrane_neurite_length_end-plasma_membrane_neurite_length_start) / reference_time_period;
growth_velocity_per_h = growth_velocity_per_min * 60;
area_velocity_per_h = (s3(end) - s3(tstart_index)) / (reference_time_period);

plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
subplot(figureRows,figureColumns,plotIndex_of_subfigure);
plot(t(1:tstart_index),plasma_membrane_neurite_length(1:tstart_index),'b','LineWidth',LineWidth);
hold on;
plot(t(tstart_index:end),plasma_membrane_neurite_length(tstart_index:end),'r','LineWidth',LineWidth);
title({'s3 length ',[num2str(growth_velocity_per_h),' um/h vs ',num2str(anticipated_velocity*60),' um/h vs '],[num2str(area_velocity_per_h),' um2/min']},'FontSize',title_font_size);

for indexEPD = 1:expPreDataStatevar_length
    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    if expPreDataStatevar_consider(indexEPD)
       color = color_consider;
    else
       color = color_not_consider;
    end

    subplot(figureRows,figureColumns,plotIndex_of_subfigure);
    yy = plot(t,expPreDataStatevar_preValue(:,indexEPD),'b','LineWidth',LineWidth);
    hold on;
    mean = expPreDataStatevar_means(indexEPD);
    sd = expPreDataStatevar_sds(indexEPD);
    plot([t(1) t(end)], mean,'-.','Color',color,'LineWidth',LineWidth);
    plot([t(1) t(end)], [mean-sd mean-sd],'-.','Color',color,'LineWidth',LineWidth);
    plot([t(1) t(end)], [mean+sd mean+sd],'-.','Color',color,'LineWidth',LineWidth);
    min_y = min([mean-sd expPreDataStatevar_preValue(end,indexEPD)])-0.3*sd;
    max_y = max([mean+sd expPreDataStatevar_preValue(end,indexEPD)])+0.3*sd;
    ylim([min_y max_y]);
    title(strrep(expPreDataStatevar_names{indexEPD},'_',' '));
end

output_t = Output_time;

for indexEPD = 1:expPreDataFluxes_length
    plotIndex_of_subfigure = plotIndex_of_subfigure + 1;
    if expPreDataFluxes_consider(indexEPD)
       color = color_consider;
    else
       color = color_not_consider;
    end

    subplot(figureRows,figureColumns,plotIndex_of_subfigure);
    plot(output_t,expPreDataFluxes_preValue(:,indexEPD),'b','LineWidth',LineWidth);
    hold on;
    mean = expPreDataFluxes_means(indexEPD);
    sd = expPreDataFluxes_sds(indexEPD);
    plot([output_t(1) output_t(end)], mean,'-.','Color',color);
    plot([output_t(1) output_t(end)], [mean-sd mean-sd],'-.','Color',color,'LineWidth',LineWidth);
    plot([output_t(1) output_t(end)], [mean+sd mean+sd],'-.','Color',color,'LineWidth',LineWidth);
    min_y = min([mean-sd expPreDataFluxes_preValue(end,indexEPD)])-0.3*sd;
    max_y = max([mean+sd expPreDataFluxes_preValue(end,indexEPD)])+0.3*sd;
    ylim([min_y max_y]);
    title(strrep(expPreDataFluxes_names{indexEPD},'_',' '));
end




