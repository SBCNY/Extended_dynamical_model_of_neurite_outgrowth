figure;

 Output_names = ['xx_a1_g_into_cg','xx_a1_cg_into_g','xx_a1_cg_into_mtc','xx_a1_mtc_into_cpm','xx_a1_cpm_into_pm',...
           'xx_b1_g_into_cg,xx_b1_cg_into_g','xx_b1_cg_into_mtc','xx_b1_mtc_into_cpm','xx_b1_cpm_into_pm',...
           'xx_a2_pm_into_cpm','xx_a2_cpm_into_pm','xx_a2_cpm_into_mtc','xx_a2_mtc_into_cg','xx_a2_cg_into_g',...                          
           'xx_b2_pm_into_cpm','xx_b2_cpm_into_pm','xx_b2_cpm_into_mtc','xx_b2_mtc_into_cg','xx_b2_cg_into_g',... %%                     
           'uu_a1_g_into_cg','uu_a1_cg_into_g','uu_a1_cg_into_mtc','uu_a1_mtc_into_cpm','uu_a1_cpm_into_pm',...
           'uu_b1_g_into_cg','uu_b1_cg_into_g','uu_b1_cg_into_mtc','uu_b1_mtc_into_cpm','uu_b1_cpm_into_pm',...
           'uu_a2_pm_into_cpm','uu_a2_cpm_into_pm','uu_a2_cpm_into_mtc','uu_a2_mtc_into_cg','uu_a2_cg_into_g',...                          
           'uu_b2_pm_into_cpm','uu_b2_cpm_into_pm','uu_b2_cpm_into_mtc','uu_b2_mtc_into_cg','uu_b2_cg_into_g',...%%                      
           'yy_a1_g_into_cg','yy_a1_cg_into_g','yy_a1_cg_into_mtc','yy_a1_mtc_into_cpm','yy_a1_cpm_into_pm',...
           'yy_b1_g_into_cg','yy_b1_cg_into_g','yy_b1_cg_into_mtc','yy_b1_mtc_into_cpm','yy_b1_cpm_into_pm',...
           'yy_a2_pm_into_cpm','yy_a2_cpm_into_pm','yy_a2_cpm_into_mtc','yy_a2_mtc_into_cg','yy_a2_cg_into_g',...                          
           'yy_b2_pm_into_cpm','yy_b2_cpm_into_pm','yy_b2_cpm_into_mtc','yy_b2_mtc_into_cg','yy_b2_cg_into_g',...%%                     
           'vv_a1_g_into_cg','vv_a1_cg_into_g','vv_a1_cg_into_mtc','vv_a1_mtc_into_cpm',' vv_a1_cpm_into_pm',...
           'vv_b1_g_into_cg','vv_b1_cg_into_g','vv_b1_cg_into_mtc','vv_b1_mtc_into_cpm',' vv_b1_cpm_into_pm',...
           'vv_a2_pm_into_cpm','vv_a2_cpm_into_pm','vv_a2_cpm_into_mtc','vv_a2_mtc_into_cg','vv_a2_cg_into_g',...                          
           'vv_b2_pm_into_cpm','vv_b2_cpm_into_pm','vv_b2_cpm_into_mtc','vv_b2_mtc_into_cg','vv_b2_cg_into_g',...
           'cc1_a1_g_into_cg','cc1_a1_cg_into_g','cc1_a1_cg_into_mtc','cc1_a1_mtc_into_cpm','cc1_a1_cpm_into_pm',...
           'cc1_b1_g_into_cg','cc1_b1_cg_into_g','cc1_b1_cg_into_mtc','cc1_b1_mtc_into_cpm','cc1_b1_cpm_into_pm',...
           'cc1_a2_pm_into_cpm','cc1_a2_cpm_into_pm','cc1_a2_cpm_into_mtc','cc1_a2_mtc_into_cg','cc1_a2_cg_into_g',...                          
           'cc1_b2_pm_into_cpm','cc1_b2_cpm_into_pm','cc1_b2_cpm_into_mtc','cc1_b2_mtc_into_cg','cc1_b2_cg_into_g',...
           'cc2_a1_g_into_cg','cc2_a1_cg_into_g','cc2_a1_cg_into_mtc','cc2_a1_mtc_into_cpm','cc2_a1_cpm_into_pm',...
           'cc2_b1_g_into_cg','cc2_b1_cg_into_g','cc2_b1_cg_into_mtc','cc2_b1_mtc_into_cpm','cc2_b1_cpm_into_pm',...
           'cc2_a2_pm_into_cpm','cc2_a2_cpm_into_pm','cc2_a2_cpm_into_mtc','cc2_a2_mtc_into_cg','cc2_a2_cg_into_g',...                          
           'cc2_b2_pm_into_cpm','cc2_b2_cpm_into_pm','cc2_b2_cpm_into_mtc','cc2_b2_mtc_into_cg','cc2_b2_cg_into_g',...
           'kk_a1_g_into_cg','kk_a1_cg_into_g','kk_a1_cg_into_mtc','kk_a1_mtc_into_cpm','kk_a1_cpm_into_pm',...
           'kk_b1_g_into_cg','kk_b1_cg_into_g','kk_b1_cg_into_mtc','kk_b1_mtc_into_cpm','kk_b1_cpm_into_pm',...
           'kk_a2_pm_into_cpm','kk_a2_cpm_into_pm','kk_a2_cpm_into_mtc','kk_a2_mtc_into_cg','kk_a2_cg_into_g',...                          
           'kk_b2_pm_into_cpm','kk_b2_cpm_into_pm','kk_b2_cpm_into_mtc','kk_b2_mtc_into_cg','kk_b2_cg_into_g',...
           'dd_a1_g_into_cg','dd_a1_cg_into_g','dd_a1_cg_into_mtc','dd_a1_mtc_into_cpm','dd_a1_cpm_into_pm',...
           'dd_b1_g_into_cg','dd_b1_cg_into_g','dd_b1_cg_into_mtc','dd_b1_mtc_into_cpm','dd_b1_cpm_into_pm',...
           'dd_a2_pm_into_cpm','dd_a2_cpm_into_pm','dd_a2_cpm_into_mtc','dd_a2_mtc_into_cg','dd_a2_cg_into_g',...                          
           'dd_b2_pm_into_cpm','dd_b2_cpm_into_pm','dd_b2_cpm_into_mtc','dd_b2_mtc_into_cg','dd_b2_cg_into_g',...           
           'velocity_a1_mtc_to_cpm',' velocity_b1_mtc_to_cpm',' velocity_a2_mtc_to_cg',' velocity_b2_mtc_to_cg',...          
           'dyn_MTs_length','stbl_MTs_length',' MTU_length'];

       
       
       
        
 length_output = length(Output);
 fontSize = 20;
 LineWidth = 3;
 
 multiplot.Max_rows = 4;
 multiplot.Max_cols = 4;
 multiplot.Max_subplots = multiplot.Max_rows * multiplot.Max_cols;
 multiplot.Index = multiplot.Max_subplots;
 
 for indexOutput=1:length_output
     multiplot.Index = multiplot.Index + 1;
     if (multiplot.Index > multiplot.Max_subplots)
        multiplot.Index = 1; 
     end
     subplot(multiplot.Max_rows, multiplot.Max_cols, multiplot.Index)
     plot(Output(indexOutput),'.-','Color',[153/255 0 0.3],'LineWidth',LineWidth);
     title(Output_names(indexOutput));
 end
     
plot(Output(:,1),Output(:,7) ,'.-','Color',[153/255 0 0.3],'LineWidth',LineWidth);
 hold on;
 plot(Output(:,1),Output(:,8),'.-','Color',[0 0 0],'LineWidth',LineWidth);
 hold on;
 plot(Output(:,1),Output(:,9),'.-','Color',[1 0 0],'LineWidth',LineWidth);
%%xlabel('time (Sec)'); ylabel('flux ');
 title('Flux between G & CG ')
 legend(strcat('B1-G-into-CBC: ',num2str(b1_flux_G_to_CG)),strcat('B1-CBC-into-G: ',num2str(b1_flux_CG_to_G)),strcat('B1-CBC-into-MTU: ',num2str(b1_flux_CG_to_MTU)))
 %legend('Location','Northeast')
 set(gca,'FontSize',fontSize);
 xlabel('Time (Min)','FontSize',fontSize);
 ylabel('Flux (AU)','FontSize',fontSize);
 axis([0,max(Output(:,1)),0,ymax])
 
  subplot(2,2,2)
  plot(Output(:,1),Output(:,10),'.-','Color',[200/255 100/255 0/255],'LineWidth',LineWidth);
  hold on;
  plot(Output(:,1),Output(:,11),'.-','Color',[1 150/255 50/255],'LineWidth',LineWidth);
  %xlabel('time (Sec)'); ylabel('flux ');
  title('Flux between MTU & NTC')
  legend(strcat('B1-MTU-into-CPM: ',num2str(b1_flux_MTU_to_CPM)),strcat('B1-CPM-into-PM: ',num2str(b1_flux_CPM_to_PM)))
  legend('Location','Northeast')
  set(gca,'FontSize',fontSize);
   xlabel('Time (Min)','FontSize',fontSize);
  ylabel('Flux (AU)','FontSize',fontSize);
  axis([0,max(Output(:,1)),0,ymax])
 
 
 subplot(2,2,3)
             
 plot(Output(:,1),Output(:,12),'.-','Color',[0 0 200/255],'LineWidth',LineWidth);
 hold on;
 plot(Output(:,1),Output(:,13),'.-','Color',[0 0 0],'LineWidth',LineWidth);
 hold on;
 plot(Output(:,1),Output(:,14),'.-','Color',[100/255 50/255 200/255],'LineWidth',LineWidth);
 %xlabel('time (Sec)'); ylabel('flux ');
 title('Flux between PM & NTC ')
legend(strcat('a2-PM-into-CPM: ',num2str(a2_flux_PM_to_CPM)),strcat('a2-CPM-into-PM: ',num2str(a2_flux_CPM_to_PM)),strcat('a2-CPM-into-MTU: ',num2str(a2_flux_CPM_to_MTU)))
 %legend('Location','Northeast')
 set(gca,'FontSize',fontSize);
  xlabel('Time (Min)','FontSize',fontSize);
 ylabel('Flux (AU)','FontSize',fontSize);
 axis([0,max(Output(:,1)),0,ymax])
     
     
     

  index = 0;   
  index = index + 1;
 
 G_into_CC = Output(:,index);
 b1_flux_G_to_CG = G_into_CC;

 index = index + 1;
 CG_into_G = Output(:,8);
 b1_flux_CG_to_G = CG_into_G;
 
     
 index = index + 1;
 CG_into_MTU = Output(:,index);
 b1_flux_CG_to_MTU = CG_into_MTU;
 
 index = index + 1;
 MTU_into_CPM = Output(:,index);
 b1_flux_MTU_to_CPM = MTU_into_CPM;
 
 index = index + 1;
 CPM_into_PM = Output(:,index);
 b1_flux_CPM_to_PM = CPM_into_PM;
 
 index = index + 1;
 PM_into_CPM = Output(:,index);
 a2_flux_PM_to_CPM = PM_into_CPM;
 
 index = index + 1;
 CPM_into_PM = Output(:,index);
 a2_flux_CPM_to_PM = CPM_into_PM;
 
 index = index + 1;
 CPM_into_MTU = Output(:,index);
 a2_flux_CPM_to_MTU = CPM_into_MTU;
 
 index = index + 1;
 MTU_into_CG = Output(:,index);
 a2_flux_MTU_to_CG = MTU_into_CG;
 
 index = index + 1;
 CG_into_G = Output(:,index);
 a2_flux_CG_to_G = CG_into_G;

 
 index = index + 1;
 xx_a1_g_into_cg = Output(:,index);
 index = index +1;
 xx_a1_cg_into_g = Output(:,index);
 index = index +1;
 xx_a1_cg_into_mtc = Output(:,index);
 index = index +1;
 xx_a1_mtc_into_cpm = Output(:,index);
 index = index +1;
 xx_a1_cpm_into_pm = Output(:,index);
 index = index +1;
 xx_b1_g_into_cg = Output(:,index);
 index = index +1;
 xx_b1_cg_into_g = Output(:,index);
 index = index +1;
 xx_b1_cg_into_mtc = Output(:,index);
 index = index +1;
 xx_b1_mtc_into_cpm = Output(:,index);
 index = index +1;
 xx_b1_cpm_into_pm = Output(:,index);
 index = index +1;
 xx_a2_pm_into_cpm = Output(:,index);
 index = index +1;
 xx_a2_cpm_into_pm = Output(:,index);
 index = index +1;
 xx_a2_cpm_into_mtc = Output(:,index);
 index = index +1;
 xx_a2_mtc_into_cg = Output(:,index);
 index = index +1;
 xx_a2_cg_into_g = Output(:,index);
 index = index +1;                          
 xx_b2_pm_into_cpm = Output(:,index);
 index = index +1;
 xx_b2_cpm_into_pm = Output(:,index);
 index = index +1;
 xx_b2_cpm_into_mtc = Output(:,index);
 index = index +1;
 xx_b2_mtc_into_cg = Output(:,index);
 index = index +1;
 xx_b2_cg_into_g = Output(:,index);
 index = index +1;                     
 uu_a1_g_into_cg = Output(:,index);
 index = index +1;
 uu_a1_cg_into_g = Output(:,index);index = index +1;
 uu_a1_cg_into_mtc = Output(:,index);index = index +1;
 uu_a1_mtc_into_cpm = Output(:,index);index = index +1;
 uu_a1_cpm_into_pm = Output(:,index);index = index +1;
 uu_b1_g_into_cg = Output(:,index);index = index +1;
 uu_b1_cg_into_g = Output(:,index);index = index +1;
 uu_b1_cg_into_mtc = Output(:,index);index = index +1;
 uu_b1_mtc_into_cpm = Output(:,index);index = index +1;
 uu_b1_cpm_into_pm = Output(:,index);index = index +1;
 uu_a2_pm_into_cpm = Output(:,index);index = index +1;
 uu_a2_cpm_into_pm = Output(:,index);index = index +1;
 uu_a2_cpm_into_mtc = Output(:,index);index = index +1;
 uu_a2_mtc_into_cg = Output(:,index);index = index +1;
 uu_a2_cg_into_g = Output(:,index);index = index +1;                          
 uu_b2_pm_into_cpm = Output(:,index);index = index +1;
 uu_b2_cpm_into_pm = Output(:,index);index = index +1;
 uu_b2_cpm_into_mtc = Output(:,index);index = index +1;
 uu_b2_mtc_into_cg = Output(:,index);index = index +1;
 uu_b2_cg_into_g = Output(:,index);index = index +1;
 yy_a1_g_into_cg = Output(:,index);index = index +1;
 yy_a1_cg_into_g = Output(:,index);index = index +1;
 yy_a1_cg_into_mtc = Output(:,index);index = index +1;
 yy_a1_mtc_into_cpm = Output(:,index);index = index +1;
 yy_a1_cpm_into_pm = Output(:,index);index = index +1;
 yy_b1_g_into_cg = Output(:,index);index = index +1;
 yy_b1_cg_into_g = Output(:,index);index = index +1;
 yy_b1_cg_into_mtc = Output(:,index);index = index +1;
 yy_b1_mtc_into_cpm = Output(:,index);index = index +1;
 yy_b1_cpm_into_pm = Output(:,index);index = index +1;
 yy_a2_pm_into_cpm = Output(:,index);index = index +1;
 yy_a2_cpm_into_pm = Output(:,index);index = index +1;
 yy_a2_cpm_into_mtc = Output(:,index);index = index +1;
 yy_a2_mtc_into_cg = Output(:,index);index = index +1;
 yy_a2_cg_into_g = Output(:,index);index = index +1;                          
 yy_b2_pm_into_cpm = Output(:,index);index = index +1;
 yy_b2_cpm_into_pm = Output(:,index);index = index +1;
 yy_b2_cpm_into_mtc = Output(:,index);index = index +1;
 yy_b2_mtc_into_cg = Output(:,index);index = index +1;
 yy_b2_cg_into_g = Output(:,index);index = index +1;
 vv_a1_g_into_cg = Output(:,index);index = index +1;
 vv_a1_cg_into_g = Output(:,index);index = index +1;  
 vv_a1_cg_into_mtc = Output(:,index);index = index +1;   
 vv_a1_mtc_into_cpm = Output(:,index);index = index +1; 
 vv_a1_cpm_into_pm = Output(:,index);index = index +1;
 vv_b1_g_into_cg = Output(:,index);index = index +1; 
 vv_b1_cg_into_g = Output(:,index);index = index +1;  
 vv_b1_cg_into_mtc = Output(:,index);index = index +1;   
 vv_b1_mtc_into_cpm = Output(:,index);index = index +1; 
 vv_b1_cpm_into_pm = Output(:,index);index = index +1;
 vv_a2_pm_into_cpm = Output(:,index);index = index +1;
 vv_a2_cpm_into_pm = Output(:,index);index = index +1;
 vv_a2_cpm_into_mtc = Output(:,index);index = index +1;  
 vv_a2_mtc_into_cg = Output(:,index);index = index +1;  
 vv_a2_cg_into_g = Output(:,index);index = index +1;                          
 vv_b2_pm_into_cpm = Output(:,index);index = index +1;
 vv_b2_cpm_into_pm = Output(:,index);index = index +1;
 vv_b2_cpm_into_mtc = Output(:,index);index = index +1;  
 vv_b2_mtc_into_cg = Output(:,index);index = index +1;   
 vv_b2_cg_into_g = Output(:,index);index = index +1;
 cc1_a1_g_into_cg = Output(:,index);index = index +1;  
 cc1_a1_cg_into_g = Output(:,index);index = index +1;  
 cc1_a1_cg_into_mtc = Output(:,index);index = index +1;   
 cc1_a1_mtc_into_cpm = Output(:,index);index = index +1; 
 cc1_a1_cpm_into_pm = Output(:,index);index = index +1;
 cc1_b1_g_into_cg = Output(:,index);index = index +1;  
 cc1_b1_cg_into_g = Output(:,index);index = index +1;  
 cc1_b1_cg_into_mtc = Output(:,index);index = index +1;   
 cc1_b1_mtc_into_cpm = Output(:,index);index = index +1; 
 cc1_b1_cpm_into_pm = Output(:,index);index = index +1;
 cc1_a2_pm_into_cpm = Output(:,index);index = index +1;
 cc1_a2_cpm_into_pm = Output(:,index);index = index +1;
 cc1_a2_cpm_into_mtc = Output(:,index);index = index +1;  
 cc1_a2_mtc_into_cg = Output(:,index);index = index +1;  
 cc1_a2_cg_into_g = Output(:,index);index = index +1;                          
 cc1_b2_pm_into_cpm = Output(:,index);index = index +1;
 cc1_b2_cpm_into_pm = Output(:,index);index = index +1;
 cc1_b2_cpm_into_mtc = Output(:,index);index = index +1;  
 cc1_b2_mtc_into_cg = Output(:,index);index = index +1;   
 cc1_b2_cg_into_g = Output(:,index);index = index +1;
 cc2_a1_g_into_cg = Output(:,index);index = index +1; 
 cc2_a1_cg_into_g = Output(:,index);index = index +1; 
 cc2_a1_cg_into_mtc = Output(:,index);index = index +1;   
 cc2_a1_mtc_into_cpm = Output(:,index);index = index +1; 
 cc2_a1_cpm_into_pm = Output(:,index);index = index +1;
 cc2_b1_g_into_cg = Output(:,index);index = index +1; 
 cc2_b1_cg_into_g = Output(:,index);index = index +1;  
 cc2_b1_cg_into_mtc = Output(:,index);index = index +1;   
 cc2_b1_mtc_into_cpm = Output(:,index);index = index +1; 
 cc2_b1_cpm_into_pm = Output(:,index);index = index +1;
 cc2_a2_pm_into_cpm = Output(:,index);index = index +1;
 cc2_a2_cpm_into_pm = Output(:,index);index = index +1;
 cc2_a2_cpm_into_mtc = Output(:,index);index = index +1;  
 cc2_a2_mtc_into_cg = Output(:,index);index = index +1;  
 cc2_a2_cg_into_g = Output(:,index);index = index +1;                          
 cc2_b2_pm_into_cpm = Output(:,index);index = index +1;
 cc2_b2_cpm_into_pm = Output(:,index);index = index +1;
 cc2_b2_cpm_into_mtc = Output(:,index);index = index +1;  
 cc2_b2_mtc_into_cg = Output(:,index);index = index +1;   
 cc2_b2_cg_into_g = Output(:,index);index = index +1;
 kk_a1_g_into_cg = Output(:,index);index = index +1;  
 kk_a1_cg_into_g = Output(:,index);index = index +1;  
 kk_a1_cg_into_mtc = Output(:,index);index = index +1;   
 kk_a1_mtc_into_cpm = Output(:,index);index = index +1; 
 kk_a1_cpm_into_pm = Output(:,index);index = index +1;
 kk_b1_g_into_cg = Output(:,index);index = index +1;  
 kk_b1_cg_into_g = Output(:,index);index = index +1;  
 kk_b1_cg_into_mtc = Output(:,index);index = index +1;   
 kk_b1_mtc_into_cpm = Output(:,index);index = index +1;
 kk_b1_cpm_into_pm = Output(:,index);index = index +1;
 kk_a2_pm_into_cpm = Output(:,index);index = index +1;
 kk_a2_cpm_into_pm = Output(:,index);index = index +1;
 kk_a2_cpm_into_mtc = Output(:,index);index = index +1;  
 kk_a2_mtc_into_cg = Output(:,index);index = index +1;  
 kk_a2_cg_into_g = Output(:,index);index = index +1;                          
 kk_b2_pm_into_cpm = Output(:,index);index = index +1;
 kk_b2_cpm_into_pm = Output(:,index);index = index +1;
 kk_b2_cpm_into_mtc = Output(:,index);index = index +1;  
 kk_b2_mtc_into_cg = Output(:,index);index = index +1;  
 kk_b2_cg_into_g = Output(:,index);index = index +1;
 dd_a1_g_into_cg = Output(:,index);index = index +1;  
 dd_a1_cg_into_g = Output(:,index);index = index +1;  
 dd_a1_cg_into_mtc = Output(:,index);index = index +1;   
 dd_a1_mtc_into_cpm = Output(:,index);index = index +1; 
 dd_a1_cpm_into_pm = Output(:,index);index = index +1;
 dd_b1_g_into_cg = Output(:,index);index = index +1;  
 dd_b1_cg_into_g = Output(:,index);index = index +1;  
 dd_b1_cg_into_mtc = Output(:,index);index = index +1;   
 dd_b1_mtc_into_cpm = Output(:,index);index = index +1; 
 dd_b1_cpm_into_pm = Output(:,index);index = index +1;
 dd_a2_pm_into_cpm = Output(:,index);index = index +1;
 dd_a2_cpm_into_pm = Output(:,index);index = index +1;
 dd_a2_cpm_into_mtc = Output(:,index);index = index +1;  
 dd_a2_mtc_into_cg = Output(:,index);index = index +1;  
 dd_a2_cg_into_g = Output(:,index);index = index +1;                          
 dd_b2_pm_into_cpm = Output(:,index);index = index +1;
 dd_b2_cpm_into_pm = Output(:,index);index = index +1;
 dd_b2_cpm_into_mtc = Output(:,index);index = index +1;  
 dd_b2_mtc_into_cg = Output(:,index);index = index +1;  
 dd_b2_cg_into_g = Output(:,index);index = index +1;           
 velocity_a1_mtc_to_cpm = Output(:,index);index = index +1;
 velocity_b1_mtc_to_cpm = Output(:,index);index = index +1;
 velocity_a2_mtc_to_cg = Output(:,index);index = index +1; 
 velocity_b2_mtc_to_cg = Output(:,index);index = index +1;          
 dyn_MTs_length = Output(:,index);index = index +1;
 stbl_MTs_length, MTU_length
 
 
 

 flux1 = [b1_flux_G_to_CG, b1_flux_CG_to_G, b1_flux_CG_to_MTU, b1_flux_MTU_to_CPM,...
          b1_flux_CPM_to_PM, a2_flux_PM_to_CPM, a2_flux_CPM_to_PM, a2_flux_CPM_to_MTU,...
          a2_flux_MTU_to_CG, a2_flux_CG_to_G]; 
      
      fprintf('%d\n',flux1);
      
% 0.2623    0.0499    0.2125    0.2123    0.2123    0.8446    0.6710    0.1736    0.1734    0.1735
%  0.4403    0.0664    0.3739    0.3714    0.3714    0.8455    0.6264    0.2191    0.2187    0.2187
% 0.6752    0.0738    0.6013    0.5874    0.5871    0.8441    0.6122    0.2319    0.2308    0.2308
% 0.8057    0.0666    0.7391    0.7113    0.7113    0.8424    0.6173    0.2252    0.2236    0.2236
% 1.0225    0.0688    0.9537    0.8880    0.8880    0.8394    0.6336    0.2058    0.2035    0.2035
% 1.3032    0.0626    1.2406    1.0712    1.0712    0.8350    0.6604    0.1746    0.1715    0.1715
% 1.5873    0.0662    1.5211    1.1826    1.1826    0.8309    0.6837    0.1472    0.1434    0.1434

ymax = 2;
 
subplot(2,2,1)
%  plot(Output(:,1),Output(:,7) ,'.-','Color',[153/255 0 0.3],'LineWidth',LineWidth);
%  hold on;
%  plot(Output(:,1),Output(:,8),'.-','Color',[0 0 0],'LineWidth',LineWidth);
%  hold on;
%  plot(Output(:,1),Output(:,9),'.-','Color',[1 0 0],'LineWidth',LineWidth);
% %%xlabel('time (Sec)'); ylabel('flux ');
%  title('Flux between G & CG ')
%  legend(strcat('B1-G-into-CC: ',num2str(b1_flux_G_to_CG)),strcat('B1-CG-into-G: ',num2str(b1_flux_CG_to_G)),strcat('B1-CG-into-MTU: ',num2str(b1_flux_CG_to_MTU)))
%  %legend('Location','Northeast')
%  set(gca,'FontSize',fontSize);
%  xlabel('Time (Min)','FontSize',fontSize);
%  ylabel('Flux (AU)','FontSize',fontSize);
%  axis([0,max(Output(:,1)),0,ymax])
 
plot(Output(:,1),Output(:,7) ,'.-','Color',[153/255 0 0.3],'LineWidth',LineWidth);
 hold on;
 plot(Output(:,1),Output(:,8),'.-','Color',[0 0 0],'LineWidth',LineWidth);
 hold on;
 plot(Output(:,1),Output(:,9),'.-','Color',[1 0 0],'LineWidth',LineWidth);
%%xlabel('time (Sec)'); ylabel('flux ');
 title('Flux between G & CG ')
 legend(strcat('B1-G-into-CBC: ',num2str(b1_flux_G_to_CG)),strcat('B1-CBC-into-G: ',num2str(b1_flux_CG_to_G)),strcat('B1-CBC-into-MTU: ',num2str(b1_flux_CG_to_MTU)))
 %legend('Location','Northeast')
 set(gca,'FontSize',fontSize);
 xlabel('Time (Min)','FontSize',fontSize);
 ylabel('Flux (AU)','FontSize',fontSize);
 axis([0,max(Output(:,1)),0,ymax])
 
  subplot(2,2,2)
  plot(Output(:,1),Output(:,10),'.-','Color',[200/255 100/255 0/255],'LineWidth',LineWidth);
  hold on;
  plot(Output(:,1),Output(:,11),'.-','Color',[1 150/255 50/255],'LineWidth',LineWidth);
  %xlabel('time (Sec)'); ylabel('flux ');
  title('Flux between MTU & NTC')
  legend(strcat('B1-MTU-into-CPM: ',num2str(b1_flux_MTU_to_CPM)),strcat('B1-CPM-into-PM: ',num2str(b1_flux_CPM_to_PM)))
  legend('Location','Northeast')
  set(gca,'FontSize',fontSize);
   xlabel('Time (Min)','FontSize',fontSize);
  ylabel('Flux (AU)','FontSize',fontSize);
  axis([0,max(Output(:,1)),0,ymax])
 
 
 subplot(2,2,3)
             
 plot(Output(:,1),Output(:,12),'.-','Color',[0 0 200/255],'LineWidth',LineWidth);
 hold on;
 plot(Output(:,1),Output(:,13),'.-','Color',[0 0 0],'LineWidth',LineWidth);
 hold on;
 plot(Output(:,1),Output(:,14),'.-','Color',[100/255 50/255 200/255],'LineWidth',LineWidth);
 %xlabel('time (Sec)'); ylabel('flux ');
 title('Flux between PM & NTC ')
legend(strcat('a2-PM-into-CPM: ',num2str(a2_flux_PM_to_CPM)),strcat('a2-CPM-into-PM: ',num2str(a2_flux_CPM_to_PM)),strcat('a2-CPM-into-MTU: ',num2str(a2_flux_CPM_to_MTU)))
 %legend('Location','Northeast')
 set(gca,'FontSize',fontSize);
  xlabel('Time (Min)','FontSize',fontSize);
 ylabel('Flux (AU)','FontSize',fontSize);
 axis([0,max(Output(:,1)),0,ymax])

 
 subplot(2,2,4)
 plot(Output(:,1),Output(:,15),'.-','Color',[0/255 130/255 255/255],'LineWidth',LineWidth);
 hold on;
 plot(Output(:,1),Output(:,16),'.-','Color',[150/255 255/255 200/255],'LineWidth',LineWidth);
 %xlabel('time (Sec)'); ylabel('flux ');
 title('Flux between MTU & CG')
legend(strcat('a2-MTU-into-CG: ',num2str(a2_flux_MTU_to_CG)),strcat('a2-CG-into-G: ',num2str(a2_flux_CG_to_G)))
 %legend('Location','Northeast')
 set(gca,'FontSize',fontSize);
 xlabel('Time (Min)','FontSize',fontSize);
 ylabel('Flux (AU)','FontSize',fontSize);
  axis([0,max(Output(:,1)),0,ymax])
  
  
  
  
% %   
% % 
% % figure(3);
% % axis_fontSize = 15;
% % xlabel_text = 'time [min]';
% % ylabel_text = 'length [uM]';
% % 
% % 
% % plot(Output(:,1),Output(:,18), '.-b','LineWidth',2)
% % hold on;
% % plot(Output(:,1),Output(:,19), '.-r','LineWidth',2);
% % hold on;
% % plot(Output(:,1),Output(:,20), '-g','LineWidth',2);
% % xlabel(xlabel_text); 
% % ylabel(ylabel_text);
% % ylim(max(Output(:,20))+5);
% % title('Microtubule Dynamics')
% % %legend('Neurite length','dynamic MT length');
% % % legend(strcat('Neurite length: steady state growth: ',num2str(velocity*60),'um/h'));
% % set(gca,'FontSize',axis_fontSize);
% % legend('Location','Northeast') 