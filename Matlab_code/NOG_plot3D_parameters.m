colCount_statevar = length(statevar_last_timepoints(1,:));

length_runs = length(run_fraction_bound_nb1_mtc);

length_parameters = length(run_parameters(1,:)); 
figureColumns = 5;
figureRows = 5;
first_index_current_figure = 1;

for indexPara = 1:length_parameters
    current_parameter = run_parameters(:,indexPara);
    if (parameters_plotIndexes(indexPara) - first_index_current_figure + 1 > figureColumns * figureRows)
       first_index_current_figure = first_index_current_figure + figureColumns * figureRows;
       figure;
    end
    
    plotIndex_of_subfigure = parameters_plotIndexes(indexPara) - first_index_current_figure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);
    plot3(run_fraction_bound_nb1_mtc,run_backwardFlux_a2_mtc_into_cg,current_parameter,'.');
    hold on;
    for indexRun = 1:length_runs
        x = [run_fraction_bound_nb1_mtc(indexRun) run_fraction_bound_nb1_mtc(indexRun)];
        y = [run_backwardFlux_a2_mtc_into_cg(indexRun) run_backwardFlux_a2_mtc_into_cg(indexRun)];
        z = [0 current_parameter(indexRun)];
        plot3(x,y,z,'b');
        hold on;
    end
    title(strrep(parameter_names(indexPara),'_',' '),'FontSize',title_font_size);
end

