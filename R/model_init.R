

new_sperry_model = function(){
    xyz = new("Sperry_Model")
    xyz@data = read.csv("inst/extdata/ex_data_short.csv")
    xyz@data$Jmax_optional = as.numeric(xyz@data$Jmax_optional)
    xyz@data$Vmax_optional = as.numeric(xyz@data$Vmax_optional)
    xyz@data$Lai_optional = as.numeric(xyz@data$Lai_optional)
    xyz@Parameters@gs_limits = read.csv("inst/extdata/ex_gs_limits.csv")
    return(xyz)
}
