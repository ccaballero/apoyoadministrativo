CREATE TABLE `departamento` (
    `ident`             int unsigned               NOT NULL auto_increment,
    `name`              varchar(128)               NOT NULL,
    `status`            enum('enabled','disabled') NOT NULL DEFAULT 'enabled',
    `abbreviation`      varchar(32)                NOT NULL,
    `facultad`          varchar(64)                NOT NULL DEFAULT '',
    `tsregister`        timestamp                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`ident`),
    UNIQUE KEY (`name`),
    UNIQUE KEY (`abbreviation`)
) DEFAULT CHARACTER SET UTF8 ENGINE = INNODB;

CREATE TABLE `carrera` (
    `ident`             int unsigned               NOT NULL auto_increment,
    `departamento`      int unsigned               NOT NULL,
    `name`              varchar(128)               NOT NULL,
    `abbreviation`      varchar(32)                NOT NULL,
    `status`            enum('enabled','disabled') NOT NULL DEFAULT 'enabled',
    `tsregister`        timestamp                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`ident`, `departamento`),
    UNIQUE KEY (`name`),
    INDEX (`departamento`),
    FOREIGN KEY (`departamento`)
    REFERENCES `departamento`(`ident`)
    ON UPDATE CASCADE ON DELETE RESTRICT
) DEFAULT CHARACTER SET UTF8 ENGINE = INNODB;

CREATE TABLE `plan_estudio` (
    `ident`             int unsigned               NOT NULL auto_increment,
    `departamento`      int unsigned               NOT NULL,
    `carrera`           int unsigned               NOT NULL,
    `name`              varchar(128)               NOT NULL,
    `code`              varchar(16)                NOT NULL,
    `status`            enum('enabled','disabled') NOT NULL DEFAULT 'enabled',
    `tsregister`        timestamp                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`ident`, `departamento`, `carrera`),
    UNIQUE KEY (`name`),
    UNIQUE KEY (`code`),
    INDEX (`departamento`, `carrera`),
    FOREIGN KEY (`departamento`, `carrera`)
    REFERENCES `carrera`(`departamento`, `ident`)
    ON UPDATE CASCADE ON DELETE RESTRICT
) DEFAULT CHARACTER SET UTF8 ENGINE = INNODB;

CREATE TABLE `gestion` (
    `ident`             int unsigned               NOT NULL auto_increment,
    `name`              varchar(128)               NOT NULL,
    `status`            enum('enabled','disabled','active') NOT NULL DEFAULT 'enabled',
    `tsregister`        timestamp                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`ident`),
    UNIQUE KEY (`name`)
) DEFAULT CHARACTER SET UTF8 ENGINE = INNODB;

CREATE TABLE `materia` (
    `ident`             int unsigned               NOT NULL auto_increment,
    `departamento`      int unsigned               NOT NULL,
    `name`              varchar(128)               NOT NULL,
    `code`              varchar(16)                NOT NULL,
    `status`            enum('enabled','disabled') NOT NULL DEFAULT 'enabled',
    `tsregister`        timestamp                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`ident`, `departamento`),
    UNIQUE KEY (`name`),
    UNIQUE KEY (`code`),
    INDEX (`departamento`),
    FOREIGN KEY (`departamento`)
    REFERENCES `departamento`(`ident`)
    ON UPDATE CASCADE ON DELETE RESTRICT
) DEFAULT CHARACTER SET UTF8 ENGINE = INNODB;

CREATE TABLE `docente` (
    `ident`             int unsigned               NOT NULL auto_increment,
    `ci`                varchar(64)                NULL,
    `apellido_paterno`  varchar(128)               NOT NULL,
    `apellido_materno`  varchar(128)               NOT NULL,
    `nombres`           varchar(128)               NOT NULL,
    `diploma`           varchar(128)               NOT NULL DEFAULT '',
    `titulo`            varchar(128)               NOT NULL DEFAULT '',
    `tsregister`        timestamp                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`ident`),
    UNIQUE KEY (`ci`),
    UNIQUE KEY (`apellido_paterno`, `apellido_materno`, `nombres`)
) DEFAULT CHARACTER SET UTF8 ENGINE = INNODB;

CREATE TABLE `auxiliar` (
    `ident`             int unsigned               NOT NULL auto_increment,
    `ci`                varchar(64)                NOT NULL,
    `apellido_paterno`  varchar(128)               NOT NULL,
    `apellido_materno`  varchar(128)               NOT NULL,
    `nombres`           varchar(128)               NOT NULL,
    `tsregister`        timestamp                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`ident`),
    UNIQUE KEY (`ci`),
    UNIQUE KEY (`apellido_paterno`, `apellido_materno`, `nombres`)
) DEFAULT CHARACTER SET UTF8 ENGINE = INNODB;

CREATE TABLE `horario` (
    `ident`             int unsigned               NOT NULL auto_increment,
    `tsregister`        timestamp                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`ident`)
) DEFAULT CHARACTER SET UTF8 ENGINE = INNODB;

CREATE TABLE `periodo` (
    `ident`             int unsigned                  NOT NULL auto_increment,
    `horario`           int unsigned                  NOT NULL,
    `aula`              varchar(16)                   NOT NULL,
    `dia`               enum('L','M','X','J','V','S') NOT NULL,
    `hora`              int unsigned                  NOT NULL,
    `duracion`          int unsigned                  NOT NULL,
    `tsregister`        timestamp                     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`ident`, `horario`),
    INDEX (`horario`),
    FOREIGN KEY (`horario`)
    REFERENCES `horario`(`ident`)
    ON UPDATE CASCADE ON DELETE RESTRICT
);

CREATE TABLE `grupo` (
    `ident`             int unsigned               NOT NULL auto_increment,
    `departamento`      int unsigned               NOT NULL,
    `materia`           int unsigned               NOT NULL,
    `gestion`           int unsigned               NOT NULL,
    `docente`           int unsigned               NULL,
    `auxiliar`          int unsigned               NULL,
    `horario`           int unsigned               NULL,
    `name`              varchar(128)               NOT NULL,
    `status`            enum('enabled','disabled') NOT NULL DEFAULT 'enabled',
    `tsregister`        timestamp                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`ident`, `departamento`, `materia`, `gestion`),
    UNIQUE KEY (`name`),
    INDEX (`departamento`, `materia`),
    FOREIGN KEY (`departamento`, `materia`)
    REFERENCES `materia`(`departamento`, `ident`)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX (`gestion`),
    FOREIGN KEY (`gestion`)
    REFERENCES `gestion`(`ident`)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX (`docente`),
    FOREIGN KEY (`docente`)
    REFERENCES `docente`(`ident`)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX (`auxiliar`),
    FOREIGN KEY (`auxiliar`)
    REFERENCES `auxiliar`(`ident`)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX (`horario`),
    FOREIGN KEY (`horario`)
    REFERENCES `horario`(`ident`)
    ON UPDATE CASCADE ON DELETE RESTRICT
) DEFAULT CHARACTER SET UTF8 ENGINE = INNODB;

CREATE TABLE `malla_curricular` (
    `departamento`      int unsigned               NOT NULL,
    `carrera`           int unsigned               NOT NULL,
    `plan`              int unsigned               NOT NULL,
    `departamento2`     int unsigned               NOT NULL,
    `materia`           int unsigned               NOT NULL,
    `type`              enum('C', 'NC')            NOT NULL DEFAULT 'C',
    `level`             char(1)                    NOT NULL DEFAULT '',
    PRIMARY KEY (`departamento`, `carrera`, `plan`, `departamento2`, `materia`),
    INDEX (`departamento`, `carrera`, `plan`),
    FOREIGN KEY (`departamento`, `carrera`, `plan`)
    REFERENCES `plan_estudio`(`departamento`, `carrera`, `ident`)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX (`departamento2`, `materia`),
    FOREIGN KEY (`departamento2`, `materia`)
    REFERENCES `materia`(`departamento`, `ident`)
    ON UPDATE CASCADE ON DELETE RESTRICT
) DEFAULT CHARACTER SET UTF8 ENGINE = INNODB;

CREATE TABLE `prerequisito` (
    `departamento`      int unsigned               NOT NULL,
    `carrera`           int unsigned               NOT NULL,
    `plan`              int unsigned               NOT NULL,
    `departamento2`     int unsigned               NOT NULL,
    `materia`           int unsigned               NOT NULL,
    `req_departamento`  int unsigned               NOT NULL,
    `req_carrera`       int unsigned               NOT NULL,
    `req_plan`          int unsigned               NOT NULL,
    `req_departamento2` int unsigned               NOT NULL,
    `req_materia`       int unsigned               NOT NULL,
    PRIMARY KEY (`departamento`, `carrera`, `plan`, `departamento2`, `materia`, `req_departamento`, `req_carrera`, `req_plan`, `req_departamento2`, `req_materia`),
    INDEX (`departamento`, `carrera`, `plan`, `departamento2`, `materia`),
    FOREIGN KEY (`departamento`, `carrera`, `plan`, `departamento2`, `materia`)
    REFERENCES `malla_curricular`(`departamento`, `carrera`, `plan`, `departamento2`, `materia`)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX (`req_departamento`, `req_carrera`, `req_plan`, `req_departamento2`, `req_materia`),
    FOREIGN KEY (`req_departamento`, `req_carrera`, `req_plan`, `req_departamento2`, `req_materia`)
    REFERENCES `malla_curricular`(`departamento`, `carrera`, `plan`, `departamento2`, `materia`)
    ON UPDATE CASCADE ON DELETE RESTRICT
) DEFAULT CHARACTER SET UTF8 ENGINE = INNODB;

CREATE TABLE `laboratorio` (
    `ident`             int unsigned               NOT NULL auto_increment,
    `departamento`      int unsigned               NOT NULL,
    `name`              varchar(128)               NOT NULL,
    `code`              varchar(16)                NOT NULL,
    `status`            enum('enabled','disabled') NOT NULL DEFAULT 'enabled',
    `tsregister`        timestamp                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`ident`, `departamento`),
    UNIQUE KEY (`name`),
    UNIQUE KEY (`code`),
    INDEX (`departamento`),
    FOREIGN KEY (`departamento`)
    REFERENCES `departamento`(`ident`)
    ON UPDATE CASCADE ON DELETE RESTRICT
) DEFAULT CHARACTER SET UTF8 ENGINE = INNODB;

CREATE TABLE `item` (
    `ident`             int unsigned               NOT NULL auto_increment,
    `departamento`      int unsigned               NOT NULL,
    `laboratorio`       int unsigned               NOT NULL,
    `gestion`           int unsigned               NOT NULL,
    `auxiliar`          int unsigned               NULL,
    `horario`           int unsigned               NULL,
    `name`              varchar(128)               NOT NULL,
    `status`            enum('enabled','disabled') NOT NULL DEFAULT 'enabled',
    `tsregister`        timestamp                  NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`ident`, `departamento`, `laboratorio`, `gestion`),
    UNIQUE KEY (`name`),
    INDEX (`departamento`, `laboratorio`),
    FOREIGN KEY (`departamento`, `laboratorio`)
    REFERENCES `laboratorio`(`departamento`, `ident`)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX (`gestion`),
    FOREIGN KEY (`gestion`)
    REFERENCES `gestion`(`ident`)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX (`auxiliar`),
    FOREIGN KEY (`auxiliar`)
    REFERENCES `auxiliar`(`ident`)
    ON UPDATE CASCADE ON DELETE RESTRICT,
    INDEX (`horario`),
    FOREIGN KEY (`horario`)
    REFERENCES `horario`(`ident`)
    ON UPDATE CASCADE ON DELETE RESTRICT
) DEFAULT CHARACTER SET UTF8 ENGINE = INNODB;
