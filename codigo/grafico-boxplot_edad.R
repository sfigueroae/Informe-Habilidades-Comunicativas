require(tidyverse)
require(ggthemes)
library(stringr)

datos <- read_delim('datos/EPL_20_21.csv')

edad <- datos %>% 
  mutate(menores = case_when(Age == 16 ~ 16))

edad %>% 
  ggplot(aes(Age, Club)) +
  geom_boxplot() +
  scale_x_continuous(limits = c(14, 40), breaks = seq(14,40,1)) +
  geom_vline(xintercept = mean(edad$Age), color = 'red', linetype="dashed") + 
  labs(title = 'Box plot edad de jugadores en la Premier League',
       subtitle = 'Temporada 2020/21',
       x = 'Edad',
       y = NULL) +
  theme_minimal()

ggsave('figuras/boxplot_edad.png', height = 7, width = 10)  


