# Challenge Mobile MELI 2025  
**Autor:** Nehuen Roth  

Este proyecto corresponde al **Challenge Mobile 2025 de Mercado Libre**, donde el objetivo es construir una aplicación mobile que consuma la API pública de [Space Flight News](https://api.spaceflightnewsapi.net/v4/docs/) y permita al usuario explorar noticias relacionadas con vuelos espaciales.  

---

## Funcionalidades

- **Listado de artículos recientes:**  
  Se muestra un listado con los últimos artículos obtenidos desde la API.

- **Búsqueda de artículos:**  
  El usuario puede buscar artículos escribiendo en un campo de búsqueda.  
  El listado se actualiza dinámicamente según la búsqueda realizada.

- **Detalle de artículo:**  
  Desde el listado, el usuario puede acceder al detalle completo de un artículo.  
  Se incluyen título, fecha, fuente, imagen y descripción.

- **Manejo de estados y rotación:**  
  Cada pantalla soporta la rotación y mantiene el estado actual de la vista.

- **Manejo de errores:**  
  - **Usuario:** se muestran mensajes claros y feedback adecuado.  
  - **Developer:** se incluye logging y consistencia en la gestión de errores.

---

## Arquitectura

El proyecto está desarrollado siguiendo **MVVM (Model-View-ViewModel)**, priorizando separación de responsabilidades y escalabilidad.  

- **Model:** estructuras de datos y entidades de la API.  
- **View:** pantallas construidas principalmente en **SwiftUI**.  
- **ViewModel:** lógica de negocio y binding entre modelo y vista.  
- **Services:** capa para consumo de la API (networking).  
- **UIKit:** utilizado únicamente en casos muy específicos (por ejemplo, manejo de `UIImage`, para reescalado de una imagen).  

---

## Tecnologías y librerías utilizadas

- **Lenguaje:** Swift 5  
- **Frameworks:** SwiftUI (principal), Foundation, UIKit (mínimo)  
- **Manejo de concurrencia:** `async/await`  
- **Persistencia en memoria:** manejo de estado en ViewModels  
- **Testing:** pruebas unitarias sobre servicios y ViewModels  

---

## Ejecución del proyecto

1. Clonar el repositorio:
   ```bash
   git clone https://github.com/Nehuen-R/ChallengeMELI_Nehuen_Roth.git
   ```
2. Abrir el proyecto en Xcode 15 o superior.

3. Ejecutar el proyecto en un simulador o dispositivo físico con iOS 16.6+.
