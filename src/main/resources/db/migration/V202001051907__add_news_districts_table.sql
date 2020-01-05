CREATE TABLE news_districts (
	id INT NOT NULL AUTO_INCREMENT,
	news_id INT NOT NULL,
	province_id INT NOT NULL,
	sigungu_id INT NOT NULL,
	
	PRIMARY KEY(id),
	FOREIGN KEY(news_id) REFERENCES news_lists (id),
	FOREIGN KEY(province_id) REFERENCES provinces (id),
	FOREIGN KEY(sigungu_id) REFERENCES sigungus (id)
)