DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS inventories;
DROP TABLE IF EXISTS carts;
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS reviews;

CREATE TABLE items (
	id SERIAL PRIMARY KEY,
	name VARCHAR(300),
	description VARCHAR(600),
	price INTEGER,
	image_url VARCHAR(600)
);

CREATE TABLE inventories (
	id SERIAL PRIMARY KEY,
	item_id INTEGER NOT NULL,
	quantity INTEGER NOT NULL,
	FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE RESTRICT
);

CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(300),
	email VARCHAR(300),
	password_digest VARCHAR(600)
);

CREATE TABLE carts (
	id SERIAL PRIMARY KEY,
	item_id INTEGER NOT NULL,
	quantity INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE RESTRICT,
	FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE RESTRICT
);

CREATE TABLE reviews (
	id SERIAL PRIMARY KEY,
	item_id INTEGER NOT NULL,
	user_id INTEGER NOT NULL,
	review VARCHAR(600),
	rating INTEGER,
	FOREIGN KEY (item_id) REFERENCES items (id) ON DELETE RESTRICT,
	FOREIGN KEY (user_id) REFERENCES users (id) ON DELETE RESTRICT
);