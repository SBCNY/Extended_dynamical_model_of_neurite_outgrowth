
%% Neurite Growth Velocity vs Neurite length
% M= zeros(64801,8);
% M(:,1) = dlmread('plasma_membrane_length' );
% M(:,2) = dlmread('plasma_membrane_length1' );
% M(:,3) = dlmread('plasma_membrane_length2' );
% M(:,4) = dlmread('plasma_membrane_length3' );
% M(:,5) = dlmread('plasma_membrane_length4' );
% M(:,6) = dlmread('plasma_membrane_length5' );
% M(:,7) = dlmread('plasma_membrane_length6' );
% M(:,8) = dlmread('plasma_membrane_length7' );
% 
% plot(M(:,1),M(:,8),'.-c')
% hold on;
% plot(M(:,1),M(:,7),'.-m')
% hold on;
% plot(M(:,1),M(:,6),'.-y')
% hold on;
% plot(M(:,1),M(:,5),'.-g')
% hold on;
% plot(M(:,1),M(:,4),'.-k')
% hold on;
% plot(M(:,1),M(:,3),'.-b')
% hold on;
% plot(M(:,1),M(:,2),'.-r')
% 


%%

v = [ 0.732 2.90 6.6675 9.2094 12.8517 17.046 20.933];
wb = [0.26 0.44 0.69 0.84 1.10 1.48 1.9];
lambda1 = [50 100 210 320 450 750 1000 ];
lambda2 = [100 100 100 100 100 100 100];
kappaXU   = [40 40 40 40 40 40 40 ];
kappaYV   = [45 45 45 45 45 45 45 ];
k_mem_pro = [ 0.039 0.155 0.37 0.515 0.75 1.07 1.38];
stbl_rate = [0.0017  0.0068  0.0156 0.0216  0.0301 0.0399 0.0490];

Neurite_length = [49.5280 49.5280 49.5280 49.5280 49.5280 49.5280 49.5280;...
                  49.5280 166.6000 166.6000 166.6000 166.6000 166.6000 166.6000;...
                  49.5280 166.6000 370.0450 370.0450 370.0450 370.0450 370.0450;...
                  49.5280 166.6000 370.0450 507.3076 507.3076 507.3076 507.3076;...
                  49.5280 166.6000 370.0450 507.3076 703.9918 703.9918 703.9918;...
                  49.5280 166.6000 370.0450 507.3076 703.9918 930.4840 930.4840;...
                  49.5280 166.6000 370.0450  507.3076 703.9918 930.4840 1140.4];                                      	                 
                                                            
                                                          
axis_fontSize = 12;
axis_label_fontSize = 15;
xlabel_text = 'Neurite Growth Rate [\mum/hr]';
ylabel_text = 'Rate';

title_font_size = 16;
LineWidth = 3;

figure(1);

subplot(3,3,1)
plot(v,k_mem_pro,'-om','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel(ylabel_text,'FontSize',axis_label_fontSize);
title('Membrane Production at TGN','FontSize',title_font_size);
xlim([0 22]);

subplot(3,3,2)
plot(v,wb,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel(ylabel_text,'FontSize',axis_label_fontSize);
title('Vesicles budding at TGN','FontSize',title_font_size);
xlim([0 22]);

subplot(3,3,3)
plot(v,lambda1,'-ob','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel(ylabel_text,'FontSize',axis_label_fontSize);
title('Anterograde Vesicles loading ','FontSize',title_font_size);
xlim([0 22]);

subplot(3,3,4)
plot(v,lambda2,'-ob','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel(ylabel_text,'FontSize',axis_label_fontSize);
title('Retrograde Vesicles loading','FontSize',title_font_size);
xlim([0 22]);

subplot(3,3,5)
plot(v,kappaXU,'-og','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel(ylabel_text,'FontSize',axis_label_fontSize);
title('Vesicles fusion at TGN','FontSize',title_font_size);
xlim([0 22]);

subplot(3,3,6)
plot(v,kappaYV,'-og','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel(ylabel_text,'FontSize',axis_label_fontSize);
title('Vesicles fusion at Growth Cone','FontSize',title_font_size);
xlim([0 22]);

subplot(3,3,7)
plot(v,stbl_rate,'-ok','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel(ylabel_text,'FontSize',axis_label_fontSize);
title('MTs stablization rate','FontSize',title_font_size);
xlim([0 22]);


%%
flux =[ 0.2623    0.0499    0.2125    0.2123    0.2123    0.8446    0.6710    0.1736    0.1734    0.1735;...
        0.4403    0.0664    0.3739    0.3714    0.3714    0.8455    0.6264    0.2191    0.2187    0.2187;...
        0.6752    0.0738    0.6013    0.5874    0.5871    0.8441    0.6122    0.2319    0.2308    0.2308;...
        0.8057    0.0666    0.7391    0.7113    0.7113    0.8424    0.6173    0.2252    0.2236    0.2236;...
        1.0225    0.0688    0.9537    0.8880    0.8880    0.8394    0.6336    0.2058    0.2035    0.2035;...
        1.3032    0.0626    1.2406    1.0712    1.0712    0.8350    0.6604    0.1746    0.1715    0.1715;...
        1.5873    0.0662    1.5211    1.1826    1.1826    0.8309    0.6837    0.1472    0.1434    0.1434];
    
B1_G_to_CG    = flux(:,1);
B1_CG_to_G    = flux(:,2);
B1_CG_to_MTU  = flux(:,3);
B1_MTU_to_CPM = flux(:,4);
B1_CPM_to_PM  = flux(:,5);
A2_PM_to_CPM  = flux(:,6);
A2_CPM_to_PM  = flux(:,7);
A2_CPM_to_MTU = flux(:,8);
A2_MTU_to_CG  = flux(:,9);
A2_CG_to_G    = flux(:,10);

%##################
figure(2);

subplot(2,5,1)
plot(v,B1_G_to_CG,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Flux G to CG','FontSize',title_font_size);
xlim([0 22]);
ylim([0 max(B1_G_to_CG)]);

subplot(2,5,2)
plot(v,B1_CG_to_G ,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Flux CG to G','FontSize',title_font_size);
xlim([0 22]);
ylim([0 max(B1_G_to_CG)]);

subplot(2,5,3)
plot(v,B1_CG_to_MTU ,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Flux CG to MTU','FontSize',title_font_size);
xlim([0 22]);
ylim([0 max(B1_G_to_CG)]);

subplot(2,5,4)
plot(v,B1_MTU_to_CPM ,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Flux MTU to CPM','FontSize',title_font_size);
xlim([0 22]);
ylim([0 max(B1_G_to_CG)]);

subplot(2,5,5)
plot(v,B1_CPM_to_PM ,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Flux CPM to PM','FontSize',title_font_size);
xlim([0 22]);
ylim([0 max(B1_G_to_CG)]);

subplot(2,5,6)
plot(v,A2_PM_to_CPM,'-og','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Flux PM to CPM','FontSize',title_font_size);
xlim([0 22]);
ylim([0 max(A2_PM_to_CPM)]);

subplot(2,5,7)
plot(v,A2_CPM_to_PM ,'-og','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Flux CPM to PM','FontSize',title_font_size);
xlim([0 22]);
ylim([0 max(A2_PM_to_CPM)]);

subplot(2,5,8)
plot(v,A2_CPM_to_MTU ,'-og','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Flux CPM to MTU','FontSize',title_font_size);
xlim([0 22]);
ylim([0 max(A2_PM_to_CPM)]);

subplot(2,5,9)
plot(v,A2_MTU_to_CG,'-og','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Flux MTU to CG','FontSize',title_font_size);
xlim([0 22]);
ylim([0 max(A2_PM_to_CPM)]);

subplot(2,5,10)
plot(v,A2_CG_to_G,'-og','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Flux CG to G','FontSize',title_font_size); 
xlim([0 22]);
ylim([0 max(A2_PM_to_CPM)]);



%########################

% Anterograde SNARE plot XU & YV

D =[9.873541  3.640018e-05 1.455242e-03 2.942623e-06 1.232594e-01 9.873541e+00 3.640018e-05 1.455242e-03 2.942623e-06 1.232594e-01 7.977930e-01 2.941175e-04 1.175874e-02 2.377670e-05 9.917974e+01 7.977930e-01 2.941175e-04 1.175874e-02 2.377670e-05 9.917974e+01;...
    9.805494  6.160032e-05 1.680716e-02 7.197202e-06 1.709000e-01 9.805494e+00 6.160032e-05 1.680716e-02 7.197202e-06 1.709000e-01 5.658848e-01 3.555017e-04 9.700767e-02 4.154189e-05 9.930557e+01 5.658848e-01 3.555017e-04 9.700767e-02 4.154189e-05 9.930557e+01;...
    9.622452  8.247771e-05 1.049102e-01 1.723250e-05 2.527454e-01 9.622452 8.247771e-05 1.049102e-01 1.723250e-05 2.527454e-01 3.662761e-01 3.139487e-04 4.001573e-01 6.573808e-05 9.916551e+01 3.662761e-01 3.139487e-04 4.001573e-01 6.573808e-05 9.916551e+01;...
    9.449285  7.985122e-05 2.073013e-01 2.617776e-05 3.111381e-01 9.449285e+00 7.985122e-05 2.073013e-01 2.617776e-05 3.111381e-01 2.864284e-01 2.420469e-04 6.316365e-01 7.976233e-05 9.898896e+01 2.864284e-01 2.420469e-04 6.316365e-01 7.976233e-05 9.898896e+01;...
    9.091097  8.963630e-05 4.427345e-01 4.443694e-05 4.086813e-01 9.091097e+00 8.963630e-05 4.427345e-01 4.443694e-05 4.086813e-01 2.016037e-01 1.987776e-04 9.946358e-01 9.983101e-05 9.866966e+01 2.016037e-01 1.987776e-04 9.946358e-01 9.983101e-05 9.866966e+01;...
    8.447075  9.017302e-05 9.085918e-01 7.547350e-05 5.419276e-01 8.447075e+00 9.017302e-05 9.085918e-01 7.547350e-05 5.419276e-01 1.315836e-01 1.404682e-04 1.454316e+00 1.208056e-04 9.822571e+01 1.315836e-01 1.404682e-04 1.454316e+00 1.208056e-04 9.822571e+01;...
    7.713527  1.055227e-04 1.486242e+00 1.074138e-04 6.520782e-01 7.713527e+00 1.055227e-04 1.486242e+00 1.074138e-04 6.520782e-01 9.238542e-02 1.263845e-04 1.849798e+00 1.336893e-04 9.782292e+01 9.238542e-02 1.263845e-04 1.849798e+00 1.336893e-04 9.782292e+01    ];



xx_g       = D(:,1);
xx_b1_cg   = D(:,2);
xx_b1_mtc  = D(:,3);
xx_b1_cpm  = D(:,4);
xx_pm      = D(:,5);
uu_g       = D(:,6);
uu_b1_cg   = D(:,7);
uu_b1_mtc  = D(:,8);
uu_b1_cpm  = D(:,9);
uu_pm      = D(:,10);
yy_g       = D(:,11);
yy_b1_cg   = D(:,12);
yy_b1_mtc  = D(:,13);
yy_b1_cpm  = D(:,14);
yy_pm      = D(:,15);
vv_g       = D(:,16);
vv_b1_cg   = D(:,17);
vv_b1_mtc  = D(:,18);
vv_b1_cpm  = D(:,19);
vv_pm      = D(:,20);

%##### SNARE X U #####
figure(4);


subplot(2,5,1)
plot(v,xx_g,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('SNARE X in G','FontSize',title_font_size);
ylim([0 max(xx_g)]);

subplot(2,5,2)
plot(v,xx_b1_cg ,'-og','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('SNARE X with coat in CG','FontSize',title_font_size);
ylim([0 max(xx_b1_cg)]);

subplot(2,5,3)
plot(v,xx_b1_mtc,'-ok','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('SNARE X with coat in MTU','FontSize',title_font_size);
ylim([0 max(xx_b1_mtc)]);

subplot(2,5,4)
plot(v,xx_b1_cpm,'-ob','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('SNARE X with coat in CPM','FontSize',title_font_size);
ylim([0 max(xx_b1_cpm)]);

subplot(2,5,5)
plot(v,xx_pm,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('SNARE X in PM','FontSize',title_font_size);
ylim([0 max(xx_pm)]);

subplot(2,5,6)
plot(v,uu_g,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('SNARE U in G','FontSize',title_font_size);
ylim([0 max(uu_g)]);

subplot(2,5,7)
plot(v,uu_b1_cg ,'-og','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('SNARE U with coat in CG','FontSize',title_font_size);
ylim([0 max(uu_b1_cg)]);

subplot(2,5,8)
plot(v,uu_b1_mtc,'-ok','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('SNARE U with coat in MTU','FontSize',title_font_size);
ylim([0 max(uu_b1_mtc)]);

subplot(2,5,9)
plot(v,uu_b1_cpm,'-ob','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('SNARE U with coat in CPM','FontSize',title_font_size);
ylim([0 max(uu_b1_cpm)]);

subplot(2,5,10)
plot(v,uu_pm,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('SNARE U in PM','FontSize',title_font_size);
ylim([0 max(uu_pm)]);


%##### SNARE #####
figure(5);


subplot(2,5,1)
plot(v,yy_g,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('SNARE Y in G','FontSize',title_font_size);
ylim([0 max(yy_g)]);

subplot(2,5,2)
plot(v,yy_b1_cg ,'-og','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('SNARE Y with coat B in CG','FontSize',title_font_size);
ylim([0 max(yy_b1_cg)]);

subplot(2,5,3)
plot(v,yy_b1_mtc,'-ok','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('SNARE Y with coat B in MTU','FontSize',title_font_size);
ylim([0 max(yy_b1_mtc)]);

subplot(2,5,4)
plot(v,yy_b1_cpm,'-ob','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('SNARE Y with coat B in CPM','FontSize',title_font_size);
ylim([0 max(yy_b1_cpm)]);

subplot(2,5,5)
plot(v,yy_pm,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('SNARE Y in PM','FontSize',title_font_size);
ylim([0 max(yy_pm)]);

subplot(2,5,6)
plot(v,vv_g,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('SNARE V in G','FontSize',title_font_size);
ylim([0 max(vv_g)]);

subplot(2,5,7)
plot(v,vv_b1_cg ,'-og','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('SNARE V with coat B in CG','FontSize',title_font_size);
ylim([0 max(vv_b1_cg)]);

subplot(2,5,8)
plot(v,vv_b1_mtc,'-ok','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('SNARE V with coat B in MTU','FontSize',title_font_size);
ylim([0 max(vv_b1_mtc)]);

subplot(2,5,9)
plot(v,vv_b1_cpm,'-ob','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('SNARE V with coat B in CPM','FontSize',title_font_size);
ylim([0 max(vv_b1_cpm)]);

subplot(2,5,10)
plot(v,vv_pm,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('SNARE V in PM','FontSize',title_font_size);
ylim([0 max(vv_pm)]);


E =[2.664407e+00 3.364880e-07 1.298780e-05 3.719916e-08 4.779174e+01 4.249162e-03 1.698779e-01 3.435066e-04 4.262963e+01 5.383696e-05 2.078243e-03 5.952412e-06 7.638201e+00 6.798518e-03 2.717993e-01 5.496012e-04;...
   1.085215e+00 1.268472e-07 2.730171e-05 1.069009e-08 4.834581e+01 3.738573e-03 1.019992e+00 4.367746e-04 3.240088e+01 3.787231e-05 8.244081e-03 3.228039e-06 1.435692e+01 1.116214e-02 3.046525e+00 1.304611e-03;...
   4.781968e-01 6.166258e-08 3.980912e-05 3.730453e-09 4.605603e+01 2.863533e-03 3.634336e+00 5.967646e-04 1.785022e+01 2.301764e-05 1.650996e-02 1.547141e-06 1.700635e+01 1.068897e-02 1.366827e+01 2.245358e-03;...
   3.551504e-01 4.924128e-08 5.182104e-05 2.899538e-09 4.359525e+01 2.309833e-03 5.962063e+00 7.528814e-04 1.219452e+01 1.690761e-05 2.132061e-02 1.192983e-06 1.477043e+01 7.931149e-03 2.087685e+01 2.636308e-03;...
   2.528581e-01 3.870487e-08 6.174539e-05 1.982209e-09 3.875930e+01 2.119339e-03 1.038764e+01 1.042599e-03 6.914489e+00 1.058398e-05 2.236040e-02 7.178573e-07 1.041660e+01 5.795459e-03 2.974186e+01 2.985180e-03;...
   1.691451e-01 2.791016e-08 7.886500e-05 1.481445e-09 3.177653e+01 1.654116e-03 1.673076e+01 1.389771e-03 3.413058e+00 5.631391e-06 2.315106e-02 4.348981e-07 6.269752e+00 3.337821e-03 3.694253e+01 3.068734e-03;...
   1.168999e-01 2.023851e-08 7.606741e-05 9.639444e-10 2.596431e+01 1.521080e-03 2.206378e+01 1.594611e-03 1.884745e+00 3.262932e-06 1.895451e-02 2.402032e-07 4.081119e+00 2.452338e-03 4.067197e+01 2.939480e-03];

kk_g      = E(:,1);
kk_a1_cg  = E(:,2);
kk_a1_mtc = E(:,3);
kk_a1_cpm = E(:,4);   
kk_pm     = E(:,5);
kk_b1_cg  = E(:,6);
kk_b1_mtc = E(:,7);
kk_b1_cpm = E(:,8);
         
dd_g      = E(:,9);
dd_a1_cg  = E(:,10);
dd_a1_mtc = E(:,11);
dd_a1_cpm = E(:,12);      
dd_pm     = E(:,13);
dd_b1_cg  = E(:,14);
dd_b1_mtc = E(:,15);
dd_b1_cpm = E(:,16);

%######## MOtor protien ##########

figure(8);

subplot(3,3,1)
plot(v,kk_g,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Kinesin in G','FontSize',title_font_size);
ylim([0 max(kk_g)]);

subplot(3,3,2)
plot(v,kk_a1_cg ,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Kinesin with coat A in CG','FontSize',title_font_size);
ylim([0 max(kk_a1_cg)]);

subplot(3,3,3)
plot(v,kk_a1_mtc ,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Kinesin with coat A in MTU','FontSize',title_font_size);
ylim([0 max(kk_a1_mtc)]);

subplot(3,3,4)
plot(v,kk_a1_cpm ,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Kinesin with coat A in CPM','FontSize',title_font_size);
ylim([0 max(kk_a1_cpm)]);

subplot(3,3,5)
plot(v,kk_b1_cg,'-og','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Kinesin with coat B in CG','FontSize',title_font_size);
ylim([0 max(kk_b1_cg)]);

subplot(3,3,6)
plot(v,kk_b1_mtc ,'-og','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Kinesin with coat B in MTU','FontSize',title_font_size);
ylim([0 max(kk_b1_mtc)]);

subplot(3,3,7)
plot(v,kk_b1_cpm ,'-og','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Kinesin with coat B in CPM','FontSize',title_font_size);
ylim([0 max(kk_b1_cpm)]);

subplot(3,3,8)
plot(v,kk_pm ,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Kinesin in PM','FontSize',title_font_size);
ylim([0 max(kk_pm)]);


figure(9);

subplot(3,3,1)
plot(v,dd_g,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Dynein in G','FontSize',title_font_size);
ylim([0 max(dd_g)]);

subplot(3,3,2)
plot(v,dd_a1_cg ,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Dynein with coat A in CG','FontSize',title_font_size);
ylim([0 max(dd_a1_cg)]);

subplot(3,3,3)
plot(v,dd_a1_mtc ,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Dynein with coat A in MTU','FontSize',title_font_size);
ylim([0 max(dd_a1_mtc)]);

subplot(3,3,4)
plot(v,dd_a1_cpm ,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Dynein with coat A in CPM','FontSize',title_font_size);
ylim([0 max(dd_a1_cpm)]);

subplot(3,3,5)
plot(v,dd_b1_cg,'-og','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Dynein with coat B in CG','FontSize',title_font_size);
ylim([0 max(dd_b1_cg)]);

subplot(3,3,6)
plot(v,dd_b1_mtc ,'-og','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Dynein with coat B in MTU','FontSize',title_font_size);
ylim([0 max(dd_b1_mtc)]);

subplot(3,3,7)
plot(v,dd_b1_cpm ,'-og','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Dynein with coat B in CPM','FontSize',title_font_size);
ylim([0 max(dd_b1_cpm)]);

subplot(3,3,8)
plot(v,dd_pm ,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('Dynein in PM','FontSize',title_font_size);
ylim([0 max(dd_pm)]);

%%

C = [1.896625e-02 7.582532e-01 1.533251e-03 5.374113e-02 4.869799e-01 3.958031e-03;...
3.198052e-02 8.726221e+00 3.736801e-03 6.197222e-02 1.556709e+00 3.692200e-03;...
4.313089e-02 5.488911e+01 9.016846e-03 5.332900e-02 3.436736e+00 3.628786e-03;...
4.230502e-02 1.098706e+02 1.387432e-02 4.515101e-02 4.705579e+00 3.678539e-03;...
4.952028e-02 2.438793e+02 2.447798e-02 3.414524e-02 6.760658e+00 3.811372e-03;...
5.445164e-02 5.381329e+02 4.470086e-02 2.413177e-02 9.409140e+00 4.023398e-03;...
7.230092e-02 9.655836e+02 6.978438e-02 1.865052e-02 1.158793e+01 4.211589e-03];

nb1_CG    = C(:,1);
nb1_MTU   = C(:,2);
nb1_CPM   = C(:,3);
na2_CG    = C(:,4);
na2_MTU   = C(:,5);
na2_CPM   = C(:,6);

figure(3);

subplot(2,3,1)
plot(v,nb1_CG,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('nb1 in CBC','FontSize',title_font_size);
ylim([0 max(nb1_CG)]);

subplot(2,3,2)
plot(v,nb1_MTU,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('nb1 in MTU','FontSize',title_font_size);
ylim([0 max(nb1_MTU)]);

subplot(2,3,3)
plot(v,nb1_CPM,'-or','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('nb1 in GCC','FontSize',title_font_size);
ylim([0 max(nb1_CPM)]);
                                                     
subplot(2,3,4)
plot(v,na2_CG,'-og','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('na2 CBC','FontSize',title_font_size);
ylim([0 max(na2_CG)]);

subplot(2,3,5)
plot(v,na2_MTU,'-og','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('na2 in MTU','FontSize',title_font_size);
ylim([0 max(na2_MTU)]);

subplot(2,3,6)
plot(v,na2_CPM,'-og','LineWidth',LineWidth);
xlabel(xlabel_text,'FontSize',axis_label_fontSize); 
ylabel('Value','FontSize',axis_label_fontSize);
title('na2 GCC','FontSize',title_font_size);
ylim([0 max(na2_CPM)]);