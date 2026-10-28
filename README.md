# Retail-SQL-Reporting

![Status: Maintained](https://img.shields.io/badge/Status-Maintained-brightgreen?style=for-the-badge)
![License: MIT](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

![Databricks](https://img.shields.io/badge/Databricks-FF3621?style=for-the-badge&logo=databricks&logoColor=white)
![Spark SQL](https://img.shields.io/badge/Spark_SQL-E25A1C?style=for-the-badge&logo=apache-spark&logoColor=white)

Análisis avanzado de datos transaccionales y reporting de ventas en retail utilizando Spark SQL sobre Databricks Lakehouse para optimizar la toma de decisiones comerciales.

## 📊 Sobre el Proyecto
Este repositorio contiene la resolución de un caso analítico y modelado de datos sobre una cadena de retail (enunciados y requerimientos comerciales provistos por la consultora **Lovelytics**). El objetivo principal es transformar datos brutos de ventas en reportes estratégicos para las áreas de **Demand Planning** y **Reporting**, permitiendo optimizar el inventario y evaluar el desempeño comercial mediante KPIs clave.

A través de **Spark SQL**, se resuelven desafíos de negocio complejos, desde tendencias temporales hasta segmentación avanzada de clientes y fuerza de ventas.

## 🏢 Arquitectura del Modelo de Negocio

![DER-Ventas](https://github.com/user-attachments/assets/089aa40e-ebed-4667-a5fc-72a20bf3a6d7)

El análisis se estructura sobre un modelo estrella/relacional compuesto por cinco dimensiones fundamentales:

* **Ventas (Facturas):** Núcleo transaccional que registra volumen, fechas, cliente y vendedor.
* **Clientes:** Perfiles demográficos para análisis de comportamiento y frecuencia de compra.
* **Productos:** Catálogo agrupado por familias (Lácteos, Chocolates, Helados, etc.) y precios unitarios.
* **Fuerza de Ventas (Empleados):** Registro de vendedores y asignación a sucursales.
* **Infraestructura (Locales):** Clasificación de sucursales según su tipo (Supermercado, Hipermercado, Cercanía).

## 🛠️ Desafíos de Negocio y Desarrollo Analítico (SQL)

Las consultas SQL implementadas combinan rigor técnico con impacto comercial directo para la operación:

### 🔹 Análisis de Rendimiento y KPIs
- **Tendencias Temporales:** Cálculo de volumen y rentabilidad por año/familia para identificar picos de demanda utilizando agregaciones complejas.
- **Desempeño de Sucursales:** Ranking de facturación total segmentado por tipo de local.
- **Lógica Temporal Dinámica:** Filtrado de métricas comerciales del mes anterior aplicando funciones de fecha nativas de Spark SQL (`DATE_TRUNC`, `ADD_MONTHS`).

### 🔹 Segmentación de Clientes y Fidelización
- **Perfil del Consumidor:** Segmentación de ventas transaccionales por sexo y grupo etario.
- **Análisis de Clientes VIP:** Identificación de usuarios con alta frecuencia de compra (>50 facturas) y edad superior al promedio poblacional para campañas de fidelización, empleando subconsultas y CTEs.

### 🔹 Gestión de Fuerza de Ventas y Data Quality
- **Productividad:** Categorización dinámica de la fuerza de ventas (Excelente, Bueno, Regular) y detección de umbrales para programas de incentivos mediante `CASE WHEN`.
- **Auditoría y Normalización:** Limpieza de nombres, detección de inconsistencias (ventas de ex-empleados) y manejo defensivo de valores nulos con `COALESCE` y `NULLIF`.

## 🚀 Tecnologías Utilizadas
- **Motor:** Spark SQL / Databricks.
- **Técnicas SQL:** Common Table Expressions (CTEs), Subconsultas, Joins complejos, Funciones de ventana/agregación, funciones de fecha y lógica condicional.
- **Fuente de Datos:** Dataset transaccional de ventas retail (CSV: Clientes, Productos, Facturas, Locales, Empleados).

---
👨‍💻 **Juan Manuel Landa** — *Computer Engineer | Data Analyst & BI Consultant*  
🔗 [LinkedIn](https://ar.linkedin.com/in/juan-manuel-landa/en) • 🌐 [Portfolio](https://juan-manuel-landa.netlify.app/) • ✉️ [Contacto](mailto:jmlanda93@gmail.com)
