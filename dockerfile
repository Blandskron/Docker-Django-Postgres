# Usa una imagen oficial de Python
FROM python:3.11-slim

# Configura el directorio de trabajo
WORKDIR /app

# Instala git y otras herramientas necesarias
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*

# Clona el repositorio
RUN git clone https://github.com/Blandskron/M7-L2-PaquetesBaseDatos-18-12-2024.git .

# Instala las dependencias del proyecto
RUN pip install --no-cache-dir -r requirements.txt

# Cambia al directorio donde se encuentra `manage.py`
WORKDIR /app/mi_proyecto

# Exponer el puerto de la aplicación
EXPOSE 8000

# Comando por defecto
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
