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

## how the wrapper works

Calling `new_sperry_model()` instantiates a custom S4 object that contains parameters, input data, and an empty slot for outputs.

Calling `run_sperry()` parses the inputs and parameters, then passes them to John Sperry's C program. This program has been lightly modified to accept R Objects as inputs. After the model runs in C, it captures the outputs and brings 'em back over to R.


## Sperry_Model S4 Object Structure

Riley needs to put info about how the S4 object is organized here. 

The slot @data contains a dataframe, with columns as follows:
| column name   | what it is                      | unit                | data type | optional? | notes                                                                                                                               |
|---------------|---------------------------------|---------------------|-----------|-----------|-------------------------------------------------------------------------------------------------------------------------------------|
| Year          | year                            | years               | int       | no        | i.e. 1997                                                                                                                           |
| Day           | day of year                     | days                | int       | no        | i.e. Feb 19th = 50                                                                                                                  |
| Hour          | hour of day                     | hours               | int       | no        | i.e. 3pm = 15                                                                                                                       |
| Solar         | solar radiation                 | W/square meter      | float     | no        |                                                                                                                                     |
| Rain          | total rainfall in last hour     | mm                  | float     | yes       | inclusion can be switched on/off in @Parameters@Options                                                                             |
| Wind          | average hourly wind speed       | meters/second       | float     | no        | height of wind measurement set in @Parameters@Stand@height_above_soil                                                               |
| Tair          | average hourly air temperature  | celsius             | float     | no        |                                                                                                                                     |
| Tsoil         | average hourly soil temperature | celsius             | float     | no        |                                                                                                                                     |
| D             | vapor pressure deficit          | MD (kPa)            | float     | no        |                                                                                                                                     |
| Jmax_optional | hourly measurements of jmax     | umol m-2 s-1 at 25C | float     | yes       | overrides model's internal jmax calculation, overrides temperature effects on jmax. requires @Parameters@Options@weibin_mode = TRUE |
| Vmax_optional | hourly measurements of vmax     | umol m-2 s-1 at 25C | float     | yes       | overrides model's internal vmax calculation, overrides temperature effects on vmax. requires @Parameters@Options@weibin_mode = TRUE |
| Lai_optional  | hourly measurements of LAI      | dimless             | float     | yes       | overrides model's internal LAI calculation. requires @Parameters@Options@weibin_mode = TRUE                                         |
| Swc_optional  | hourly measurements of SWC      | dimless             | float     | yes       | overrides model's internal soil water content calculation. requires @Parameters@Options@alex_mode = TRUE                            |

It's getting late, I'll add the Params & Output descriptions tomorrow, sorry for the delay.


## how the model works

See the paper(s) linked at the top