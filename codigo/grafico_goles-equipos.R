require(tidyverse)

datos <- read_delim('datos/EPL_20_21.csv')

goles_equipos <- select(datos, Club, Goals)  %>% 
  group_by(Club) %>% 
  summarise(Goals_club = sum(Goals)) %>% 
  slice_min(order_by = Goals_club, n = 20)

goles_equipos %>% 
  ggplot(aes(Goals_club, factor(Club, levels = Club))) +
  geom_col(fill = '#317873', width = 0.7) +
  geom_text(aes(label = Goals_club), hjust = -0.5) +
  labs(title = 'Total de goles por equipo en la Premier League',
       subtitle = 'Temporada 2020/21',
       x = 'Goles',
       y = NULL) 

ggsave('figuras/columna_goles-equipos.png', height = 7, width = 10)  
