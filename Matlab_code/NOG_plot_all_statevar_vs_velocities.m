close all;

  statevar_names = { 
'ng','nb1 cg','nb1 mtc','nb1 cpm','npm',...
'NO','na1 cg','na1 mtc','na1 cpm','NO',...
'NO','nb2 cg','nb2 mtc','nb2 cpm','NO' ...    
'NO','na2 cg','na2 mtc','na2 cpm','s3',...
'yy g','yy b1 cg','yy b1 mtc','yy b1 cpm','yy pm',...
'NO','yy a1 cg','yy a1 mtc','yy a1 cpm','NO',...
'NO','yy b2 cg','yy b2 mtc','yy b2 cpm','NO',...
'NO','yy a2 cg','yy a2 mtc','yy a2 cpm','NO',...
'vv g','vv b1 cg','vv b1 mtc','vv b1 cpm','vv pm',...
'NO','vv a1 cg','vv a1 mtc','vv a1 cpm','NO',...
'NO','vv b2 cg','vv b2 mtc','vv b2 cpm','NO',...
'NO','vv a2 cg','vv a2 mtc','vv a2 cpm','NO',...
'xx g','xx b1 cg','xx b1 mtc','xx b1 cpm','xx pm',...
'NO','xx a1 cg','xx a1 mtc','xx a1 cpm','NO',...
'NO','xx b2 cg','xx b2 mtc','xx b2 cpm','NO',...
'NO','xx a2 cg','xx a2 mtc','xx a2 cpm','NO',...
'uu g','uu b1 cg','uu b1 mtc','uu b1 cpm','uu pm',...
'NO','uu a1 cg','uu a1 mtc','uu a1 cpm','NO',...
'NO','uu b2 cg','uu b2 mtc','uu b2 cpm','NO',...
'NO','uu a2 cg','uu a2 mtc','uu a2 cpm','NO',...
'kk g','kk b1 cg','kk b1 mtc','kk b1 cpm','kk pm',...
'NO','kk a1 cg','kk a1 mtc','kk a1 cpm','NO',...
'NO','kk b2 cg','kk b2 mtc','kk b2 cpm','NO',...
'NO','kk a2 cg','kk a2 mtc','kk a2 cpm','NO',...
'dd g','dd b1 cg','dd b1 mtc','dd b1 cpm','dd pm',...
'NO','dd a1 cg','dd a1 mtc','dd a1 cpm','NO',...
'NO','dd b2 cg','dd b2 mtc','dd b2 cpm','NO',...
'NO','dd a2 cg','dd a2 mtc','dd a2 cpm','NO',...
'cc1 g','cc1 b1 cg','cc1 b1 mtc','cc1 b1 cpm','cc1 pm',...
'NO','cc1 a1 cg','cc1 a1 mtc','cc1 a1 cpm','NO',...
'NO','cc1 b2 cg','cc1 b2 mtc','cc1 b2 cpm','NO',...
'NO','cc1 a2 cg','cc1 a2 mtc','cc1 a2 cpm','NO',...
'cc2 g','cc2 b1 cg','cc2 b1 mtc','cc2 b1 cpm','cc2 pm',...
'NO','cc2 a1 cg','cc2 a1 mtc','cc2 a1 cpm','NO',...
'NO','cc2 b2 cg','cc2 b2 mtc','cc2 b2 cpm','NO',...
'NO','cc2 a2 cg','cc2 a2 mtc','cc2 a2 cpm','NO',...
'dyn MTs','stbl MTs length'};

 length_statevar_names = length(statevar_names);       
  
 %Calculate molecule concentrations per membrane area - Adopt indexes, if
 %statevar changes !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 indexStatevar = 0;
 indexInnerStatevar = 0;
 
 statevar_last_timepoints_velocity_normalized = statevar_last_timepoints_velocity;
 statevar_names_normalized = statevar_names;
 
 for indexStatevarNames = 1:length_statevar_names
    statevar_name = char(statevar_names(indexStatevarNames));
    if (strcmp(statevar_name,'NO') == 0)
        indexStatevar = indexStatevar + 1;
        if (strfind(statevar_name,'n')==1)
            membrane_label = [' ' statevar_name(2:length(statevar_name))];
            indexInnerStatevar = 15;
            for indexInnerStatevarNames = 21:length_statevar_names
               inner_statevar_name = char(statevar_names(indexInnerStatevarNames));
               if (strcmp(inner_statevar_name,'NO') == 0)
                   indexInnerStatevar = indexInnerStatevar + 1;
                   if (isempty(strfind(inner_statevar_name,membrane_label))==0)
                      statevar_last_timepoints_velocity_normalized(indexInnerStatevar,:) =  statevar_last_timepoints_velocity(indexInnerStatevar,:) ./ statevar_last_timepoints_velocity(indexStatevar,:);
                      statevar_names_normalized(indexInnerStatevarNames) = {inner_statevar_name(2:length(inner_statevar_name))};
                   end
               end
            end
        end
    end
 end
 
 
 length_velocities = length(velocities);
 fontSize = 6;
 LineWidth = 2;
 
 multiplot.Max_rows = 5;
 multiplot.Max_cols = 5;
 multiplot.Max_subplots = multiplot.Max_rows * multiplot.Max_cols;
 multiplot.Index = multiplot.Max_subplots;
 max_xlimit = max(velocities);
 pdf_name = 'C:\\Users\Arjun\Desktop\Experimental_jens\statevar.ps';
 figures_count = 0;
 
 indexStatevarRow = 0;
 
 for indexStatevarNames=1:length_statevar_names
     multiplot.Index = multiplot.Index + 1;
     if (multiplot.Index > multiplot.Max_subplots)
        multiplot.Index = 1; 
        figure;
     end

     statevar_name = char(statevar_names_normalized(indexStatevarNames));
     if (strcmp(statevar_name,'NO') == 0) 
         indexStatevarRow = indexStatevarRow + 1;
         subplot(multiplot.Max_rows, multiplot.Max_cols, multiplot.Index)
         plot(velocities,statevar_last_timepoints_velocity_normalized(indexStatevarRow,:) ,'*-','Color',[153/255 0 0.3],'LineWidth',LineWidth);
         xlim([0 max_xlimit]);
         ylim([0 max(statevar_last_timepoints_velocity_normalized(indexStatevarRow,:)*1.1)]);
         title(statevar_name, 'FontSize', 6);
     end
    
     if ((multiplot.Index == multiplot.Max_subplots)||(indexStatevarNames==length_statevar_names))
%          set(gcf,'paperunits','centimeters')
%          set(gcf,'papertype','a4')
%          set(gcf, 'PaperPosition', [-11.73 2.51 34.45 14.69]);
%          set(gcf,'PaperOrientation','landscape');
         print(gcf, '-dpsc', pdf_name,'-append','-fillpage');  
         figures_count = figures_count + 1;
     end
end
if (indexStatevarRow ~= length(statevar_last_timepoints_velocity(:,1)))
  throw(exception) 
end
 figures_count= 8;
 for i =1:figures_count 
  print(figure(i),['statevar' num2str(i)],'-dpdf');
 end