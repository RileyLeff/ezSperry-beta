# ezsperry

This package is an R wrapper around the C version of Sperry's stomatal optimization model, found in [this 2017 paper](https://doi.org/10.1111/pce.12852) and [this 2019 paper](https://doi.org/10.1073/pnas.1913072116), among others.


## installation

`devtools::install_github("rileyleff/ezSperry-beta")`


## import

`library("ezsperry")`

## quickstart examples

Run with defaults:

```{r} 
# import the package
library(ezsperry)

# create new model with default parameters and data
foo = new_sperry_model()

# run the model and save output to a variable
bar = run_sperry(foo)

# take a gander at the outputs
plot(bar$posi, bar$tree_e, t = "l")
```

Run with custom params:

```{r}
library(ezsperry)
foo = new_sperry_model()
foo@Parameters@Photosynthesis@jmax = 110
foo@Parameters@Photsynthesis@vmax = 60
foo@Parameters@weibull[1,'root'] = 1.25 # "b" parameter in weibull curve for root tissue
foo@Parameters@Options@rain = TRUE
bar = run_sperry(foo)
```

Inspect data/params:
```{r}
library(ezsperry)
foo = new_sperry_model()
str(foo)
```
