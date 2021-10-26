run_sperry = function(model_obj, .dtt = deparse(substitute(model_obj)), bounce = FALSE, skinny = FALSE, nametag = "rileyiscool", returnNA = FALSE, returnnull = FALSE){

    riley_jmax_array = NA
    riley_vmax_array = NA
    riley_lai_array = NA
    riley_swc_array = NA
    riley_depth_array = NA
    riley_depth_array2 = NA
    riley_radius_array = NA
    riley_radius_array2 = NA

    if(model_obj@Parameters@Options@weibin_mode){
        riley_jmax_array = model_obj@data$Jmax_optional
        riley_vmax_array = model_obj@data$Vmax_optional
        riley_lai_array = model_obj@data$Lai_optional}

    if(model_obj@Parameters@Options@alex_mode){
        riley_swc_array = model_obj@Parameters@swc_optional}

    if(model_obj@Parameters@Options@depth_override){
        riley_depth_array = model_obj@Parameters@soil_layers$depths_optional
        riley_depth_array2 = c(0.02)
        riley_depth_array2[2:(length(riley_depth_array)+1)] = riley_depth_array

        if(length(riley_depth_array) > 1){
            for(i in 1:(length(riley_depth_array)-1)){
                if(riley_depth_array[i+1] < riley_depth_array[i]){
                    stop("Parameter Error: Soil layers must be arranged with lower depth decreasing from one layer to the next")
                }
            }
        }
    }

    if(model_obj@Parameters@Options@radius_override){
        riley_radius_array = model_obj@Parameters@soil_layers$radii_optional
        riley_radius_array2 = riley_radius_array[1]
        riley_radius_array2[2:(length(riley_radius_array)+1)] = riley_radius_array
    }

    nlayers = nrow(model_obj@Parameters@soil_layers)

    tagid = "spemo"
    if(!is.na(nametag)){
        if(nametag == "id"){tagid = model_obj@Parameters@Options@id}
        else if(nametag == "tag"){tagid = model_obj@Parameters@Options@tag}
        else if(is.character(nametag) & !is.na(nametag)){tagid = nametag}}

    riyc = length(unique(model_obj@data$Year))
    rinr = nrow(model_obj@data)
    print("help")
    runit2(model_obj, riley_jmax_array, riley_vmax_array, riley_lai_array, riley_swc_array, riley_depth_array2, riley_radius_array2, nlayers, tagid, riyc, rinr)
    print("hello")
    xxx = as.data.frame(model_obj@Outputs@timesteps[1:42])
    xxx$psiroot_layers = model_obj@Outputs@timesteps$fuckpl
    xxx$kroot_layers = model_obj@Outputs@timesteps$fuckkl
    xxx$eroot_layers = model_obj@Outputs@timesteps$fuckel
    xxx$posi = as.POSIXct(x = paste(model_obj@data$Day, model_obj@data$Year, model_obj@data$Hour, sep = ":"), format = "%j:%Y:%H")
    return(xxx)
    eval(parse(text = paste(model_obj,"@Outputs@timesteps <<- xxx")))

    if(bounce){
        if(skinny){
            return(model_obj@Outputs@timesteps)
        } else{
        return(xxx)
        }
    }
    if(returnNA){
        return(NA)
    }
    if(returnnull){
        return(NULL)
    }
}
