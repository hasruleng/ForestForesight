library(ForestForesight)
library(sf)

data("countries")
ff_folder = "C:/Kodingan3/FFdata"
proc_dates <- "2024-09-01"
countrynames = countries$iso3

for (proc_date in proc_dates) {
  for (x in seq_along(countrynames)) {
    if (country == "COL") {
      country <- countrynames[x]
      cat(paste("processing", country, "\n"))
      setwd("C:/Kodingan3/FFdata/storage/predictions/")
      if (!dir.exists(country)) { dir.create(country) }
      setwd(country)
      if (!file.exists(paste0(country, "_", proc_date, ".tif"))) {
        cat(paste("processing", country, "for", proc_date, "\n"))
        if (!(country %in% countries$iso3)) { #added this checking
          message(paste("Country", country, "not found in countries$iso3"))
          next
        }
        shape <- terra::vect(countries[countries$iso3 == country, ])
        modelname <- countries$group[countries$iso3 == country]
        modelpath <- file.path(ff_folder, "models", modelname, paste0(modelname, ".model"))
        if (!file.exists(modelpath)) { stop(paste(modelpath, "does not exist")) }
        tryCatch({
          b <- ff_run(shape = shape,
                      prediction_dates = proc_date,
                      ff_folder = ff_folder,
                      verbose = TRUE,
                      trained_model = modelpath)
          terra::writeRaster(b, paste0(country, "_", proc_date, ".tif"), overwrite = T)
        }, error = function(e) {
          message("An error occurred: ", e$message)
        })
      }
    }
  }
}

