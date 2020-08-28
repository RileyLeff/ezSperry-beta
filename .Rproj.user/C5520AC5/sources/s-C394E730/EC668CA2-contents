.phonebook = read.csv("~/Desktop/output_phonebook.csv")
.fff = function(x,y,z) list(cposition = x, units = y, description = z)
.cpos2 = purrr::pmap(list(.phonebook$cposition, .phonebook$units, .phonebook$description), .fff)

names(.cpos2) = .phonebook$label

rm(.phonebook)

.cpos2[[3]]$cposition = c(10,11,12,13,14)
.cpos2[[30]]$cposition = c(45,46,47,48,49)
.cpos2[[32]]$cposition = c(51,52,53,54,55)

sperrylookup = function(label, choice = "units"){
    if(!label %in% names(.cpos2)) {message("not in phonebook, check your spelling")
        stop()}
    x = which(names(.cpos2) == label)
    if(choice == "units" | choice == "unit") message(.cpos2[[x]]$units)
    else if(choice == "description") message(.cpos2[[x]]$description)}
