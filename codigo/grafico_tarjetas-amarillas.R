require(tidyverse)
require(ggthemes)
library(stringr)

datos <- read_delim('datos/EPL_20_21.csv')

partidos_jugados <- cbind(datos, Name_Club = str_c(datos$Name,' (',datos$Club,')')) %>% 
  select(Name_Club, Matches) %>% 
  slice_max(order_by = Yellow_Cards, n = 10) %>% 
  slice_min(order_by = Yellow_Cards, n = nrow(tarjetas_amarillas))

tarjetas_amarillas %>% 
  ggplot(aes(Yellow_Cards, factor(Name_Club, levels = Name_Club))) +
  geom_col(fill = '#fbd976') +
  geom_text(aes(label = Yellow_Cards), hjust = -0.5) +
  labs(title = 'Jugadores con más tarjetas amarillas en la Premier League',
       subtitle = 'Temporada 2020/21',
       x = 'Tarjetas amarillas',
       y = NULL) +
  scale_x_continuous(limits = c(0,13), breaks = seq(0,13,2)) +
  theme_minimal()


ggsave('figuras/columna_tarjetas-amarillas.png', height = 7, width = 10)
