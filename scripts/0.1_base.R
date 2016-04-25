# Copyright statement comment
# ------------------------------------------------------------------------------
## Copyright 2016 Casualty Actuarial Society

# ------------------------------------------------------------------------------  

##  
## Rajesh Sahasrabuddhe (rajesh.sahasrabuddhe@oliverwyman.com)
## Brian Fannin BFannin@redwoodsgroup.com
## Ran Li <ril5077@gmail.com>



# source() and library() statements
# ------------------------------------------------------------------------------
library(readxl)
library(magrittr)
library(ggplot2)
library(scales)
library(dplyr)
library(actuar)
library(ChainLadder)
library(tidyr)
library(devtools)
library(lubridate)
library(testthat)
library(data.table)
library(gridExtra)
library(mixtools)

# Function definitions
# -----------------------------------------------------------------------------


# Executed statements
# -----------------------------------------------------------------------------

auto_dat_cas <- 'http://www.casact.org/research/reserve_data/ppauto_pos.csv'
auto_dat <- read.csv(file = auto_dat_cas) %>% 
  tbl_df()

## Rename variables
names(auto_dat)[names(auto_dat) == 'AccidentYear'] <- 'acc_yr'
names(auto_dat)[names(auto_dat) == 'DevelopmentYear'] <- 'dev_yr'
names(auto_dat)[names(auto_dat) == 'DevelopmentLag'] <- 'lag'
names(auto_dat)[names(auto_dat) == 'IncurLoss_B'] <- 'incur_loss'
names(auto_dat)[names(auto_dat) == 'CumPaidLoss_B'] <- 'paid_loss'
names(auto_dat)[names(auto_dat) == 'BulkLoss_B'] <- 'bulk_loss'
names(auto_dat)[names(auto_dat) == 'EarnedPremDIR_B'] <- 'dir_prem'
names(auto_dat)[names(auto_dat) == 'EarnedPremCeded_B'] <- 'ceded_prem'
names(auto_dat)[names(auto_dat) == 'EarnedPremNet_B'] <- 'net_prem'
names(auto_dat)[names(auto_dat) == 'PostedReserve97_B'] <- 'posted_reserve'
names(auto_dat) <- tolower(names(auto_dat))

table(auto_dat$acc_yr, auto_dat$lag)

## Average Lag 10 Premium

summary_dat <- auto_dat %>% 
  dplyr::filter(lag == 10) %>% 
  dplyr::group_by(grname) %>% 
  dplyr::summarise(mean_loss = mean(incur_loss)) 

barplot(height = summary_dat$mean_loss, horiz = TRUE)

summary_dat$grname[which(summary_dat$mean_loss > 200000)]

model_dat <- auto_dat %>% 
  dplyr::filter(grname == 'State Farm Mut Grp')
