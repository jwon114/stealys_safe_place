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

INSERT INTO inventories (name, description, price, quantity, image_url) 
VALUES ('portal gun', 'a gadget that allows the user(s) to travel between different universes/dimensions/realities', 150, 1, 'https://vignette.wikia.nocookie.net/rickandmorty/images/5/55/Portal_gun.png/revision/latest?cb=20140509065310');

INSERT INTO inventories (name, description, price, quantity, image_url) 
VALUES ('butter robot', 'a small, two armed, mobile robot created for the sole purpose of passing butter.', 75, 1, 'https://vignette.wikia.nocookie.net/rickandmorty/images/6/67/Butter_Robot_Picture.png/revision/latest?cb=20171106225602');

INSERT INTO inventories (name, description, price, quantity, image_url) 
VALUES ('plumbus', 'an all-purpose home device. Everyone knows what it does, so there is no reason to explain it.', 100, 1, 'https://vignette.wikia.nocookie.net/rickandmorty/images/d/d1/Everybody_has_a_Plumbus.JPG/revision/latest?cb=20170926163022');

INSERT INTO inventories (name, description, price, quantity, image_url) 
VALUES ('mr meeseeks box', 'a gadget that creates a Mr. Meeseeks for the purpose of completing one given objective.', 250, 1, 'https://vignette.wikia.nocookie.net/rickandmorty/images/f/f7/Mr._Meeseeks_Box.png/revision/latest?cb=20160909153718');

