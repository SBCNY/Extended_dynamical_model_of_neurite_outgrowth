
%If run without MTs to speed up the simulation time
%d_effective_tubulin = 0;
%d_stbl_MTs_length = 0;
%d_dyn_MTs = 0;

%otherwise
 x = effective_tubulin;
 scale = scale_initial_a * exp(scale_exp_a*x) + scale_initial_b * exp(scale_exp_b*x);
 shape = shape_m * x + shape_b;
 
 d_effective_tubulin = 0;
 
 average_dynMT_length = scale * shape;
 d_stbl_MTs_length = stabilization_rate * dyn_MTs * average_dynMT_length;
 
 degradation_rate = dynMT_degradation_multiplier_a * x^dynMT_degradation_exp_b;
 
 d_dyn_MTs = nucleation_rate - stabilization_rate * dyn_MTs - degradation_rate * dyn_MTs; 
 dyn_MTs_length = dyn_MTs * average_dynMT_length;
 MTU_length = (stbl_MTs_length + dyn_MTs_length)/MTs_per_crosssection;

neurite_shaft_length = s3 / (2 * pi * radius_neurite);

% if (  ((MTU_length/neurite_shaft_length) > 1.05)...
%     ||((MTU_length/neurite_shaft_length) < 0.97))
%     ME = MException('see above' ); throw(ME)
% end

if with_MTC_growth
    MTU_length_app = neurite_shaft_length; 
else
    MTU_length_app = MTC_length_at_start; 
end

MTU_in_cpm_length = growth_cone_length;
MTU_in_cg_length = cg_length;
