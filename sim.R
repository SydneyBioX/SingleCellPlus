library(scMerge)
library(purrr)
library(furrr)

plan(multicore, workers = 5)
set.seed(1234)
nCells = c(100, 200, 500, 1000, 2000, 5000)

listSim = purrr::map(.x = nCells, 
                     .f = ~ scMerge::ruvSimulate(m = .x, n = 20000, lambda = 5, sce = TRUE))

list_scMerge = furrr::future_map(
  .x = listSim,
  .f = ~ scMerge::scMerge(sce_combine = .x,
                   ctl = paste0('gene', 1:500),
                   cell_type = .x$cellTypes,
                   ruvK = 10, assay_name = "scMerge_sim"),
  .progress = TRUE)

list_scMerge_fast = furrr::future_map(
  .x = listSim,
  .f = ~ scMerge::scMerge(sce_combine = .x,
                          ctl = paste0('gene', 1:500),
                          cell_type = .x$cellTypes,
                          ruvK = 10, assay_name = "scMerge_sim", fast_svd = TRUE),
  .progress = TRUE)

