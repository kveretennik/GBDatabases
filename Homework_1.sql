CREATE SCHEMA world;	

CREATE TABLE IF NOT EXISTS world.countries (
  country_id INT NOT NULL,
  country_name VARCHAR(100) NOT NULL,
  country_code VARCHAR(3) NOT NULL,
  PRIMARY KEY (country_id),
  UNIQUE INDEX country_id_UNIQUE (country_id ASC))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS world.regions (
  region_id INT NOT NULL,
  region_name VARCHAR(100) NOT NULL,
  country_id INT NOT NULL,
  PRIMARY KEY (region_id),
  UNIQUE INDEX region_id_UNIQUE (region_id ASC),
  INDEX regions_country_id_fk_idx (country_id ASC),
  CONSTRAINT regions_country_id_fk
    FOREIGN KEY (country_id)
    REFERENCES world.countries (country_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS world.districts (
  district_id INT NOT NULL,
  district_name VARCHAR(100) NOT NULL,
  country_id INT NOT NULL,
  region_id INT NOT NULL,
  PRIMARY KEY (district_id),
  UNIQUE INDEX district_id_UNIQUE (district_id ASC),
  INDEX districts_coutry_id_fk_idx (country_id ASC),
  INDEX districts_region_id_fk_idx (region_id ASC),
  CONSTRAINT districts_country_id_fk
    FOREIGN KEY (country_id)
    REFERENCES world.countries (country_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT districts_region_id_fk
    FOREIGN KEY (region_id)
    REFERENCES world.regions (region_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS world.locality_types (
  locality_type_id INT NOT NULL,
  locality_type_long_name VARCHAR(30) NOT NULL,
  locality_type_short_name VARCHAR(10) NOT NULL,
  PRIMARY KEY (locality_type_id),
  UNIQUE INDEX locality_type_id_UNIQUE (locality_type_id ASC))
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS world.localities (
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
  CONSTRAINT localities_country_id_fk
    FOREIGN KEY (country_id)
    REFERENCES world.countries (country_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT localities_region_id_fk
    FOREIGN KEY (region_id)
    REFERENCES world.regions (region_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT localities_district_id_fk
    FOREIGN KEY (district_id)
    REFERENCES world.districts (district_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT localities_locality_type_id_fk
    FOREIGN KEY (locality_type_id)
    REFERENCES world.locality_types (locality_type_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS world.addresses (
  address_id INT NOT NULL,
  country_id INT NOT NULL,
  region_id INT NOT NULL,
  district_id INT NULL,
  locality_id INT NOT NULL,
  PRIMARY KEY (address_id),
  UNIQUE INDEX address_id_UNIQUE (address_id ASC),
  INDEX addresses_locality_id_fk_idx (locality_id ASC),
  INDEX addresses_district_id_fk_idx (district_id ASC),
  INDEX addresses_region_id_fk_idx (region_id ASC),
  INDEX addresses_country_id_fk_idx (country_id ASC),
  CONSTRAINT addresses_country_id_fk
    FOREIGN KEY (country_id)
    REFERENCES world.countries (country_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT addresses_region_id_fk
    FOREIGN KEY (region_id)
    REFERENCES world.regions (region_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT addresses_district_id_fk
    FOREIGN KEY (district_id)
    REFERENCES world.districts (district_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT addresses_locality_id_fk
    FOREIGN KEY (locality_id)
    REFERENCES world.localities (loacality_id)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;