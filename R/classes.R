# the ceo of carpal tunnel called, he said I can't have my fingers back

################################
##### PARAMETERS #####
################################

#####
# WEIBULL #
#####

weib_df <- data.frame(
  rowname = c("weibull_b", "weibull_c", "pct_resist_at_ksat"),
  root = c(1.17, .96, NA), stem = c(3.21, 1.4, NA),
  leaf = c(3.21, 1.4, 35.053)
)

#####
# PLANT
#####
setClass("Plant", representation(
  plant_kmax = "numeric",
  height = "numeric", la_to_ba = "numeric", leaf_width = "numeric", avg_p_rhizo_r = "numeric",
  root_aspect_r = "numeric", root_beta = "numeric"
), prototype(
  plant_kmax = 415.66, height = 8.78, la_to_ba = 977.8, leaf_width = .04096, avg_p_rhizo_r = 50, root_aspect_r = 1,
  root_beta = .98
))

#####
# STAND
#####
setClass("Stand", representation(
  latitude = "numeric", longitude = "numeric",
  slope_inc = "numeric", slope_aspect = "numeric", leaf_angle_p = "numeric",
  canopy_lai = "numeric", height_above_soil = "numeric", site_elevation = "numeric",
  solar_noon_corr = "numeric", ba_to_ga = "numeric"
), prototype(
  latitude = 40.79,
  longitude = -105.572222, slope_inc = 0, slope_aspect = 270, leaf_angle_p = 1,
  canopy_lai = .379, height_above_soil = 1, site_elevation = 2504, solar_noon_corr = -.39,
  ba_to_ga = 25
))

#####
# SOIL
#####
# layers
soillayerdf <- data.frame(
  vg_a = c(765.3075, 765.3075, 765.3075, 765.3075, 765.3075),
  vg_n = c(1.89, 1.89, 1.89, 1.89, 1.89),
  ksat = c(4510.168, 4510.168, 4510.168, 4510.168, 4510.168),
  theta_sat = c(.41, .41, .41, .41, .41),
  depths_optional = c(.2, .5, .7, 1.2, 1.5),
  radii_optional = c(1, 2, 3, 4, 5)
)
# params
setClass(
  "Soil", representation(
    field_cap_frac = "numeric",
    init_p_field_cap = "numeric", rock_fraction = "numeric", soil_abs = "numeric",
    tlai_to_plai = "numeric", p_inc = "numeric"
  ),
  prototype(
    field_cap_frac = .5, init_p_field_cap = 100, rock_fraction = 0,
    soil_abs = .94, tlai_to_plai = 3.82, p_inc = .00075
  )
)

#####
# ATMOSPHERE
#####
setClass("Atmosphere", representation(
  sky_emiss = "numeric", atm_trans = "numeric",
  o2_mol_frac = "numeric"
), prototype(
  sky_emiss = .97, atm_trans = .69,
  o2_mol_frac = .21
))

#####
# PHOTOSYNTHESIS
#####
setClass("Photosynthesis", representation(
  atm_co2_pa = "numeric", atm_co2_ppm = "numeric", quantum_yield_e_t = "numeric",
  vmax = "numeric", jmax = "numeric", kc = "numeric", ko = "numeric", comp_point = "numeric", theta = "numeric",
  ha_vmax = "numeric", hd_vmax = "numeric", sv_vmax = "numeric", curv_light_resp = "numeric", light_comp = "numeric",
  ha_jmax = "numeric", hd_jmax = "numeric", sv_jmax = "numeric"
), prototype(
  atm_co2_pa = 28.173, atm_co2_ppm = 354.8,
  quantum_yield_e_t = 0.3, vmax = 56.715, jmax = 94.714, kc = 0.0004048, ko = 0.278331, comp_point = 0.00004275,
  theta = .98, "ha_vmax" = 73637, hd_vmax = 149252, sv_vmax = 486, curv_light_resp = .9, light_comp = 30,
  ha_jmax = 50300, hd_jmax = 152044, sv_jmax = 495
))

#####
# OPTIONS
#####
setClass("Options", representation(
  gw_p = "numeric", gw_d = "numeric", gw = "logical", early_kill_plc = "numeric",
  soil_redist = "logical", soil_evap = "logical", refilling = "logical", rain = "logical", use_gs_data = "logical", weibin_mode = "logical", alex_mode = "logical", depth_override = "logical", radius_override = "logical", soil_verbose = "logical", tag = "character", id = "numeric"
), prototype(
  gw_p = 0,
  gw_d = 1, gw = FALSE, early_kill_plc = 101, soil_redist = FALSE, soil_evap = FALSE, refilling = FALSE, rain = FALSE, use_gs_data = FALSE, weibin_mode = FALSE, alex_mode = FALSE, depth_override = FALSE, radius_override = FALSE, soil_verbose = FALSE, tag = NA_character_, id = NA_real_
))


#####
# GS LIMS
#####

gslimproto <- data.frame(Year = c(1971, 1972), Day_start = c(145, 142), Day_end = c(267, 268))

#####
# PARAMETER PARENT #
#####
setClass(
  "Sperry_Parameters",
  representation(
    weibull = "data.frame", Plant = "Plant", Stand = "Stand",
    Soil = "Soil", Photosynthesis = "Photosynthesis", Atmospheric = "Atmosphere",
    Options = "Options", gs_limits = "data.frame", soil_layers = "data.frame", swc_optional = "list"
  ), prototype(
    weibull = weib_df,
    gs_limits = gslimproto, soil_layers = soillayerdf, swc_optional = list()
  )
)



################################
##### DATA #####
################################


sp_data_df_ <- data.frame()



################################
##### OUTPUT/CONSTRAINTS #####
################################


#####
# OUTPUT PARENT
#####
setClass("Sperry_Output", representation(
    summary = "data.frame", 
    timesteps = "data.frame",
    misc_testing = "data.frame"
    )
)



################################
##### PARENT #####
################################

#####
# MODEL PARENT
#####
setClass("Sperry_Model", representation(
  Parameters = "Sperry_Parameters", data = "data.frame",
  Outputs = "Sperry_Output"
), prototype(data = sp_data_df_))
