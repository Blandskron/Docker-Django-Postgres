# Django + PostgreSQL con Docker

Este proyecto dockeriza una aplicación Django conectada a una base de datos PostgreSQL, clonado desde el repositorio: [M7-L2-PaquetesBaseDatos-18-12-2024](https://github.com/Blandskron/M7-L2-PaquetesBaseDatos-18-12-2024).

## Requisitos Previos

1. Tener instalado Docker y Docker Compose en tu sistema.
2. Acceso a Internet para clonar el repositorio y descargar las imágenes necesarias.

## Estructura del Proyecto

```
.
├── docker-compose.yml
├── Dockerfile
├── .env (opcional, para gestionar variables de entorno)
```

## Configuración de la Base de Datos

En el archivo `docker-compose.yml`, el servicio de la base de datos PostgreSQL está configurado con las siguientes credenciales:

```yaml
db:
  image: postgres:latest
  environment:
    POSTGRES_USER: admin
    POSTGRES_PASSWORD: admin1234
    POSTGRES_DB: virtualmasterchef
  ports:
    - "5432:5432"
```

## Configuración de Django

El archivo `settings.py` de Django debe incluir la configuración de la base de datos:

```python
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql',
        'NAME': 'virtualmasterchef',
        'USER': 'admin',
        'PASSWORD': 'admin1234',
        'HOST': 'db',
        'PORT': '5432',
    }
}
```

## Pasos para Ejecutar el Proyecto

### 1. Clonar el Repositorio

Clona el repositorio desde GitHub:

```bash
git clone https://github.com/Blandskron/M7-L2-PaquetesBaseDatos-18-12-2024.git
cd M7-L2-PaquetesBaseDatos-18-12-2024
```

### 2. Configurar el Entorno

El archivo `Dockerfile` ya clona el repositorio y configura la aplicación Django para ejecutarse desde la carpeta `mi_proyecto`.

### 3. Construir y Levantar los Servicios

Ejecuta el siguiente comando para construir las imágenes y levantar los contenedores:

```bash
docker-compose up --build
```

Esto inicializará los servicios de Docker:
- **`db`**: Contenedor de PostgreSQL.
- **`django`**: Contenedor de Django.

### 4. Migrar la Base de Datos

Una vez que los contenedores estén ejecutándose, migra la base de datos:

```bash
docker exec -it django_container python manage.py migrate
```

### 5. Acceder a la Aplicación

Abre tu navegador y visita:

```
http://localhost:8000
```

La aplicación Django debería estar funcionando correctamente.

## Comandos útiles

- **Acceder al contenedor de Django:**
  ```bash
  docker exec -it django_container bash
  ```

- **Ejecutar pruebas:**
  ```bash
  docker exec -it django_container python manage.py test
  ```

- **Revisar logs del contenedor:**
  ```bash
  docker logs django_container
  ```

## Volúmenes y Persistencia de Datos

El contenedor de PostgreSQL utiliza un volumen para persistir los datos:

```yaml
volumes:
  postgres_data:
```

Si necesitas limpiar los datos, puedes eliminar este volumen:

```bash
docker-compose down -v
```

## Notas Adicionales

- Asegúrate de que las credenciales en `settings.py` coincidan con las configuradas en el archivo `docker-compose.yml`.
- Si haces cambios en los archivos de configuración, reconstruye los contenedores usando:
  ```bash
  docker-compose up --build
  ```

## Problemas Comunes

### Error: `python: can't open file '/mi_proyecto/manage.py': [Errno 2] No such file or directory`

Este error ocurre si el directorio de trabajo no está configurado correctamente en el `Dockerfile`. Asegúrate de que el `WORKDIR` apunta a `/app/mi_proyecto`.

```dockerfile
WORKDIR /app/mi_proyecto
```

