require(tidyverse)
require(ggthemes)
library(stringr)

datos <- read_delim('datos/EPL_20_21.csv')

goleadores <- cbind(datos, Name_Club = str_c(datos$Name,' (',datos$Club,')')) %>% 
  select(Name_Club, Goals) %>% 
  slice_max(order_by = Goals, n = 10) %>% 
  slice_min(order_by = Goals, n = nrow(goleadores))

goleadores %>% 
  ggplot(aes(Goals, factor(Name_Club, levels = Name_Club))) +
  geom_col(fill = '#6cace6') +
  geom_text(aes(label = Goals), hjust = -0.5) +
  labs(title = 'Diez máximos goleadores en la Premier League',
       subtitle = 'Temporada 2020/21',
       x = 'Goles',
       y = NULL) +
  theme_minimal()

ggsave('figuras/columna_goleadores.png', height = 7, width = 10)
