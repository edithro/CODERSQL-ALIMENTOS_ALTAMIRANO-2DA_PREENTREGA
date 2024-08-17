DROP DATABASE IF EXISTS alimentos_altamirano;
CREATE DATABASE alimentos_altamirano;
USE alimentos_altamirano;

-- Creación de Tablas de acuerdo al detalle listado en PDF--
-- Tabla Marcas --
CREATE TABLE marca (
	cod_marca INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    marca VARCHAR(10) NOT NULL
);
-- Tabla Articulos --
CREATE TABLE articulos (
	cod_articulo VARCHAR(10) PRIMARY KEY,
    art_descripcion VARCHAR(100) NOT NULL,
    cod_marca INT UNSIGNED NOT NULL,
    FOREIGN KEY (cod_marca) REFERENCES marca(cod_marca),
    peso_unitario DECIMAL(7,2) NOT NULL
);
-- Tabla Zona --
CREATE TABLE zona (
	cod_zona INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    zona VARCHAR(10) NOT NULL
);
-- Tabla Comisiones --
CREATE TABLE comisiones (
	cod_comision INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    comision DECIMAL(5,2) NOT NULL
);
-- Tabla Vendedores --
CREATE TABLE vendedores (
	cod_vendedor INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    cod_zona INT UNSIGNED NOT NULL,
    FOREIGN KEY (cod_zona) REFERENCES zona(cod_zona),
	cod_comision INT UNSIGNED NOT NULL,
    FOREIGN KEY (cod_comision) REFERENCES comisiones(cod_comision)
);
-- Tabla Categorias --
CREATE TABLE categorias (
	cod_categoria INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tipo_cliente VARCHAR(50) NOT NULL
);
-- Tabla Clientes --
CREATE TABLE clientes (
	cod_cliente INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    razon_social VARCHAR(100) NOT NULL,
    cod_categoria INT UNSIGNED NOT NULL,
    FOREIGN KEY (cod_categoria) REFERENCES categorias(cod_categoria)
);
-- Tabla Tipo Comprobantes --
CREATE TABLE tipo_comprobantes (
	id_tipo_comp INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    tipo_comp VARCHAR(20) NOT NULL
);
-- Tabla Ventas --
CREATE TABLE ventas (
	fecha_emision DATE,
	id_comprobante INT UNSIGNED AUTO_INCREMENT,
    comp_nro VARCHAR(50),
    id_tipo_comp INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_tipo_comp) REFERENCES tipo_comprobantes(id_tipo_comp),
    cod_cliente INT UNSIGNED NOT NULL,
    FOREIGN KEY (cod_cliente) REFERENCES clientes(cod_cliente),
    razon_social VARCHAR(100) NOT NULL,
    imp_facturado DECIMAL(12,2) NOT NULL,
	cod_vendedor INT UNSIGNED NOT NULL,
    FOREIGN KEY (cod_vendedor) REFERENCES vendedores(cod_vendedor),
    PRIMARY KEY (id_comprobante, comp_nro),
    INDEX comp_nro_index (comp_nro)
);
-- Tabla Ventas por articulo --
CREATE TABLE ventas_por_articulo (
	id_vta_art INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    comp_nro VARCHAR(50),
    FOREIGN KEY (comp_nro) REFERENCES ventas(comp_nro),
    cod_articulo VARCHAR(10) NOT NULL,
    FOREIGN KEY (cod_articulo) REFERENCES articulos(cod_articulo),
    item_cantidad INT NOT NULL,
    importe_neto DECIMAL(12,2) NOT NULL
);

-- Tabla log_vtas_control para trigger--
CREATE TABLE IF NOT EXISTS log_vtas_control (
cod_log INT AUTO_INCREMENT PRIMARY KEY,
tabla VARCHAR (20),
accion VARCHAR (20),
comp_nro VARCHAR (50),
usuario VARCHAR (100),
fecha DATE,
hora TIME);

-- Tabla control_articulo para trigger--
CREATE TABLE IF NOT EXISTS control_articulo (
cod_articulo VARCHAR (10) PRIMARY KEY,
art_descripcion VARCHAR (100),
cod_marca INT,
peso_unitario DECIMAL (7,2));
-- ---------------------------------------------------------------------------------------------------------------------------------- --
-- Inserción de datos en las tablas---
USE alimentos_altamirano;

-- Insertar Datos Tabla : Marca ---
INSERT INTO marca (cod_marca, marca) VALUES (NULL, 'Orloc');
INSERT INTO marca (cod_marca, marca) VALUES (NULL, 'Ravana');
INSERT INTO marca (cod_marca, marca) VALUES (NULL, 'Marolio');
INSERT INTO marca (cod_marca, marca) VALUES (NULL, 'Carrefour');

SELECT * FROM marca; -- Comprobación de carga de datos--

-- Insertar Datos Tabla : Zona ---
INSERT INTO zona (cod_zona, zona) VALUES (NULL, 'Arg norte');
INSERT INTO zona (cod_zona, zona) VALUES (NULL, 'Baires C');
INSERT INTO zona (cod_zona, zona) VALUES (NULL, 'Baires N');
INSERT INTO zona (cod_zona, zona) VALUES (NULL, 'Baires O');
INSERT INTO zona (cod_zona, zona) VALUES (NULL, 'Baires S');
INSERT INTO zona (cod_zona, zona) VALUES (NULL, 'Costa arg');
INSERT INTO zona (cod_zona, zona) VALUES (NULL, 'Patagonia');
INSERT INTO zona (cod_zona, zona) VALUES (NULL, 'Prov bs as');

SELECT * FROM zona; -- Comprobación de carga de datos--

-- Insertar Datos Tabla : Categorias ---
INSERT INTO categorias (cod_categoria, tipo_cliente) VALUES (NULL, 'Distribuidor');
INSERT INTO categorias (cod_categoria, tipo_cliente) VALUES (NULL, 'Distri especial');
INSERT INTO categorias (cod_categoria, tipo_cliente) VALUES (NULL, 'Mayorista');
INSERT INTO categorias (cod_categoria, tipo_cliente) VALUES (NULL, 'Indirecto');
INSERT INTO categorias (cod_categoria, tipo_cliente) VALUES (NULL, 'Catering');
INSERT INTO categorias (cod_categoria, tipo_cliente) VALUES (NULL, 'Super');
INSERT INTO categorias (cod_categoria, tipo_cliente) VALUES (NULL, 'Institucion');
INSERT INTO categorias (cod_categoria, tipo_cliente) VALUES (NULL, 'Cadena');
INSERT INTO categorias (cod_categoria, tipo_cliente) VALUES (NULL, 'Agrupacion');
INSERT INTO categorias (cod_categoria, tipo_cliente) VALUES (NULL, 'Licitaciones');

-- Insertar Datos Tabla : Clientes ---
INSERT INTO clientes (cod_cliente, razon_social, cod_categoria) VALUES (NULL, 'COMPAÑIA INTEGRAL DE ALIMENTOS', 5);
INSERT INTO clientes (cod_cliente, razon_social, cod_categoria) VALUES (NULL, 'DISTRIBUIDORA BLANCALUNA S.A.', 2);
INSERT INTO clientes (cod_cliente, razon_social, cod_categoria) VALUES (NULL, 'DISTRIBUIDORA EL CRIOLLO SRL', 1);
INSERT INTO clientes (cod_cliente, razon_social, cod_categoria) VALUES (NULL, 'INC SOCIEDAD ANONIMA', 8);
INSERT INTO clientes (cod_cliente, razon_social, cod_categoria) VALUES (NULL, 'LISERAR SA',5);
INSERT INTO clientes (cod_cliente, razon_social, cod_categoria) VALUES (NULL, 'MAXICONSUMO S.A.', 3);
INSERT INTO clientes (cod_cliente, razon_social, cod_categoria) VALUES (NULL, 'RICARDO NINI S.A.', 3);
INSERT INTO clientes (cod_cliente, razon_social, cod_categoria) VALUES (NULL, 'SUPERMERCADOS MAYORISTAS YAGUAR S.A.', 3);

SELECT * FROM clientes;-- Comprobación de carga de datos--

-- Insertar Datos Tabla : Tipo comprobantes ---
INSERT INTO tipo_comprobantes (id_tipo_comp, tipo_comp) VALUES (NULL, 'Factura');
INSERT INTO tipo_comprobantes (id_tipo_comp, tipo_comp) VALUES (NULL, 'Factura exterior');
INSERT INTO tipo_comprobantes (id_tipo_comp, tipo_comp) VALUES (NULL, 'Nota de credito');
INSERT INTO tipo_comprobantes (id_tipo_comp, tipo_comp) VALUES (NULL, 'Nota de credito ext');
INSERT INTO tipo_comprobantes (id_tipo_comp, tipo_comp) VALUES (NULL, 'Nota de debito');
INSERT INTO tipo_comprobantes (id_tipo_comp, tipo_comp) VALUES (NULL, 'Nota de debito ext');

SELECT * FROM tipo_comprobantes; -- Comprobación de carga de datos--

-- Insertar Datos Tabla : Comisiones ---
INSERT INTO comisiones (cod_comision, comision) VALUES (NULL, 0.01);
INSERT INTO comisiones (cod_comision, comision) VALUES (NULL, 0.03);
INSERT INTO comisiones (cod_comision, comision) VALUES (NULL, 0.05);

SELECT * FROM comisiones; -- Comprobación de carga de datos--

-- Insertar Datos Tabla : Vendedores ---
INSERT INTO vendedores (cod_vendedor, nombre, cod_zona, cod_comision) VALUES (NULL, 'ESTABLECIMIENTO ORLOC SRL', 2, 1);
INSERT INTO vendedores (cod_vendedor, nombre, cod_zona, cod_comision) VALUES (NULL, 'E.O. JR', 5, 2);
INSERT INTO vendedores (cod_vendedor, nombre, cod_zona, cod_comision) VALUES (NULL, 'EZEQUIEL URBINA', 4, 1);

SELECT * FROM vendedores; -- Comprobación de carga de datos--

/*USE alimentos_altamirano; */

-- Importacion de datos mediante archivos .csv--

-- Importar datos de archivo Articulos.csv . Tabla : articulos --
SELECT * FROM articulos; -- Comprobación de carga de datos--

-- Importar datos de archivo Ventas_final.csv . Tabla : ventas --
SELECT * FROM ventas; -- Comprobación de carga de datos--

-- Importar datos de archivo Ventas por articulo.csv . Tabla : ventas_´por_articulo --
SELECT * FROM ventas_por_articulo; -- Comprobación de carga de datos--

--  -----------------------------------------------------------------------------------------------------------------------------  --
-- Creacion de vistas--

-- 1 - Vista total_facturado_mes, se crea la vista para visualizar los totales facturados por mes -- 
SET lc_time_names = 'es_ES';-- seteo de obtención de resultados en castellano--

CREATE VIEW total_facturado_mes (fecha_emision, imp_facturado) AS
	SELECT MONTHNAME(fecha_emision) AS mes_facturacion, SUM(imp_facturado) AS total_facturado
    FROM ventas
    GROUP BY mes_facturacion;
    
SELECT * FROM total_facturado_mes; -- visualización de la vista--

-- 2 - Vista vendedores_primer_trimestre el cual detalla las ventas generadas por cada vendedor durante los meses del primer trimestre --
CREATE VIEW vendedores_primer_trimestre (nombre, Enero, Febrero, Marzo) AS
	SELECT nombre, SUM(CASE MONTH(fecha_emision) WHEN 1 THEN imp_facturado END) AS Enero,
	SUM(CASE MONTH(fecha_emision) WHEN 2 THEN imp_facturado END) AS Febrero,
	SUM(CASE MONTH(fecha_emision) WHEN 3 THEN imp_facturado END) AS Marzo
	FROM vendedores
	LEFT JOIN ventas
	ON vendedores.cod_vendedor = ventas.cod_vendedor
	GROUP BY nombre;
    
SELECT * FROM vendedores_primer_trimestre; -- visualización de la vista--

-- 3 - Vista articulos_mas_facturados, la misma proporciona los 15 artículos as vendidos del período-
CREATE VIEW articulos_mas_facturados (art_descripción, Importe_facturado) AS
SELECT art_descripcion, ROUND(sum(importe_neto)*1.21, 2) AS Importe_facturado
FROM articulos
LEFT JOIN ventas_por_articulo
ON articulos.cod_articulo = ventas_por_articulo.cod_articulo
GROUP BY art_descripcion
ORDER BY Importe_facturado desc
LIMIT 15;

SELECT * FROM articulos_mas_facturados; -- visualizacion de la vista --

-- 4 - Vista articulos_mas_vendidos: muestra los 15 artículos mas vendidos según su cantidad--
CREATE VIEW articulos_mas_vendidos (art_descripcion, Cantidad_vendida) AS
SELECT art_descripcion, SUM(item_cantidad) AS Cantidad_vendida
FROM articulos
LEFT JOIN ventas_por_articulo
ON articulos.cod_articulo = ventas_por_articulo.cod_articulo
GROUP BY art_descripcion
ORDER BY Cantidad_vendida desc
LIMIT 15;

SELECT * FROM articulos_mas_vendidos; -- visualización de la vista --

-- 5 - Vista ventas_totales_clientes detalla los 10 clientes con mayor facturación y el detalle de cantidad de productos comprada--
CREATE VIEW ventas_totales_clientes (razon_social, Importe_facturado, Cantidad_comprada) AS
SELECT clientes.razon_social, SUM(imp_facturado) AS Importe_facturado, SUM(item_cantidad) AS Cantidad_comprada
FROM clientes
JOIN ventas
ON clientes.cod_cliente = ventas.cod_cliente
JOIN ventas_por_articulo
ON ventas.comp_nro = ventas_por_articulo.comp_nro
GROUP BY clientes.razon_social
ORDER BY Importe_facturado DESC
LIMIT 10;

SELECT * FROM ventas_totales_clientes; -- visualización de la vista 
--  ---------------------------------------------------------------------------------------------------------------------------- --
-- Creacion de Funciones --

-- 1- Funcion facturado_sin_iva: Muestra el total facturado sin impuestos --
DELIMITER $$
CREATE FUNCTION facturado_sin_iva (mes INT) RETURNS DECIMAL (12,2)
NO SQL
BEGIN
	DECLARE facturacion DECIMAL(12,2);
    DECLARE facturacion_sin_iva DECIMAL (12,2);
    SET facturacion = (SELECT SUM(imp_facturado) AS total_facturado FROM ventas WHERE MONTH(fecha_emision) = mes);
    SET facturacion_sin_iva = facturacion / 1.21;
    RETURN facturacion_sin_iva;
END$$
$$

DELIMITER //
SELECT facturado_sin_iva(1) AS Facturado_sin_IVA
//

-- 2 - Función calculo_comisiones: muestra el total de comisiones del vendedor y mes seleccionado --
DELIMITER $$
CREATE FUNCTION calculo_comisiones (vendedor INT, mes INT) RETURNS DECIMAL (15,2)
NO SQL
BEGIN
	DECLARE comision_vendedor DECIMAL(5,2);
    DECLARE facturacion_vendedor DECIMAL (12,2);
    DECLARE comision_total DECIMAL (15,2);
    SET comision_vendedor = (SELECT comision FROM comisiones JOIN vendedores ON vendedores.cod_comision=comisiones.cod_comision WHERE cod_vendedor = vendedor);
    SET facturacion_vendedor = (SELECT SUM(imp_facturado) FROM ventas WHERE cod_vendedor = vendedor AND MONTH(fecha_emision) = mes);
    SET comision_total = comision_vendedor * facturacion_vendedor;
    RETURN comision_total;
END$$
$$

DELIMITER //
SELECT calculo_comisiones(1, 1) AS comisiones_vendedor_mes;
//
-- ----------------------------------------------------------------------------------------------------------------------------- --
-- Creación de Stored Procedures --

-- 1- detalle_ventas_cliente: Muestra el detalle por articulo, de las cantidades vendidas y el importe facturado del cliente seleccionado--
DELIMITER $$
CREATE PROCEDURE detalle_ventas_cliente (IN cliente VARCHAR(50))
BEGIN
    DECLARE cliente_like VARCHAR (50);
    SET cliente_like = CONCAT('%',cliente,'%');
 	SELECT sum(item_cantidad) AS cantidad_vendida, art_descripcion, sum(imp_facturado) AS total_facturado
	FROM ventas
	JOIN ventas_por_articulo 
	ON ventas.comp_nro = ventas_por_articulo.comp_nro
	JOIN articulos
	ON articulos.cod_articulo = ventas_por_articulo.cod_articulo
	WHERE ventas.razon_social LIKE cliente_like
	GROUP BY art_descripcion
	ORDER BY cantidad_vendida DESC
	LIMIT 15;
END$$
$$

DELIMITER //
CALL detalle_ventas_cliente ('MAXICONSUMO');
//

-- 2 detalle_ventas_articulos: muestra la cantidad vendida y su variación respecto al mes anterior de los artículos de la marca seleccionada --

DELIMITER $$
CREATE PROCEDURE detalle_ventas_articulos (IN marca VARCHAR(10))
BEGIN
	SELECT art_descripcion, SUM(CASE MONTH(fecha_emision) WHEN 1 THEN item_cantidad END) AS Enero, (SUM(CASE MONTH(fecha_emision) WHEN 1 THEN item_cantidad END)/0) AS Var_Enero,
	SUM(CASE MONTH(fecha_emision) WHEN 2 THEN item_cantidad END) AS Febrero, ROUND(((SUM(CASE MONTH(fecha_emision) WHEN 2 THEN item_cantidad END)/SUM(CASE MONTH(fecha_emision) WHEN 1 THEN item_cantidad END))-1)*100,2) AS Var_Febrero,
	SUM(CASE MONTH(fecha_emision) WHEN 3 THEN item_cantidad END) AS Marzo, ROUND(((SUM(CASE MONTH(fecha_emision) WHEN 3 THEN item_cantidad END)/SUM(CASE MONTH(fecha_emision) WHEN 2 THEN item_cantidad END))-1)*100,2) AS Var_Marzo
	FROM articulos
	LEFT JOIN ventas_por_articulo
	ON articulos.cod_articulo = ventas_por_articulo.cod_articulo
	JOIN ventas
	ON ventas.comp_nro = ventas_por_articulo.comp_nro
	LEFT JOIN marca
	ON marca.cod_marca = articulos.cod_marca
	WHERE marca.marca LIKE marca
	GROUP BY art_descripcion
	ORDER BY art_descripcion ASC;
END$$
$$

DELIMITER //
CALL detalle_ventas_articulos ('RAVANA');
//
-- ------------------------------------------------------------------------------------------------------------------------------ -

-- Creacion de Triggers --

-- 1 control_articulo: Cada vez que se da de alta un nuevo articul se almacena en una tabla control_articulo para verificar las nuevas altas. --

CREATE TRIGGER tr_add_articulo
AFTER INSERT ON articulos
FOR EACH ROW
INSERT INTO control_articulo (cod_articulo, art_descripcion, cod_marca, peso_unitario) 
VALUES (NEW.cod_articulo, NEW.art_descripcion, NEW.cod_marca, NEW.peso_unitario);

INSERT INTO articulos (cod_articulo, art_descripcion, cod_marca, peso_unitario) VALUES ('JNRAV', 'Jugo de Naranja RAVANA de 1Lts', 2, 1000.00);

SELECT * FROM control_articulo

-- 2 log_vtas_control: registra en una tabla log_vtas_control los datos de la accion de carga de un nuevo comprobante en la tabla ventas --

DELIMITER //
CREATE TRIGGER tr_log_vtas_control
AFTER INSERT ON ventas
FOR EACH ROW
BEGIN
INSERT INTO log_vtas_control (cod_log, tabla, accion, comp_nro, usuario, fecha, hora)
VALUES (NULL, 'VENTAS','COMPROBANTE', NEW.comp_nro, CURRENT_USER(), NOW(), curtime());
END//
DELIMITER ;

INSERT INTO ventas (fecha_emision, id_comprobante, comp_nro, id_tipo_comp, cod_cliente, razon_social, imp_facturado, cod_vendedor) 
VALUES (CAST(NOW() AS DATE), NULL, 'FC A 0002-00055555', 1, 6, 'MAXICONSUMO S.A.', 1235456.50, 1);

SELECT * FROM ventas WHERE comp_nro = 'FC A 0002-00055555';

SELECT * FROM log_vtas_control;

