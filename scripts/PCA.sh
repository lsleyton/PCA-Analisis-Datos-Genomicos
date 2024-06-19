#!/bin/bash

# Script para realizar un PCA sobre datos.csv

# 1. Crear un entorno virtual (opcional pero recomendado)
echo "Creando un entorno virtual..."
python3 -m venv pca_env

# 2. Activar el entorno virtual
echo "Activando el entorno virtual..."
source pca_env/bin/activate

# 3. Instalar las librerías necesarias
echo "Instalando las librerías necesarias..."
pip install pandas scikit-learn matplotlib

# 4. Crear un script Python para realizar el PCA
echo "Creando el script Python para el PCA..."

cat <<EOL > realizar_pca.py
import pandas as pd
from sklearn.decomposition import PCA
import matplotlib.pyplot as plt

# Leer los datos del archivo CSV
data = pd.read_csv('datos.csv')

# Separar las características (asumiendo que todas las columnas son características)
# Si hay una columna de etiquetas, puedes excluirla de esta manera: data.drop('etiqueta', axis=1)
features = data

# Estandarizar los datos (es importante para PCA)
from sklearn.preprocessing import StandardScaler
scaler = StandardScaler()
scaled_features = scaler.fit_transform(features)

# Crear el modelo PCA y ajustar los datos
pca = PCA(n_components=2)  # Cambia n_components según tus necesidades
principal_components = pca.fit_transform(scaled_features)

# Crear un DataFrame con los componentes principales
principal_df = pd.DataFrame(data=principal_components, columns=['PC1', 'PC2'])

# Graficar los componentes principales
plt.figure(figsize=(8, 6))
plt.scatter(principal_df['PC1'], principal_df['PC2'])
plt.title('PCA de datos.csv')
plt.xlabel('Principal Component 1')
plt.ylabel('Principal Component 2')
plt.grid()
plt.savefig('pca_result.png')  # Guardar la gráfica como archivo de imagen
plt.show()

# Guardar los componentes principales en un archivo CSV
principal_df.to_csv('pca_componentes.csv', index=False)

print("PCA completado. Los resultados se han guardado en 'pca_componentes.csv' y 'pca_result.png'")
EOL

# 5. Ejecutar el script Python
echo "Ejecutando el script Python para realizar el PCA..."
python realizar_pca.py

# 6. Desactivar el entorno virtual
echo "Desactivando el entorno virtual..."
deactivate

echo "Proceso completado."

