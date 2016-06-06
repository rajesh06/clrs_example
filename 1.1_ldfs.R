ldfs <- ata(clrs$paid_tri)

plot_dat <- as.matrix(ldfs) %>%
  unclass() %>%
  as.data.frame()

plot_dat$acc_yr <- rownames(plot_dat)
plot_dat  %<>%  tidyr::gather("interval", "ldf", 1:9) %>%
  dplyr::filter(!is.na(ldf))

