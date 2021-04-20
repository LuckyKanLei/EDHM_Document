library(HMtools)
library(EDHM)
library(knitr)
library(kableExtra)
library(purrr)
library(bookdown)
write_Rmd_Group <- function(group_name, file_name){
  string1 = '```{r t_G_'
  string2 = ', echo = FALSE}
Gr_name <- \''
  string3 = '\'
Variable_Name <- names(Pre_dataset[[Gr_name]])
Unit_ <- as.character(map(Variable_Name, function(b) Unit_dataset[[Gr_name]][[b]]))
Des_ <- as.character(map(Variable_Name, function(b) Des_dataset[[Gr_name]][[b]]))
df_Group <- data.frame(Variable = Variable_Name, Unit = Unit_, Description = Des_)
kable(df_Group, row.names = F) %>% collapse_rows(1) %>% kable_styling(latex_options = "hold_position")
```\n\n'
  string <- paste0(string1, group_name, string2, group_name, string3)
  write(string, file = file_name, append = T)
}
map(names(Pre_dataset), write_Rmd_Group, file_name = 'temp.Rmd')
