DROP TABLE IF EXISTS reviews;
DROP TABLE IF EXISTS carts;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS inventories;

CREATE TABLE inventories (
	id SERIAL PRIMARY KEY,
	name VARCHAR(300) NOT NULL,
	description TEXT,
	price INTEGER DEFAULT 0,
	quantity INTEGER NOT NULL,
	image_url TEXT
);

CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(300),
	email VARCHAR(300) NOT NULL,
	password_digest TEXT
);

CREATE TABLE carts (
	id SERIAL PRIMARY KEY,
	inventory_id INTEGER NOT NULL,
	quantity INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	FOREIGN KEY (inventory_id) REFERENCES inventories (id) ON DELETE CASCADE,
	FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);

CREATE TABLE reviews (
	id SERIAL PRIMARY KEY,
	inventory_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	review_text TEXT,
	rating INTEGER,
	FOREIGN KEY (inventory_id) REFERENCES inventories (id) ON DELETE CASCADE,
	FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE CASCADE
);