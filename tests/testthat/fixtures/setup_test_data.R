.path_to_raw_test_data <- here::here("tests", "testthat", "fixtures", "test_data_raw")

.path_to_write_test_data <- here::here("tests", "testthat", "fixtures", "test_data")

.test_dataset_names <- list(
    ".data_long" = "data_long.csv",
    ".data_short" = "data_short.csv",
    ".gs_limits" = "gs_limits.csv"
)

.test_full_raw_paths <- fs::path(.path_to_raw_test_data, .test_dataset_names)

names(.test_full_raw_paths) <- names(.test_dataset_names)

.test_data <- lapply(.test_full_raw_paths, read.csv)

.test_write_paths <- fs::path(.test_data_write_path, names(.test_raw_datasets), ext = "rds")

for(i in 1:length(.test_data)) saveRDS(.test_data[[i]], .test_write_paths[i])


