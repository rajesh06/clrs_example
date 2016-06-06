xtabs(formula = incur_loss ~ acc_yr + lag, data = model_dat)

clrs <- list(
  incur_tri = as.triangle(
    Triangle = model_dat %>% 
      dplyr::filter(dev_yr <= 1997), 
    origin = "acc_yr", dev = "lag", value = "incur_loss"),  
  paid_tri = as.triangle(
    Triangle = model_dat %>% 
      dplyr::filter(dev_yr <= 1997), 
    origin = "acc_yr", dev = "lag", value = "paid_loss"),
  data_df = model_dat[model_dat$lag == 10,
    c("acc_yr", "net_prem", "incur_loss", "paid_loss")],
  company_name = unique(model_dat$grname),
  val_date = as.Date('1997-12-31')
) 