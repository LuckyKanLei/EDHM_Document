Process_list <- c('ReferenceET',
                  'ActualET',
                  'SNOW',
                  'BASEFLOW',
                  'INTERCEPTION',
                  'InfiltratRat',
                  'Infiltration',
                  'RUNOFF',
                  'GROUNDWATER',
                  'ROUTE')
Module_list <- map(Process_list, function(m) as.character(methods(m)))
names(Module_list) <- Process_list

Module_list$ROUTE <- c("ROUTE.G2RES", "ROUTE.Gr4j")



write_Rmd_Module <- function(module_name, file_name){
  string001 = 'This Module reference to the Literature: `r Data_'
  string002 = '$ref_title` [@`r Data_'
  string003 = '$ref_bib`].\n'
  string01 = 'n_In <- as.numeric(map(Data_'
  string02 = '$InData, length))\n'
  string03 = 'Group_Name <- reduce(map2(names(Data_'
  string04 = '$InData), n_In, rep), c)\n'
  string05 = 'Variable_Name <- reduce(map(Data_'
  string06 = '$InData, names), c)\n'
  string30 = 'Unit_ <- as.character(map2(Group_Name, Variable_Name, function(a, b) Unit_dataset[[a]][[b]]))\n'
  string31 = 'Des_ <- as.character(map2(Group_Name, Variable_Name, function(a, b) Des_dataset[[a]][[b]]))\n'
  string07 = 'In_'
  string08 = ' <- data.frame(Group = Group_Name, Variable = Variable_Name, Unit = Unit_, Description = Des_)\n'
  string11 = 'P_Name <- names(Data_'
  string12 = '$Param)\n'
  string13 = 'P_min <- as.numeric(map(Data_'
  string14 = '$Param, function(a) a[1]))\n'
  string15 = 'P_max <- as.numeric(map(Data_'
  string16 = '$Param, function(a) a[2]))\n'
  string161 = 'P_unit <- as.character(map(Data_'
  string162 = '$Param, function(a) a[3]))\n'
  string163 = 'P_des <- as.character(map(Data_'
  string164 = '$Param, function(a) a[4]))\n'
  string17 = 'P_'
  string18 = ' <- data.frame(Paramter = P_Name, Min = P_min, Max = P_max, Unit = P_unit, Description = P_des)\n'
  string21 = 'n_Out <- as.numeric(map(Data_'
  string22 = '$OutData, length))\n'
  string23 = 'Group_Name <- reduce(map2(names(Data_'
  string24 = '$OutData), n_Out, rep), c)\n'
  string25 = 'Variable_Name <- reduce(map(Data_'
  string26 = '$OutData, names), c)\n'
  string27 = 'Out_'
  string28 = ' <- data.frame(Group = Group_Name, Variable = Variable_Name, Unit = Unit_, Description = Des_)\n'
  string0 = '```{r t_'
  string1 = ', echo = FALSE}\n'
  string2 = 'kable('
  string3 = ', caption = \''
  # string4 = '\', row.names = F) %>% collapse_rows(1) %>% kable_styling(latex_options = \"hold_position\")\n'
  string4 = ', row.names = F) %>% collapse_rows(1) %>% kable_styling(latex_options = \"hold_position\")\n'
  string5 = '```\n\n'

  string <- paste0('### ', module_name, '\n\n',
                   string001, module_name, string002, module_name, string003, '\n',
                   '***InData***\n\n',
         string0, string07, module_name, string1,
         string01, module_name, string02,
         string03, module_name, string04,
         string05, module_name, string06,
         string30, string31,
         string07, module_name, string08,
         string11, module_name, string12,
         string13, module_name, string14,
         string15, module_name, string16,
         string161, module_name, string162,
         string163, module_name, string164,
         string17, module_name, string18,
         string21, module_name, string22,
         string23, module_name, string24,
         string25, module_name, string26,
         string30, string31,
         string27, module_name, string28,
         string2, string07, module_name, string4,
         string5,
         '***Param***\n\n',
         string0, string17, module_name, string1,
         string2, string17, module_name, string4,
         string5,
         '***OutData***\n\n',
         string0, string27, module_name, string1,
         string2, string27, module_name, string4,
         string5)
  write(string, file = file_name, append = T)
}

write_Rmd_Process <- function(process_name, Module_list, file_name){
  string <- paste0('## ', process_name, '\n')
  write(string, file = file_name, append = T)
  Module_name <- Module_list[[process_name]]
  map(Module_name, write_Rmd_Module, file_name = file_name)
}
write_Rmd_Module_all <- function(Process_list, Module_list, file_name){
   write('# Modules {#module}\n', file_name)
   map(Process_list, write_Rmd_Process, Module_list, file_name)
}
write_Rmd_Module_all(Process_list, Module_list, '03-module.Rmd')



