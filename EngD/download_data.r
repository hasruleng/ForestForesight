# This code is to download data such as model, pre-processed data, and previous predicitions made by FF
# Alternatively, you can download those and other data using Cyberduck
# https://forestforesight.atlassian.net/wiki/spaces/EWS/pages/550535173/Downloading+Forest+Foresight+data

download_folder <- "C:/Kodingan3/FFdata/" #adjust this
# Choose an identifier (country code, tile ID, or SpatVector)
identifier <- "PER"  # this doesn't seem to work
# identifier <- shape # Or, use this if you want to download every country data 
# Call the ff_sync function
ff_sync(
  ff_folder = download_folder,
  identifier = identifier,
  download_model = TRUE, #prediction models
  download_data = TRUE, #pre-processed data
  download_predictions = TRUE, #disable this if you don't want to download previous prediction
  verbose = TRUE
)