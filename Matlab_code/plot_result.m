% %% plot results codes
function SSE = plot_result(para_est,data)



NOG_parameters_set_vector;
NOG_initial_concentrations_steady_state;
NOG_statevar_set;
statevar_input = statevar;


parameters(26) = 0.83; %wa * factor_budding_a;
parameters(27) = para_est(1); %wb * factor_budding_b;
% Binding rates of vesicles to motor transport compartment
parameters(28) = para_est(2); %lambda1;
parameters(29) = para_est(3); %lambda2;
% Kinesin and dynein related parameters
parameters(30) = 60;%  (1 micro meter / sec); %velocity_k;
parameters(31) = 39;% (0.65 micro meter / sec); %velocity_d;

% SNARE complex formation rates
%kappaXU = parameters(24); % 
parameters(32) = para_est(4); 
% %kappaYV = parameters(25);
parameters(33) = para_est(5); 

%%%%%%%%%%
% Define special parameters
k_membrane_production = para_est(6); %0.0004 * factor_membrane_production; % * 10; % * 2^(0.783 + 0.721);% CERS1(2^0.783), UGCG(2^(-1.329+0.721);
parameters(34) = k_membrane_production;

nucleation_rate = 0.01; 
parameters(35) = nucleation_rate;

stabilization_rate = para_est(7); %0.2; 
parameters(36) = stabilization_rate;

tspan = [0 3240];

parameters0 = parameters;

[t,statevar_timelines] = ode15s(@(t,statevar)NOG_function1(t,statevar,parameters0),tspan, statevar_input);

NOG_statevar_get_timelines;






figure(1);


axis_fontSize = 15;
axis_label_fontSize = 20;
xlabel_text = 'time [min]';
ylabel_text = 'surface membrane area';

Color_golgi = [ 1; 0.3; 0];
Color_mtc = [ 0; 0.5; 0.5 ];
Color_pm = [ 0; 0.5; 1];
title_font_size = 20;
LineWidth = 3;

plasma_membrane_length = 10 + s3 / (2 * pi * radius_neurite);
 
nb1_mtc_per_length = nb1_mtc ./ plasma_membrane_length;
na2_mtc_per_length = na2_mtc ./ plasma_membrane_length;
 



subplot(2,2,1)
plot(t,s1,'-','Color',Color_golgi,'LineWidth',LineWidth);
hold on
plot(t,s2,'-','Color',Color_pm,'LineWidth',LineWidth);
hold on;
plot(t,s3,'-','Color',Color_mtc,'LineWidth',LineWidth);

xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('membrane surface','FontSize',axis_label_fontSize);
title('Terminal Compartments','FontSize',title_font_size);
legend('Golgi','Neurite shaft PM','Growth cone PM');
ylim([0 1.2*max(s3)]);
set(gca,'FontSize',axis_fontSize);
legend('Location','Northeast');
b = gca; legend(b,'off');
%n=get(gca,'ytick');
%set(gca,'yticklabel',sprintf('%.3f |',n'));

subplot(2,2,2)
plot(t,nb1_cg,'-','Color',Color_golgi,'LineWidth',LineWidth);
hold on;
plot(t,nb1_mtc,'-','Color',Color_mtc,'LineWidth',LineWidth);
hold on;
plot(t, nb1_cpm,'-','Color',Color_pm,'LineWidth',LineWidth);
hold on;
plot(t,nb1_mtc_per_length,'--','Color',Color_mtc,'LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('membrane surface','FontSize',axis_label_fontSize);
title('Forward moving coat B vesicles','FontSize',title_font_size);
legend('nb1_{cg}','nb1_{mtc}','nb1_{cpm}',strcat('nb1_{mtc per Length}: ',num2str(mean(nb1_mtc_per_length))));
set(gca,'FontSize',axis_fontSize);
legend('Location','Northeast')
n=get(gca,'ytick');
ylim([0 1.2*max(nb1_mtc)]);
% set(gca,'yticklabel',sprintf('%.3f |',n'));
b = gca; legend(b,'off');

subplot(2,2,3)
plot(t,na2_cpm,'-','Color',Color_pm,'LineWidth',LineWidth);
hold on;
plot(t,na2_mtc,'-','Color',Color_mtc,'LineWidth',LineWidth);
hold on;
plot(t,na2_cg, '-','Color',Color_golgi,'LineWidth',LineWidth);
hold on;
plot(t,na2_mtc_per_length,'--','Color',Color_mtc,'LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize);
ylabel('membrane surface','FontSize',axis_label_fontSize);
title('Backward moving coat A vesicles','FontSize',title_font_size);
legend('na2_{cpm}','na2_{mtc}','na2_{cg}', strcat('na2_{mtc per Length}:',num2str(mean(na2_mtc_per_length))));
set(gca,'FontSize',axis_fontSize);
legend('Location','Northeast')
n=get(gca,'ytick');
% set(gca,'yticklabel',sprintf('%.3f |',n'));
ylim([0 1.2*max(nb1_mtc)]);


subplot(2,2,4)
 
ylimits = [ 0 1.1*max(plasma_membrane_length)];

plasma_membrane_length = 10 + s3 / (2 * pi * radius_neurite);

t_above_1200 = find(t>=1200);
index1 = t_above_1200(1);
index2 = length(t);

velocity = (plasma_membrane_length(index2) - plasma_membrane_length(index1)) / (t(index2)- t(index1));


plot(t,plasma_membrane_length,'.-r')
xlabel('time [min]'); 
ylabel('length [\mum]');
ylim(ylimits);
title('Lengthes')
%legend('Neurite length','dynamic MT length');
legend(strcat('Neurite length: steady state growth: ',num2str(velocity*60),'\mum/h'));
set(gca,'FontSize',axis_fontSize);
legend('Location','Northeast') 




sample_t = 0:360: 3240;
s1 = interp1(t,statevar_timelines(:,1),sample_t);
s2 = interp1(t,statevar_timelines(:,end-11),sample_t);
s3 = interp1(t,statevar_timelines(:,end-2) ,sample_t);
Ant_CG_vesicles = interp1(t,(nb1_cg ),sample_t);
Ant_CPM_vesicles = interp1(t,( nb1_cpm ),sample_t);
Ret_CG_vesicles = interp1(t,(na2_cg  ),sample_t);
Ret_CPM_vesicles = interp1(t,( na2_cpm  ),sample_t);
stbl_MTs_length = interp1(t,statevar_timelines(:,end) ,sample_t);

% Ant_CG = max(Ant_CG_vesicles);
% Ant_CPM = max(Ant_CPM_vesicles);
% Ret_CG = max(Ret_CG_vesicles);
% Ret_CPM = max(Ret_CPM_vesicles);

Ant_CG  =  Ant_CG_vesicles(end);
Ant_CPM = Ant_CPM_vesicles(end);
Ret_CG  = Ret_CG_vesicles(end);
Ret_CPM = Ret_CPM_vesicles(end);

plasma_membrane_length = 10 + s3 / (2 * pi * radius_neurite);
MTU_Length = stbl_MTs_length + 7.1214;

y_exp1 = data(1,1:10); 
y_exp2 = data(2,1:10); 
y_exp3 = data(3,1:10);
y_exp4 = data(4,1:10);


%
axis_fontSize = 15;
xlabel_text = 'time [min]';
ylabel_text = 'length [uM]';
ylimits = [ 0 max(plasma_membrane_length)];
t_above_400 = find(t>=400);
index1 = t_above_400(1);
index2 = length(t);

% velocity = (plasma_membrane_length(index2) - plasma_membrane_length(index1)) / (t(index2)- t(index1));
% %

figure(2);

subplot(2,2,1)
plot(sample_t, y_exp1,'*-b','LineWidth',2)
hold on;
plot(sample_t, plasma_membrane_length,'.-r','LineWidth',2);
xlabel(xlabel_text); 
ylabel(ylabel_text);
ylim(ylimits);
title('Lengthes')
%legend('Neurite length','dynamic MT length');
% legend(strcat('Neurite length: steady state growth: ',num2str(velocity*60),'um/h'));
set(gca,'FontSize',axis_fontSize);
legend('Location','Northeast') 

subplot(2,2,2)
plot(sample_t, y_exp2,'*-b','LineWidth',2)
hold on;
plot(sample_t, s1,'.-r','LineWidth',2);
ylim([0 1.2*max(y_exp2)])
xlabel(xlabel_text); 
title('Golgi Size')

subplot(2,2,3)
plot(sample_t, y_exp3,'*-b','LineWidth',2)
hold on;
plot(sample_t, MTU_Length,'.-r','LineWidth',2);
% ylim([0 1])
ylim(ylimits);
xlabel(xlabel_text); 
title('MTU Length')

subplot(2,2,4)
plot(sample_t(2:10), y_exp4(2:10),'*-b','LineWidth',2)
hold on;
plot(sample_t(2:10),Ant_CG_vesicles(2:10),'-g','LineWidth',2)
hold on;
plot(sample_t(2:10),Ant_CPM_vesicles(2:10),'-r','LineWidth',2)
hold on;
plot(sample_t(2:10),Ret_CG_vesicles(2:10),'-b','LineWidth',2)
hold on;
plot(sample_t(2:10),Ret_CPM_vesicles(2:10),'-k','LineWidth',2)

xlabel('Time [min]'); 
ylabel('Vesicles surface area' );
% ylim(ylimits);
title('vesicles surface area')
legend('Exp result',strcat('Ant-CC-Ves-Suf-Area.: ',num2str(Ant_CG)),strcat('Ant-CPM-Ves-Suf-Area.: ',num2str(Ant_CPM)) ,...
    strcat('Ret-CC-Ves-Suf-Area.: ',num2str(Ret_CG)),strcat('Ret-CPM-Ves-Suf-Area.: ',num2str(Ret_CPM)));
% legend(strcat('vesicles surface area: ',num2str(CG),num2str(CPM)));
set(gca,'FontSize',axis_fontSize);
legend('Location','Northeast') 
ylim([0 0.5])

% 
% vesicle_dist = [Ant_CG, max(nb1_mtc_per_length), Ant_CPM, Ret_CG, max(na2_mtc_per_length),Ret_CPM];
%  fprintf('%d\n',vesicle_dist);





% 
% %% ################
% figure(3)
%  subplot(2,2,1)
%  ymax=0.020;
%  fontSize = 20;
%  LineWidth = 3;
% 
%  
%  plot(Output(:,1),Output(:,7) ,'.-','Color',[153/255 0 0.3],'LineWidth',LineWidth);
%  hold on;
%  plot(Output(:,1),Output(:,8),'.-','Color',[0 0 0],'LineWidth',LineWidth);
%  hold on;
%  plot(Output(:,1),Output(:,9),'.-','Color',[1 0 0],'LineWidth',LineWidth);
% %%xlabel('time (Sec)'); ylabel('flux ');
%  title('Flux between G & CG ')
%  legend('b1_{G into CC}','b1_{CC into G}','b1_{CC into MTU}')
%  %legend('Location','Northeast')
%  set(gca,'FontSize',fontSize);
%  xlabel('Time (Min)','FontSize',fontSize);
%  ylabel('Flux (AU)','FontSize',fontSize);
%  axis([0,max(Output(:,1)),0,ymax])
%  
%  subplot(2,2,2)
%  plot(Output(:,1),Output(:,10),'.-','Color',[200/255 100/255 0/255],'LineWidth',LineWidth);
%  hold on;
%  plot(Output(:,1),Output(:,11),'.-','Color',[1 150/255 50/255],'LineWidth',LineWidth);
%  %xlabel('time (Sec)'); ylabel('flux ');
%  title('Flux between MTU & NTC')
%  legend('b1_{MTU into NTC}', 'b1_{NTC into PM}')
%  legend('Location','Northeast')
%  set(gca,'FontSize',fontSize);
%   xlabel('Time (Min)','FontSize',fontSize);
%  ylabel('Flux (AU)','FontSize',fontSize);
%  axis([0,max(Output(:,1)),0,ymax])
%  
%  subplot(2,2,3)
%              
%  plot(Output(:,1),Output(:,12),'.-','Color',[0 0 200/255],'LineWidth',LineWidth);
%  hold on;
%  plot(Output(:,1),Output(:,13),'.-','Color',[0 0 0],'LineWidth',LineWidth);
%  hold on;
%  plot(Output(:,1),Output(:,14),'.-','Color',[100/255 50/255 200/255],'LineWidth',LineWidth);
%  %xlabel('time (Sec)'); ylabel('flux ');
%  title('Flux between PM & NTC ')
%  legend('a2_{PM into NTC}','a2_{NTC into PM}', 'a2_{NTC into MTU}')
%  %legend('Location','Northeast')
%  set(gca,'FontSize',fontSize);
%   xlabel('Time (Min)','FontSize',fontSize);
%  ylabel('Flux (AU)','FontSize',fontSize);
%  axis([0,max(Output(:,1)),0,ymax])
% 
%  
%  subplot(2,2,4)
%  plot(Output(:,1),Output(:,15),'.-','Color',[0/255 130/255 255/255],'LineWidth',LineWidth);
%  hold on;
%  plot(Output(:,1),Output(:,16),'.-','Color',[150/255 255/255 200/255],'LineWidth',LineWidth);
%  %xlabel('time (Sec)'); ylabel('flux ');
%  title('Flux between MTU & CG')
%  legend('a2_{MTU into CC}', ' a2_{CC into G}')
%  %legend('Location','Northeast')
%  set(gca,'FontSize',fontSize);
%  xlabel('Time (Min)','FontSize',fontSize);
%  ylabel('Flux (AU)','FontSize',fontSize);
%   axis([0,max(Output(:,1)),0,ymax])
% % 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% 
% % 
% % figure(3)
% % 
% % sample_t = 0: 360:3240;
% % 
% % 
% % subplot(1,2,1)
% % plot(sample_t, y_exp4,'*-b','LineWidth',2)
% % hold on;
% % plot(sample_t,CG_vesicles,'*-r','LineWidth',2)
% % hold on;
% % plot(sample_t,CPM_vesicles,'*-g','LineWidth',2)
% % 
% % xlabel('Time [min]'); 
% % ylabel('surface area' );
% % % ylim(ylimits);
% % title('CC Vesicles & CPM Vesicles ')
% % %legend('Neurite length','dynamic MT length');
% % % legend(strcat('vesicles surface area: ',num2str(CG)));
% % set(gca,'FontSize',axis_fontSize);
% % legend('Location','Northeast') 
% % 
% % subplot(1,2,2)
% % plot(sample_t, y_exp5,'*-b','LineWidth',2)
% % hold on;
% % plot(sample_t,CPM_vesicles,'*-r','LineWidth',2)
% % xlabel('Time [min]'); 
% % ylabel('surface area' );
% % % ylim(ylimits);
% % title('CPM Vesicles')
% % %legend('Neurite length','dynamic MT length');
% % legend(strcat('vesicles surface area: ',num2str(CPM)));
% % set(gca,'FontSize',axis_fontSize);
% % legend('Location','Northeast') 
% % 
% % 
% % 
% % 
% % % 
% % % sample_t = 0:360: 3240;
% % % 
% % % Vesicle_CG =interp1(t, (na1_cg  + na2_cg  + nb1_cg  + nb2_cg),sample_t);
% % % Vesicle_MTU = interp1(t, (na1_mtc + na2_mtc + nb1_mtc + nb2_mtc),sample_t);
% % % Vesicle_CPM = interp1(t, (na1_cpm + na2_cpm + nb1_cpm + nb2_cpm),sample_t);
% % % s1 = interp1(t,statevar_timelines(:,1),sample_t);
% % % 
% % % CG = max(Vesicle_CG);
% % % MTU = max(Vesicle_MTU);
% % % CPM = max(Vesicle_CPM);
% % % s1_max = max(s1);
% % % 
% % % 
% % % subplot(2,2,1)
% % % plot(sample_t,Vesicle_CG,'.-r')
% % % xlabel('Time [min]'); 
% % % ylabel('surface area' );
% % % % ylim(ylimits);
% % % title('CC Vesicles')
% % % %legend('Neurite length','dynamic MT length');
% % % legend(strcat('vesicles surface area: ',num2str(CG)));
% % % set(gca,'FontSize',axis_fontSize);
% % % legend('Location','Northeast') 
% % % 
% % % subplot(2,2,2)
% % % plot(sample_t,Vesicle_MTU./MTU_Length,'.-r')
% % % xlabel('Time [min]'); 
% % % ylabel('surface area' );
% % % % ylim(ylimits);
% % % title('MTU Vesicles')
% % % %legend('Neurite length','dynamic MT length');
% % % legend(strcat('vesicles surface area: ',num2str(MTU)));
% % % set(gca,'FontSize',axis_fontSize);
% % % legend('Location','Northeast') 
% % % 
% % % subplot(2,2,3)
% % % plot(sample_t,Vesicle_CPM,'.-r')
% % % xlabel('Time [min]'); 
% % % ylabel('surface area' );
% % % % ylim(ylimits);
% % % title('CPM Vesicles')
% % % %legend('Neurite length','dynamic MT length');
% % % legend(strcat('vesicles surface area: ',num2str(CPM)));
% % % set(gca,'FontSize',axis_fontSize);
% % % legend('Location','Northeast') 
% % % 
% % % subplot(2,2,4)
% % % plot(sample_t,s1,'.-r')
% % % xlabel('Time [min]'); 
% % % ylabel('surface area' );
% % % % ylim(ylimits);
% % % title('Golgi Size')
% % % %legend('Neurite length','dynamic MT length');
% % % legend(strcat('Golgi surface area: ',num2str(s1_max)));
% % % set(gca,'FontSize',axis_fontSize);
% % % legend('Location','Northeast') 
% % 
