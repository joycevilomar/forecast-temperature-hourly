# *******************************************
# Nombre: Joyce N. Vilomar
# Diplomado Econometría
# Tarea final Módulo Macroeconometría 
# Tema : Predicción Temperatura de Habitación
# *******************************************

# CARGANDO LA BASE DE DATOS 
# **************************

tempData <- read.csv("data/MLTempDataset.csv")

tempData <- tempData[, !(names(tempData) %in% c("Datetime1", "X"))]
names(tempData)[names(tempData) == "DAYTON_MW"] <- "Temp"
View(tempData)

class(tempData$Datetime)

library(dplyr)
library(tidyverse)
library(ggplot2)
library(lubridate)

View(flights)

ggplot(data = tempData, aes(x = Datetime, y = Temp)) +
  geom_point() +
  labs(x = "Date",
       y = "Temperature",
       title = "Temperature Data",
       subtitle = "Room Temperature Logs")

str(tempData)

# tempData$Time <- hour(tempData$Datetime)
tempData$Date <- wday(tempData$Datetime, label = TRUE)

tempData |> 
  mutate(Dia = wday(Datetime, label = TRUE)) |> 
  ggplot(aes(x = Dia)) +
  geom_bar()

tempData %>% 
  mutate(hours = hour(Datetime)) %>% 
  group_by(hours) %>% 
  summarise(
    avg_temp = mean(Temp, na.rm = TRUE),
    n = n()) %>% 
  ggplot(aes(hours, avg_temp)) +
  geom_line()
