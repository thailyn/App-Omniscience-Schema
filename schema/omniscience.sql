-- -*- sql -*- --

-- All of the possible card types (enchantment, creature, etc.).
DROP TABLE IF EXISTS card_types CASCADE;
CREATE TABLE card_types (
  id SERIAL PRIMARY KEY,
  name varchar NOT NULL,

  CONSTRAINT unique__card_types__name UNIQUE(name)
);

DROP TABLE IF EXISTS cards CASCADE;
CREATE TABLE cards (
  id SERIAL PRIMARY KEY,
  name varchar NOT NULL,
  mana_cost varchar NOT NULL,
  converted_mana_cost int NOT NULL,
  type varchar NOT NULL, -- string representation of type line
  power int NULL,
  toughness int NULL,
  oracle_text varchar NULL,

  CONSTRAINT unique__cards__name UNIQUE(name)
);

-- TODO: Get a better name for this.
-- TODO: Bigger serial than INT?  BIGSERAL?
DROP TABLE IF EXISTS card_card_types CASCADE;
CREATE TABLE card_card_types (
  id SERIAL PRIMARY KEY,
  card_id int REFERENCES cards(id),
  type_id int REFERENCES card_types(id),

  CONSTRAINT unique__card_card_types__card_type UNIQUE(card_id, type_id)
);

-- Stores the rulings for each card.
DROP TABLE IF EXISTS oracle_rulings CASCADE;
CREATE TABLE oracle_rulings (
  id SERIAL PRIMARY KEY,
  card_id INT NOT NULL REFERENCES cards(id),
  rank SMALLINT NOT NULL,
  date -- date (no time),
  ruling_text varchar NOT NULL,

  CONSTRAINT unique__oracle_rulings__card_id_rank UNIQUE(card_id, rank)
)

DROP TABLE IF EXISTS sets CASCADE;
CREATE TABLE sets (
  id SERIAL PRIMARY KEY,
  name varchar NOT NULL,
  release_date --date (no time),
  size int NOT NULL,
  expansion_code varchar NOT NULL,

  CONSTRAINT unique__sets__name UNIQUE(name)
);

DROP TABLE IF EXISTS set_booster_images CASCADE;
CREATE TABLE set_booster_images (
  id SERIAL PRIMARY KEY,
  set_id INT NOT NULL REFERENCES sets(id),
  serial VARCHAR NOT NULL,

  CONSTRAINT unique__set_booster_images__serial UNIQUE(serial)
);

-- TODO: check spelling
DROP TABLE IF EXISTS rarities CASCADE;
CREATE TABLE rarities (
  id SERIAL PRIMARY KEY, -- TODO: small version
  name varchar NOT NULL,
  relative_rarity int NOT NULL, -- 1 = common, 2 = uncommon, etc. (partial order)

  CONSTRAINT unique__rarities__name UNIQUE(name)
);

DROP TABLE IF EXISTS artists CASCADE;
CREATE TABLE artists (
  id SERIAL PRIMARY KEY,
  name varchar NOT NULL,

  CONSTRAINT unique__artists__name UNIQUE(name)
);

-- TODO: better name?
DROP TABLE IF EXISTS set_cards CASCADE;
CREATE TABLE set_cards (
  id SERIAL PRIMARY KEY, -- TODO: bigserial?
  card_id INT NOT NULL REFERENCES cards(id),
  set_id INT NOT NULL REFERENCES sets(id),
  rarity_id SMALLINT NOT NULL REFERENCES rarities(id),
  type_text varchar NOT NULL,
  card_text varchar NULL,
  flavor_text varchar NULL,
  card_number int NULL,
  artist int NULL REFERENCES artists(id),

  CONSTRAINT unique__set_cards__card_set UNIQUE(card_id, set_id)
);


-- "booster box", "fat pack", "loose packs", etc.
DROP TABLE IF EXISTS container_types CASCADE;
CREATE TABLE container_sets (
  id SERIAL PRIMARY KEY, -- but small int version
  name varchar NOT NULL,
  description varchar NULL,

  CONSTRAINT unique__container_types__name UNIQUE(name)
);

-- TODO: get a better name for this
DROP TABLE IF EXISTS containers CASCADE;
CREATE TABLE containers (
  id SERIAL PRIMARY KEY,
  name varchar NULL, -- computed "code" that is human readable
  container_type_id SMALLINT NOT NULL references container_types(id),
  parent_container_id INT NULL references containers(id),
  --set_id INT NOT NULL references sets(id), -- do not have this, as it could be mixed
  number_of_packs INT NOT NULL,
  price NUMERIC(3, 10) NULL,
  source varchar NULL, -- where the container was obtained
  opener_id INT NULL REFERENCES users(id),
  open_date -- date with time and time zone
);

DROP TABLE IF EXISTS booster_packs CASCADE;
CREATE TABLE booster_packs (
  id SERIAL PRIMARY KEY,
  name varchar NULL, -- computed "code" that is human readable
  set_id INT NOT NULL references sets(id),
  set_booster_image_id INT NULL references set_booster_image(id),
  code VARCHAR NULL,

  -- TODO: Move these three columns into a mapping table between containers
  --       and boosters?
  container_id INT NULL references containers(id),
  container_column varchar NULL, -- column in container (for boxes specifically); TODO: lookup table?
  container_rank INT NULL, -- rank in the container

  price NUMERIC(3, 10) NULL,
  source varchar NULL, -- where the booster was obtained
  opener_id INT NULL REFERENCES users(id),
  open_date -- date with time and time zone
);

DROP TABLE IF EXISTS booster_pack_contents CASCADE;
CREATE TABLE booster_pack_contents (
  id SERIAL PRIMARY KEY, -- TOOD: bigserial? check size
  set_card_id INT NULL REFERENCES set_cards(id),
  description varchar NULL, -- name if set card does not exist, or ad description
  is_foil bool NOT NULL DEFAULT(0), -- TODO: check syntax
  is_ad bool NOT NULL DEFAULT(0), -- TODO: check syntax

  --CONSTRAINT unique__booster_pack_contents__......
);

/* TODO: Should boosters themselves be a "container"?
         Then, a card belongs to a booster, which belongs to a box (or nothing?).
   TODO: Create lookup table for container columns.
   TODO: Users and related tables (algorithms, personas).
   TODO: Add columns to tables to keep track of which persona modified a table, and when.
*/
