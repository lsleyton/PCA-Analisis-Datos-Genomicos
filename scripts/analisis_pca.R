# Cargar librerías necesarias
library(tidyverse)
library(ggplot2)

# Cargar datos (asegúrate de ajustar la ruta al archivo de datos)
data <- read.csv("data/genomic_data.csv")

# Realizar PCA
pca_result <- prcomp(data, scale. = TRUE)

# Resumen del PCA
summary(pca_result)

# Gráfico de PCA
pca_data <- as.data.frame(pca_result$x)
ggplot(pca_data, aes(x = PC1, y = PC2)) +
  geom_point() +
  labs(title = "PCA de Datos Genómicos", x = "Componente Principal 1", y = "Componente Principal 2")
