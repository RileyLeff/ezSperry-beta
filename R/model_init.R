new_sperry_model <- function() {
  xyz <- new("Sperry_Model")
  xyz@data <- read.csv(system.file("extdata", "ex_data_short.csv", package = "ezsperry"))
  xyz@data$Jmax_optional <- as.numeric(xyz@data$Jmax_optional)
  xyz@data$Vmax_optional <- as.numeric(xyz@data$Vmax_optional)
  xyz@data$Lai_optional <- as.numeric(xyz@data$Lai_optional)
  xyz@Parameters@gs_limits <- read.csv(system.file("extdata", "ex_gs_limits.csv", package = "ezsperry"))
  return(xyz)
}

gen_model_update_string <- function(model, new_params) {
  modelname <- deparse(substitute(model))
  str_out <- paste(modelname, .param_lookup[names(new_params)], "<-", new_params, sep = "")
  return(str_out)
}

# new_sperry_model_from_toml <- function(path) {
#   input <- blogdown::read_toml(path)
#   temp_model <- new_sperry_model()
#   for(i in 1:length(input)){
#     name <- names(input)[i]
#     val <- input[[i]]

#   .gen_model_update_string(model = temp_model, )
#     # create a string of temp_model@ + names(input)[i] <- .param_lut[[names(input)[i]]]
# }

# I deserve to be jailed for update_parameter()
update_parameter <- function(model, path, new_value) {
  modelname <- deparse(substitute(model))
  expr_as_string <- paste(modelname, path, "<<-", new_value, sep = "")
  expr_parsed <- parse(text = expr_as_string)
  eval(expr_parsed)
}
