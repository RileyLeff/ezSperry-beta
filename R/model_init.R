


new_sperry_model = function(){
    xyz = new("Sperry_Model")
    xyz@data = read.csv(system.file("extdata", "ex_data_short.csv", package = "ezsperry"))
    xyz@data$Jmax_optional = as.numeric(xyz@data$Jmax_optional)
    xyz@data$Vmax_optional = as.numeric(xyz@data$Vmax_optional)
    xyz@data$Lai_optional = as.numeric(xyz@data$Lai_optional)
    xyz@Parameters@gs_limits = read.csv(system.file("extdata", "ex_gs_limits.csv", package = "ezsperry"))
    return(xyz)
}
