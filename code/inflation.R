setwd(dirdata)

ipc <- read_delim("ipc.csv", delim=";")

ipc <- ipc %>% mutate(IPC=IPC/100) %>%
          group_by(Year) %>%
          summarise(IPC = mean(IPC)) %>%
          mutate(inflation = last(IPC)/IPC)

ipc <- ipc %>% rename(year = Year) %>% select(year, inflation)
