-- N1.1 Creamo una nueva tabla "credit_card". Despues de creear la tabla insrtamos los datos que corresponden a esta. 
-- Comprobamos la tabala. Despues añadimos la FK para relacionarla con la tabla transaction.
-- --------------------------------------------------------------------------------------------
CREATE TABLE credit_card(
	id VARCHAR(100) NOT NULL,
    iban VARCHAR(100) NOT NULL,
    pan VARCHAR(30) NOT NULL,
    pin VARCHAR(20) NOT NULL, 
    cvv INT NOT NULL, 
    expiring_date VARCHAR(20) NOT NULL,
    PRIMARY KEY(id) ); 
-- ---------------------------------
ALTER TABLE transaction
ADD CONSTRAINT FK_Credit_card
FOREIGN KEY (credit_card_id) REFERENCES credit_card(id);
-- --------------------------------------------------------------------------------------------
-- N1.2 Un error en el IBAN a su tarjeta de crédito con ID CcU-2938. La información correcta es: TR323456312213576817699999. 
-- --------------------------------------------------------------------------------------------
UPDATE credit_card 
SET iban = 'TR323456312213576817699999'
WHERE id = 'CcU-2938';
-- -------- Mostrasmos el cambio 
SELECT *
FROM credit_card 
WHERE id = 'CcU-2938';
-- --------------------------------------------------------------------------------------------
-- N1.3 Insertamos los datos de una nuevca transacción a la tabla transaction.
-- --------------------------------------------------------------------------------------------
SELECT * 
FROM company -- No hay ninguna compañía en la base de datos con el id b-9999. Cremaos una usando ese id.
WHERE id = 'b-9999';
--  ----------
SELECT * 
FROM credit_card -- No hay ninguna credit_card en la base de datos con el id CcU-9999. Cremaos una usando ese id.
WHERE id = 'CcU-9999';
-- ------ Insertamos nueva compañía. 
INSERT INTO company
		( id, company_name, phone, email, country, website )
VALUES	( 'b-9999', 'Tranportes Pepe','03 74 10 58 35', 'logstica.transportes@ttspepe.com', 'Spain', 'https://transportespepe.com/one' );
-- ------ Insertamos nueva credit_card.
INSERT INTO credit_card 
		(id, iban, pan, pin, cvv, expiring_date) 
VALUES  ('CcU-9999', 'XX361254537711118548758877', '1147800632149950', '2876', '551', '09/27/28');
-- ------ Insertamos nueva transacción.
INSERT INTO transaction
		( id, credit_card_id, company_id, user_id, lat,timestamp, longitude, amount, declined )
VALUES	( '108B1D1D-5B23-A76C-55EF-C568E49A99DD', 'CcU-9999', 'b-9999', 9999, 829.999,CURRENT_TIMESTAMP(), -117.999, 111.11, 0 );
-- ------ Mostramos la tabla con el cambio.
SELECT * 
FROM transaction 
WHERE id = '108B1D1D-5B23-A76C-55EF-C568E49A99DD';
-- --------------------------------------------------------------------------------------------
-- N1.4  Nos solicitan eliminar la columna "pan" de la tabla credit_card.
-- --------------------------------------------------------------------------------------------
ALTER TABLE credit_card
DROP pan;
-- ------ Mostramos tabla.
SELECT * 
FROM credit_card;
-- --------------------------------------------------------------------------------------------
-- N2.1  Eliminar de la tabla transacción el registro con ID 000447FE-B650-4DCF-85DE-C7ED0EE1CAAD.
-- --------------------------------------------------------------------------------------------
DELETE 
FROM transaction
WHERE id = '000447FE-B650-4DCF-85DE-C7ED0EE1CAAD'; 
-- ----- Mostramos la tabla con el cambio.
SELECT *
FROM transaction
WHERE id = '000447FE-B650-4DCF-85DE-C7ED0EE1CAAD'; 
-- --------------------------------------------------------------------------------------------
-- N2.2 Crear una vista llamada VistaMarketing que contenga: Nombre de la compañía, Teléfono de contacto, País de residencia
--      y media de compra realizado por cada compañía. Ordenando de mayor a menor promedio de compra.
-- --------------------------------------------------------------------------------------------
CREATE VIEW vista_arketing AS 
SELECT 
	c.company_name,
    c.phone,
    c.country,
    ROUND(AVG(t.amount), 2) AS media_compras
FROM company c
JOIN transaction t
	ON c.id = t.company_id
GROUP BY c.company_name,
		 c.phone,
		 c.country
ORDER BY media_compras DESC; 
-- ------ Mostramos la vista. 
SELECT *
FROM vista_marketing; 
-- --------------------------------------------------------------------------------------------
-- N2.3 Filtrar la vista VistaMarketing para mostrar sólo las compañías que tienen su país de residencia en "Germany"
-- --------------------------------------------------------------------------------------------
SELECT *
FROM vista_marketing
WHERE country = 'Germany';
-- --------------------------------------------------------------------------------------------
-- N3.1 Se realizaran modificaciones en la base de datos. Hay dejar los comandos ejecutados para ello.
-- --------------------------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS user(
	id INT PRIMARY KEY, -- Cambio el type de CHAR a INT para compatibilizar con user_id en transacction 
	name VARCHAR(100),
	surname VARCHAR(100),
	phone VARCHAR(150),
	email VARCHAR(150),
	birth_date VARCHAR(100),
	country VARCHAR(150),
	city VARCHAR(150),
	postal_code VARCHAR(100),
	address VARCHAR(255)    
);
-- ------ Mostramos la tabal creada.
SELECT * 
FROM user;
-- ------ Insertamos los datos y mostramos la tabal.
SELECT * 
FROM user;
-- ------ Añadimos la FK para relacionarla con la tabla transaction.
ALTER TABLE transaction
ADD CONSTRAINT FK_user_id
FOREIGN KEY (user_id) REFERENCES user(id);






