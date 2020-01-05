CREATE TABLE sigungus (
	id INT NOT NULL AUTO_INCREMENT,
	province_id INT NOT NULL,
	code INT NOT NULL,
	name VARCHAR(50),
	latitude DOUBLE,
	longitude DOUBLE,
	
	PRIMARY KEY(id),
	FOREIGN KEY(province_id) REFERENCES provinces (id)
)