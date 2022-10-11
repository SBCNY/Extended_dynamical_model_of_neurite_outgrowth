 colCount_statevar = length(statevar_last_timepoints(1,:));

length_runs = length(run_fraction_bound_nb1_mtc);

length_statevar = length(statevar_timelines(1,:)); 
statevar_timelines_normalized = statevar_timelines;
statevar_names_normalized = statevar_names;
 
first_index_current_figure = 1;

for indexStatevar = 1:length_statevar
    current_timeline = run_statevar_last_timepoints(:,indexStatevar);
    if (statevar_plotIndexes(indexStatevar) - first_index_current_figure + 1 > figureColumns * figureRows)
       first_index_current_figure = first_index_current_figure + figureColumns * figureRows;
       figure;
    end
    
    plotIndex_of_subfigure = statevar_plotIndexes(indexStatevar) - first_index_current_figure + 1;
    subplot(figureRows,figureColumns,plotIndex_of_subfigure);
    plot3(run_fraction_bound_nb1_mtc,run_backwardFlux_a2_mtc_into_cg,current_timeline,'.');
    hold on;
    for indexRun = 1:length_runs
        x = [run_fraction_bound_nb1_mtc(indexRun) run_fraction_bound_nb1_mtc(indexRun)];
        y = [run_backwardFlux_a2_mtc_into_cg(indexRun) run_backwardFlux_a2_mtc_into_cg(indexRun)];
        z = [0 current_timeline(indexRun)];
        plot3(x,y,z,'b');
    end
    title(strrep(statevar_names_normalized(indexStatevar),'_',' '),'FontSize',title_font_size);
end

