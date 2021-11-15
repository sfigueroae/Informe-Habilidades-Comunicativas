require(tidyverse)
require(ggthemes)

datos <- read_delim('datos/EPL_20_21.csv')

goles_equipos <- select(datos, Club, Goals)  %>% 
  group_by(Club) %>% 
  summarise(Goals_club = sum(Goals)) %>% 
  slice_min(order_by = Goals_club, n = 20) %>% 
  mutate(highlight = ifelse(Club == 'Manchester City',T,F)) %>% 
  mutate(resultado = case_when(
    Club == 'Manchester City' ~ 'Campeon',
    Club == 'Sheffield United' ~ 'Descendido',
    Club == 'West Bromwich Albion' ~ 'Descendido',
    Club == 'Fulham' ~ 'Descendido'
  ))
  
goles_equipos %>% 
  ggplot(aes(Goals_club, factor(Club, levels = Club))) +
  geom_col(aes(fill = resultado), width = 0.7) +
  geom_text(aes(label = Goals_club), hjust = -0.5) +
  geom_text(aes(label = resultado), hjust = -0.5) +
  scale_color_colorblind() +
  labs(title = 'Total de goles por equipo en la Premier League',
       subtitle = 'Temporada 2020/21',
       x = 'Goles',
       y = NULL) +
  scale_x_continuous(limits = c(0,90), breaks = seq(0,80,10)) +
  theme_minimal() +
  theme(legend.position = 'none') 

ggsave('figuras/columna_goles-equipos.png', height = 7, width = 10)  

total_goles_liga <- sum(datos$Goals); total_goles_liga
