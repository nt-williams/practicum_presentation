
library(tidyverse)
library(patchwork)
library(viridis)
library(extrafont)

loadfonts(device = "win")

# import ------------------------------------------------------------------

mj <- read_csv("../data/MJ_proportions.csv") %>% 
  mutate(age = as.factor(age))

us <- mj %>% 
  filter(state == "us", drug == "alcohol")

# plots -------------------------------------------------------------------

co <- mj %>% 
  filter(state == "colorado", drug == "alcohol") %>% 
  ggplot(aes(x = year, y = percent, color = age)) + 
  geom_line() + 
  geom_line(data = us, linetype = "dashed") + 
  geom_vline(xintercept = 2012, linetype = "dotted", alpha = 0.5) +
  labs(title = "Colorado") + 
  scale_color_viridis(discrete = TRUE) +
  scale_y_continuous(limits = c(0, 80), 
                     breaks = seq(0, 80, 20), labels = c("0", "20%", "40", "60", "80")) +  
  theme_minimal() + 
  theme(text = element_text(family = "Roboto Condensed"), 
        plot.title = element_text(size = 18),
        axis.title.x = element_blank(), 
        axis.title.y = element_blank(), 
        legend.position = "none",
        plot.background = element_rect(fill = "#FFFBF5")) 

wash <- mj %>% 
  filter(state == "wash", drug == "alcohol") %>% 
  ggplot(aes(x = year, y = percent, color = age)) + 
  geom_line() + 
  geom_line(data = us, linetype = "dashed") + 
  geom_vline(xintercept = 2012, linetype = "dotted", alpha = 0.5) +
  labs(title = "Washington") + 
  scale_color_viridis(discrete = TRUE, name = "Age group") +
  scale_y_continuous(limits = c(0, 80), 
                     breaks = seq(0, 80, 20), labels = c("0", "20%", "40", "60", "80")) + 
  theme_minimal() + 
  theme(text = element_text(family = "Roboto Condensed"), 
        plot.title = element_text(size = 18),
        axis.title.x = element_blank(), 
        axis.title.y = element_blank(), 
        plot.background = element_rect(fill = "#FFFBF5")) 

or <- mj %>% 
  filter(state == "oregon", drug == "alcohol") %>% 
  ggplot(aes(x = year, y = percent, color = age)) + 
  geom_line() + 
  geom_line(data = us, linetype = "dashed") + 
  geom_vline(xintercept = 2014, linetype = "dotted", alpha = 0.5) +
  labs(title = "Oregon") + 
  scale_color_viridis(discrete = TRUE) +
  scale_y_continuous(limits = c(0, 80), 
                     breaks = seq(0, 80, 20), labels = c("0", "20%", "40", "60", "80")) + 
  theme_minimal() + 
  theme(text = element_text(family = "Roboto Condensed"), 
        plot.title = element_text(size = 18),
        axis.title.x = element_blank(), 
        axis.title.y = element_blank(), 
        legend.position = "none", 
        plot.background = element_rect(fill = "#FFFBF5")) 

ak <- mj %>% 
  filter(state == "alaska", drug == "alcohol") %>% 
  ggplot(aes(x = year, y = percent, color = age)) + 
  geom_line() + 
  geom_line(data = us, linetype = "dashed") + 
  geom_vline(xintercept = 2014, linetype = "dotted", alpha = 0.5) +
  labs(title = "Alaska") + 
  scale_color_viridis(discrete = TRUE) +
  scale_y_continuous(limits = c(0, 80), 
                     breaks = seq(0, 80, 20), labels = c("0", "20%", "40", "60", "80")) +  
  theme_minimal() + 
  theme(text = element_text(family = "Roboto Condensed"), 
        plot.title = element_text(size = 18),
        axis.title.x = element_blank(), 
        axis.title.y = element_blank(), 
        legend.position = "none", 
        plot.background = element_rect(fill = "#FFFBF5"))  

tiff("alc.tiff", units = "in", width = 7, height = 5, res = 400)
(co + wash) / (or + ak)
dev.off()
