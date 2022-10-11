
length_runs = length(run_fraction_bound_nb1_mtc);
length_parameters = length(parameter_names); 
figureColumns = 5;
figureRows = 5;
first_index_current_figure = 1;

unique_fractions = unique(run_fraction_bound_nb1_mtc);
length_unique_fractions = length(unique_fractions);



for indexFraction = 1:length_unique_fractions
    current_fraction = unique_fractions(indexFraction);
    indexesCurrentFraction =  find(run_fraction_bound_nb1_mtc==current_fraction);
    run_statevar_last_timepoints_fraction = run_statevar_last_timepoints(indexesCurrentFraction,:);
    run_fraction_bound_nb1_mtc_fraction = run_fraction_bound_nb1_mtc(indexesCurrentFraction,:);
    run_velocities_fraction = run_velocities(indexesCurrentFraction);
    run_backwardFlux_a2_mtc_into_cg_fraction = run_backwardFlux_a2_mtc_into_cg(indexesCurrentFraction,:);
    length_currentFraction = length(indexesCurrentFraction);
    
    for indexParameter = 1:length_parameters
        current_parameter = run_statevar_last_timepoints_fraction(:,indexParameter);
        if (statevar_plotIndexes(indexStatevar) - first_index_current_figure + 1 > figureColumns * figureRows)
           first_index_current_figure = first_index_current_figure + figureColumns * figureRows;
           figure;
        end

        plotIndex_of_subfigure = parameter_plotIndexes(indexParameter) - first_index_current_figure + 1;
        subplot(figureRows,figureColumns,plotIndex_of_subfigure);
        plot3(run_velocities_fraction,run_backwardFlux_a2_mtc_into_cg_fraction,current_parameter,'.');
        hold on;
        for indexRun = 1:length_runs
            x = [run_velocities_fraction(indexRun) run_velocities_fraction(indexRun)];
            y = [run_backwardFlux_a2_mtc_into_cg_fraction(indexRun) run_backwardFlux_a2_mtc_into_cg_fraction(indexRun)];
            z = [0 current_parameter(indexRun)];
            plot3(x,y,z,'b');
            hold on;
        end
        title(strcat(strrep(parameter_names(indexStatevar),'_',' '),' ','(',num2str(current_fraction),')'),'FontSize',title_font_size);
    end
end

