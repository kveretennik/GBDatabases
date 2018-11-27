USE world;

#################################################################################
CREATE TABLE IF NOT EXISTS world._countries (
  country_id INT NOT NULL,
  country_name VARCHAR(100) NOT NULL,
  country_code VARCHAR(3) NOT NULL,
  PRIMARY KEY (country_id),
  UNIQUE INDEX country_id_UNIQUE (country_id ASC))
ENGINE = InnoDB;

ALTER TABLE world._countries
CHANGE COLUMN country_id id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE world._countries
RENAME INDEX country_id_UNIQUE TO id_UNIQUE;

ALTER TABLE world._countries
CHANGE COLUMN country_name title VARCHAR(150);

ALTER TABLE world._countries
ADD INDEX _countries_title_n1 USING BTREE (title);

ALTER TABLE world._countries
DROP COLUMN country_code;

#################################################################################
CREATE TABLE IF NOT EXISTS world._regions (
  region_id INT NOT NULL,
  region_name VARCHAR(100) NOT NULL,
  country_id INT NOT NULL,
  PRIMARY KEY (region_id),
  UNIQUE INDEX region_id_UNIQUE (region_id ASC))
ENGINE = InnoDB;

ALTER TABLE world._regions
CHANGE COLUMN region_id id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE world._regions
ADD FOREIGN KEY _regions_country_id_fk(country_id)
	REFERENCES world._countries (id) 
		ON DELETE RESTRICT
		ON UPDATE CASCADE;
        
ALTER TABLE world._regions
CHANGE COLUMN region_name title VARCHAR(150);
        
ALTER TABLE world._regions
RENAME INDEX region_id_UNIQUE TO id_UNIQUE;

ALTER TABLE world._regions
ADD INDEX _regions_title_n1 USING BTREE (title);

#################################################################################
DROP TABLE world._localities;

CREATE TABLE IF NOT EXISTS world._localities (
  loacality_id INT NOT NULL,
  locality_name VARCHAR(100) NOT NULL,
  locality_type_id INT NOT NULL,
  country_id INT NOT NULL,
  region_id INT NOT NULL,
  district_id INT NULL,
  PRIMARY KEY (loacality_id),
  UNIQUE INDEX loacality_id_UNIQUE (loacality_id ASC),
  INDEX localities_country_id_fk_idx (country_id ASC),
  INDEX localities_region_id_fk_idx (region_id ASC),
  INDEX localities_district_id_fk_idx (district_id ASC),
  INDEX localities_locality_type_id_fk_idx (locality_type_id ASC),
  CONSTRAINT _localities_country_id_fk
    FOREIGN KEY (country_id)
    REFERENCES world.countries (country_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT _localities_region_id_fk
    FOREIGN KEY (region_id)
    REFERENCES world.regions (region_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT _localities_district_id_fk
    FOREIGN KEY (district_id)
    REFERENCES world.districts (district_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT _localities_locality_type_id_fk
    FOREIGN KEY (locality_type_id)
    REFERENCES world.locality_types (locality_type_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

ALTER TABLE world._localities
DROP FOREIGN KEY _localities_locality_type_id_fk;

ALTER TABLE world._localities
DROP FOREIGN KEY _localities_district_id_fk;

ALTER TABLE world._localities
DROP FOREIGN KEY _localities_country_id_fk;

ALTER TABLE world._localities
DROP FOREIGN KEY _localities_region_id_fk;

ALTER TABLE world._localities
DROP COLUMN locality_type_id;

ALTER TABLE world._localities
DROP COLUMN district_id;

ALTER TABLE world._localities
CHANGE COLUMN loacality_id id INT NOT NULL AUTO_INCREMENT;

ALTER TABLE world._localities
RENAME INDEX loacality_id_UNIQUE TO id_UNIQUE;

ALTER TABLE world._localities
CHANGE COLUMN locality_name title VARCHAR(150);

ALTER TABLE world._localities
ADD INDEX _localities_title_n1 USING BTREE (title);

ALTER TABLE world._localities
ADD FOREIGN KEY _localities_country_id_fk(country_id)
	REFERENCES world._countries (id) 
		ON DELETE RESTRICT
		ON UPDATE CASCADE;
        
ALTER TABLE world._localities
ADD FOREIGN KEY _localities_region_id_fk(region_id)
	REFERENCES world._regions (id) 
		ON DELETE RESTRICT
		ON UPDATE CASCADE;
        
ALTER TABLE world._localities
ADD COLUMN important TINYINT(1) NOT NULL;



