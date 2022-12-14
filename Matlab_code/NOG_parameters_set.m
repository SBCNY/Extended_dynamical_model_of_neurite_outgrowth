NOG_parameters_set_general;
if       (anticipated_backwardFlux_a2_mtc_into_cg == 0.25)...
       &&(anticipated_fraction_bound_nb1_mtc      == 0.10)
           NOG_parameters_set_backwardFlux025_fraction010_velocity000;
elseif   (anticipated_backwardFlux_a2_mtc_into_cg == 0.25)...
       &&(anticipated_fraction_bound_nb1_mtc      == 0.25)
           NOG_parameters_set_backwardFlux025_fraction025_velocity000;
elseif   (anticipated_backwardFlux_a2_mtc_into_cg == 0.25)...
       &&(anticipated_fraction_bound_nb1_mtc      == 0.5)
           NOG_parameters_set_backwardFlux025_fraction050_velocity000;
elseif   (anticipated_backwardFlux_a2_mtc_into_cg == 0.25)...
       &&(anticipated_fraction_bound_nb1_mtc      == 0.75)
           NOG_parameters_set_backwardFlux025_fraction075_velocity000;
elseif   (anticipated_backwardFlux_a2_mtc_into_cg == 0.25)...
       &&(anticipated_fraction_bound_nb1_mtc      == 0.9)
           NOG_parameters_set_backwardFlux025_fraction090_velocity000;
    ...
elseif   (anticipated_backwardFlux_a2_mtc_into_cg == 0.50)...
       &&(anticipated_fraction_bound_nb1_mtc      == 0.10)
           NOG_parameters_set_backwardFlux050_fraction010_velocity000;
elseif   (anticipated_backwardFlux_a2_mtc_into_cg == 0.50)...
       &&(anticipated_fraction_bound_nb1_mtc      == 0.25)
           NOG_parameters_set_backwardFlux050_fraction025_velocity000;
elseif   (anticipated_backwardFlux_a2_mtc_into_cg == 0.50)...
       &&(anticipated_fraction_bound_nb1_mtc      == 0.50)
           NOG_parameters_set_backwardFlux050_fraction050_velocity000;
elseif   (anticipated_backwardFlux_a2_mtc_into_cg == 0.50)...
       &&(anticipated_fraction_bound_nb1_mtc      == 0.75)
           NOG_parameters_set_backwardFlux050_fraction075_velocity000;
elseif   (anticipated_backwardFlux_a2_mtc_into_cg == 0.50)...
       &&(anticipated_fraction_bound_nb1_mtc      == 0.90)
           NOG_parameters_set_backwardFlux050_fraction090_velocity000;
    ...
elseif   (anticipated_backwardFlux_a2_mtc_into_cg == 0.75)...
       &&(anticipated_fraction_bound_nb1_mtc      == 0.10)
           NOG_parameters_set_backwardFlux075_fraction010_velocity000;
elseif   (anticipated_backwardFlux_a2_mtc_into_cg == 0.75)...
       &&(anticipated_fraction_bound_nb1_mtc      == 0.25)
           NOG_parameters_set_backwardFlux075_fraction025_velocity000;
elseif   (anticipated_backwardFlux_a2_mtc_into_cg == 0.75)...
       &&(anticipated_fraction_bound_nb1_mtc      == 0.50)
           NOG_parameters_set_backwardFlux075_fraction050_velocity000;
elseif   (anticipated_backwardFlux_a2_mtc_into_cg == 0.75)...
       &&(anticipated_fraction_bound_nb1_mtc      == 0.75)
           NOG_parameters_set_backwardFlux075_fraction075_velocity000;
elseif   (anticipated_backwardFlux_a2_mtc_into_cg == 0.75)...
       &&(anticipated_fraction_bound_nb1_mtc      == 0.90)
           NOG_parameters_set_backwardFlux075_fraction090_velocity000;
...
elseif   (anticipated_backwardFlux_a2_mtc_into_cg == 1)...
       &&(anticipated_fraction_bound_nb1_mtc      == 0.10)
           NOG_parameters_set_backwardFlux100_fraction010_velocity000;
elseif   (anticipated_backwardFlux_a2_mtc_into_cg == 1)...
       &&(anticipated_fraction_bound_nb1_mtc      == 0.25)
           NOG_parameters_set_backwardFlux100_fraction025_velocity000;
elseif   (anticipated_backwardFlux_a2_mtc_into_cg == 1)...
       &&(anticipated_fraction_bound_nb1_mtc      == 0.50)
           NOG_parameters_set_backwardFlux100_fraction050_velocity000;
elseif   (anticipated_backwardFlux_a2_mtc_into_cg == 1)...
       &&(anticipated_fraction_bound_nb1_mtc      == 0.75)
           NOG_parameters_set_backwardFlux100_fraction075_velocity000;
elseif   (anticipated_backwardFlux_a2_mtc_into_cg == 1)...
       &&(anticipated_fraction_bound_nb1_mtc      == 0.90)
           NOG_parameters_set_backwardFlux100_fraction090_velocity000;
...
else
    ME = MException('No such combination', ...
        'Combinatino is not considered');
    throw(ME)
end

