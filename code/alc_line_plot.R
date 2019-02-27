
library(tidyverse)
library(patchwork)

# import ------------------------------------------------------------------

mj <- read_csv("../data/MJ_proportions.csv") %>% 
  mutate(age = as.factor(age))

us <- mj %>% 
  filter(state == "us", drug == "alcohol")

# plots -------------------------------------------------------------------

co <- mj %>% 
  filter(state == "colorado", drug == "alcohol") %>% 
  ggplot(aes(x = year, y = percent, color = age)) + 
  geom_smooth() + 
  geom_line(data = us, linetype = "dashed") + 
  labs(title = "Colorado") + 
  theme_minimal() + 
  theme(text = element_text(family = "Roboto Condensed")) 

wash <- mj %>% 
  filter(state == "wash", drug == "alcohol") %>% 
  ggplot(aes(x = year, y = percent, color = age)) + 
  geom_smooth() + 
  geom_line(data = us, linetype = "dashed") + 
  labs(title = "Washington") + 
  theme_minimal() + 
  theme(text = element_text(family = "Roboto Condensed")) 

or <- mj %>% 
  filter(state == "oregon", drug == "alcohol") %>% 
  ggplot(aes(x = year, y = percent, color = age)) + 
  geom_smooth() + 
  geom_line(data = us, linetype = "dashed") + 
  labs(title = "Oregon") + 
  theme_minimal() + 
  theme(text = element_text(family = "Roboto Condensed")) 

ak <- mj %>% 
  filter(state == "alaska", drug == "alcohol") %>% 
  ggplot(aes(x = year, y = percent, color = age)) + 
  geom_smooth() + 
  geom_line(data = us, linetype = "dashed") + 
  labs(title = "Alaksa") + 
  theme_minimal() + 
  theme(text = element_text(family = "Roboto Condensed")) 

(co + wash) / (or + ak)
