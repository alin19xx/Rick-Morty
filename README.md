# Rick-Morty

Proyecto Rick & Morty diseñado con clean architecture, MVVM y SwiftUI. La aplicación muestra un listado de los personajes de la serie, con filtros y buscador por nombre, además de la respectiva pantalla de detalle para cada personaje.

### **1. Data**
- **Repositorios** para interactuar con la API de Rick & Morty. (https://rickandmortyapi.com/)
- Módulo de red implementado a través de un `NetworkClient` y gestión de errores.
- **Async/Await**: Utilizado para realizar llamadas asíncronas de red.

### **2. Domain**
- **UseCase** para obtener el listado de personajes, con lógica de paginación y filtros.
- **UseCase** para obtener la información detallada de cada personaje.
- **Paginación**: Scroll infinito implementado con prefetching para anticipar la carga de datos.

### **3. Presentation**
- **ViewModels** diseñados con el patrón `ObservableObject` para escuchar cambios en las propiedades utilizando `@Published`.

### **4. Testing**
- Pruebas unitarias implementadas para las capas **Domain** y **Data**:
  - Mocking de repositorios para simular respuestas de la API.
  - Validación de la lógica de paginación y gestion de errores.

### **5. Cacheo de imágenes**
- Sistema de cacheo de imágenes (CachedAsyncImage) utilizando un singleton (ImageCache) basado en NSCache para optimizar la gestión y la carga de imágenes.

### **6. Logger**
- **Logger personalizado**:
  - Sistema de logging basado en niveles (`info`, `error`, `debug`, etc.).
  - Activado únicamente en el entorno `DEBUG`.
