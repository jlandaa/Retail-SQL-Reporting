# Ventas-Exito-Reporting-SQL
![Status: Maintained](https://img.shields.io/badge/Status-Maintained-brightgreen?style=for-the-badge)
![License: MIT](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)

Challenge de SQL sobre Databricks. Enunciado brindado por la empresa Lovelytics.

## 📊 Sobre el Proyecto
Este repositorio contiene un análisis exhaustivo de datos transaccionales de una cadena de retail (Caso Éxito). El objetivo principal es transformar datos brutos de ventas en reportes estratégicos para el área de **Demand Planning** y **Reporting**, permitiendo optimizar la toma de decisiones basada en KPIs comerciales.

El proyecto utiliza **SQL (Databricks / Spark SQL)** para resolver desafíos de negocio complejos, desde análisis de tendencias hasta segmentación avanzada de clientes.

## 🏢 El Modelo de Negocio

![DER-Ventas](https://github.com/user-attachments/assets/089aa40e-ebed-4667-a5fc-72a20bf3a6d7)

El análisis se basa en un ecosistema de ventas minoristas que conecta cinco dimensiones clave:

* **Ventas (Facturas):** El núcleo transaccional que registra qué se vendió, cuándo y a quién.
* **Clientes:** Perfiles demográficos que permiten analizar el comportamiento por edad y sexo.
* **Productos:** Catálogo organizado por familias (Lácteos, Chocolates, Helados, etc.) con sus respectivos precios unitarios.
* **Fuerza de Ventas (Empleados):** Datos de los vendedores y su desempeño comercial.
* **Infraestructura (Locales):** Clasificación de sucursales según su tipo (Supermercado, Hipermercado, Comercio de cercanía).



## 🛠️ Desafíos de Negocio Resueltos
Las consultas SQL implementadas resuelven preguntas críticas para la operación:

### 🔹 Análisis de Rendimiento y KPIs
* **Tendencias Temporales:** Cálculo de volumen de productos vendidos por año para identificar picos de demanda.
* **Top de Ventas:** Identificación de los productos más vendidos por año para optimizar el inventario.
* **Desempeño de Sucursales:** Análisis de facturación total segmentado por tipo de local.

### 🔹 Segmentación de Clientes y Fidelización
* **Perfil del Consumidor:** Segmentación de ventas por sexo y grupo etario.
* **Análisis de Clientes VIP:** Identificación de clientes con alta frecuencia de compra y edad superior al promedio para campañas de fidelización personalizadas.

### 🔹 Gestión de Fuerza de Ventas
* **Productividad:** Reporte de vendedores que superan el umbral de las 100 facturas anuales para programas de incentivos.
* **Normalización de Datos:** Limpieza de nombres y apellidos, manejo de valores nulos y estandarización de registros.

## 🚀 Tecnologías Utilizadas
* **Motor:** Spark SQL / Databricks.
* **Dataset:** Archivos CSV (Clientes, Productos, Facturas, Locales, Empleados).
* **Conceptos Aplicados:** Joins complejos, Subconsultas, Common Table Expressions (CTEs), Funciones de agregación y lógica condicional (`CASE WHEN`).

---
*Proyecto realizado por Juan Manuel Landa.*
