-- -*- sql -*- --

DROP TABLE IF EXISTS algorithms CASCADE;
CREATE TABLE algorithms (
  id SERIAL PRIMARY KEY,
  name varchar NOT NULL,
  description varchar NULL,

  CONSTRAINT unique__algorithms__name UNIQUE(name)
);

DROP TABLE IF EXISTS users CASCADE;
CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name varchar NOT NULL,
  password_hash varchar NULL,
  first_name varchar NULL,
  middle_name varchar NULL,
  last_name varchar NULL,
  email varchar NULL,
  date_created timestamp with time zone NOT NULL DEFAULT CURRENT_TIMESTAMP,
  is_active boolean NOT NULL DEFAULT TRUE,

  CONSTRAINT unique__users__name UNIQUE(name)
);

DROP TABLE IF EXISTS personas CASCADE;
CREATE TABLE personas (
  id SERIAL PRIMARY KEY,
  user_id INT NOT NULL REFERENCES users(id),
  algorithm_id INT NOT NULL REFERENCES algorithms(id),
  version varchar NOT NULL,

  CONSTRAINT unique__personas__user_algorithm_version UNIQUE(user_id, algorithm_id, version)
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

-- TODO: Determine if these table are needed.  This kind of data tracking
--       might be beyond the scope of this application (where the string of
--       the card's type in the cards table might be sufficient).
---- All of the possible card types (enchantment, creature, etc.).
--DROP TABLE IF EXISTS card_types CASCADE;
--CREATE TABLE card_types (
--  id SERIAL PRIMARY KEY,
--  name varchar NOT NULL,
--
--  CONSTRAINT unique__card_types__name UNIQUE(name)
--);
--
---- TODO: Get a better name for this.
----DROP TABLE IF EXISTS card_card_types CASCADE;
----CREATE TABLE card_card_types (
--  id SERIAL PRIMARY KEY,
--  card_id int REFERENCES cards(id),
--  type_id int REFERENCES card_types(id),
--
--  CONSTRAINT unique__card_card_types__card_type UNIQUE(card_id, type_id)
--);

-- Stores the rulings for each card.
DROP TABLE IF EXISTS oracle_rulings CASCADE;
CREATE TABLE oracle_rulings (
  id SERIAL PRIMARY KEY,
  card_id INT NOT NULL REFERENCES cards(id),
  rank SMALLINT NOT NULL,
  ruling_date DATE NOT NULL,
  ruling_text varchar NOT NULL,

  CONSTRAINT unique__oracle_rulings__card_id_rank UNIQUE(card_id, rank)
);

DROP TABLE IF EXISTS sets CASCADE;
CREATE TABLE sets (
  id SERIAL PRIMARY KEY,
  name varchar NOT NULL,
  release_date DATE NOT NULL,
  size int NOT NULL,
  expansion_code varchar NOT NULL,

  CONSTRAINT unique__sets__name UNIQUE(name)
);

DROP SEQUENCE IF EXISTS rarities_id_seq CASCADE;
DROP TABLE IF EXISTS rarities CASCADE;
CREATE SEQUENCE rarities_id_seq;
CREATE TABLE rarities (
  id SMALLINT NOT NULL DEFAULT nextval('rarities_id_seq') PRIMARY KEY,
  name varchar NOT NULL,
  relative_rarity int NOT NULL, -- partial order of rarities
    -- 1 = land, 2 = common, 3 = uncommon, 4 = rare, 5 = mythic

  CONSTRAINT unique__rarities__name UNIQUE(name)
);
ALTER SEQUENCE rarities_id_seq OWNED BY rarities.id;

DROP TABLE IF EXISTS artists CASCADE;
CREATE TABLE artists (
  id SERIAL PRIMARY KEY,
  name varchar NOT NULL,

  CONSTRAINT unique__artists__name UNIQUE(name)
);

DROP TABLE IF EXISTS card_printings CASCADE;
CREATE TABLE card_printings (
  id SERIAL PRIMARY KEY,
  card_id INT NOT NULL REFERENCES cards(id),
  set_id INT NOT NULL REFERENCES sets(id),
  rarity_id SMALLINT NOT NULL REFERENCES rarities(id),
  multiverse_id INT NULL,
  type_text varchar NOT NULL,
  card_text varchar NULL,
  flavor_text varchar NULL,
  card_number int NULL,
  artist int NULL REFERENCES artists(id),

  CONSTRAINT unique__card_printings__card_set UNIQUE(card_id, set_id)
);

DROP TABLE IF EXISTS booster_versions CASCADE;
CREATE TABLE booster_versions (
  id SERIAL PRIMARY KEY,
  set_id INT NOT NULL REFERENCES sets(id),
  card_printing_id INT NOT NULL REFERENCES card_printings(id),
  serial VARCHAR NOT NULL,

  CONSTRAINT unique__booster_versions__serial UNIQUE(serial)
);

-- "booster box", "fat pack", "loose packs", etc.
DROP SEQUENCE IF EXISTS container_types_id_seq CASCADE;
DROP TABLE IF EXISTS container_types CASCADE;
CREATE SEQUENCE container_types_id_seq;
CREATE TABLE container_types (
  id SMALLINT NOT NULL DEFAULT nextval('container_types_id_seq') PRIMARY KEY,
  name varchar NOT NULL,
  description varchar NULL,

  CONSTRAINT unique__container_types__name UNIQUE(name)
);
ALTER SEQUENCE container_types_id_seq OWNED BY container_types.id;

-- TODO: get a better name for this
DROP TABLE IF EXISTS containers CASCADE;
CREATE TABLE containers (
  id SERIAL PRIMARY KEY,
  name varchar NULL, -- computed "code" that is human readable
  container_type_id SMALLINT NOT NULL references container_types(id),
  parent_container_id INT NULL references containers(id),
  --set_id INT NOT NULL references sets(id), -- do not have this, as it could be mixed
  number_of_packs INT NOT NULL,
  price NUMERIC(10, 3) NULL,
  source varchar NULL, -- where the container was obtained
  opener_id INT NULL REFERENCES users(id),
  open_date DATE NULL
);

DROP TABLE IF EXISTS booster_packs CASCADE;
CREATE TABLE booster_packs (
  id SERIAL PRIMARY KEY,
  name varchar NULL, -- computed "code" that is human readable
  set_id INT NOT NULL references sets(id),
  booster_version_id INT NULL references booster_versions(id),
  code VARCHAR NULL,

  -- TODO: Move these three columns into a mapping table between containers
  --       and boosters?
  container_id INT NULL references containers(id),
  container_column varchar NULL, -- column in container (for boxes specifically); TODO: lookup table?
  container_rank INT NULL, -- rank in the container

  price NUMERIC(10, 3) NULL,
  source varchar NULL, -- where the booster was obtained
  opener_id INT NULL REFERENCES users(id),
  open_date DATE NULL
);

DROP TABLE IF EXISTS booster_pack_contents CASCADE;
CREATE TABLE booster_pack_contents (
  id SERIAL PRIMARY KEY, -- TOOD: bigserial? check size
  card_printing_id INT NULL REFERENCES card_printings(id),
  description varchar NULL, -- name if set card does not exist, or ad description
  is_foil boolean NOT NULL DEFAULT FALSE,
  is_ad boolean NOT NULL DEFAULT FALSE

  --CONSTRAINT unique__booster_pack_contents__......
);

/* TODO: Should boosters themselves be a "container"?
         Then, a card belongs to a booster, which belongs to a box (or nothing?).
   TODO: Create lookup table for container columns.
   TODO: Add columns to tables to keep track of which persona modified a table, and when.
   TODO: Add tables and columns to keep track of formats.
*/
