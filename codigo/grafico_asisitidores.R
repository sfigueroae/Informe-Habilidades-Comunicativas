require(tidyverse)
require(ggthemes)
library(stringr)

datos <- read_delim('datos/EPL_20_21.csv')

asistidores <- cbind(datos, Name_Club = str_c(datos$Name,' (',datos$Club,')')) %>% 
  select(Name_Club,Assists) %>% 
  slice_max(order_by = Assists, n = 10) %>% 
  slice_min(order_by = Assists, n = nrow(asistidores))

asistidores %>% 
  ggplot(aes(Assists, factor(Name_Club, levels = Name_Club))) +
  geom_col(fill = '#56f5b3') +
  geom_text(aes(label = Assists), hjust = -0.5) +
  labs(title = 'Máximos asistidores en la Premier League',
       subtitle = 'Temporada 2020/21',
       x = 'Asistencias',
       y = NULL) +
  scale_x_continuous(limits = c(0,13), breaks = seq(0,13,2)) +
  theme_minimal()

ggsave('figuras/columna_asistidores.png', height = 7, width = 10)
