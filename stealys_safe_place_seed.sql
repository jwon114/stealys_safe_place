TRUNCATE TABLE items;
TRUNCATE TABLE inventories;
TRUNCATE TABLE carts;
TRUNCATE TABLE users;
TRUNCATE TABLE reviews;

ALTER SEQUENCE items_id_seq RESTART WITH 1;
ALTER SEQUENCE inventories_id_seq RESTART WITH 1;
ALTER SEQUENCE carts_id_seq RESTART WITH 1;
ALTER SEQUENCE users_id_seq RESTART WITH 1;
ALTER SEQUENCE reviews_id_seq RESTART WITH 1;

INSERT INTO items (name, desc, price, image_url) 
VALUES ('portal gun', 'a gadget that allows the user(s) to travel between different universes/dimensions/realities', 15, 'https://vignette.wikia.nocookie.net/rickandmorty/images/5/55/Portal_gun.png/revision/latest?cb=20140509065310');