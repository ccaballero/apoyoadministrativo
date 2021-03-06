INSERT INTO `departamento`(`name`,`abbreviation`,`facultad`)
VALUES
('No definido',                          'No definido',          'Ciencias y Tecnología'),
('Departamento de Biología',             'Biología',             'Ciencias y Tecnología'),
('Departamento de Civil',                'Civil',                'Ciencias y Tecnología'),
('Departamento de Eléctrica',            'Eléctrica',            'Ciencias y Tecnología'),
('Departamento de Física',               'Física',               'Ciencias y Tecnología'),
('Departamento de Industrias',           'Industrias',           'Ciencias y Tecnología'),
('Departamento de Informática-Sistemas', 'Informática-Sistemas', 'Ciencias y Tecnología'),
('Departamento de Matemáticas',          'Matemáticas',          'Ciencias y Tecnología'),
('Departamento de Mecánica',             'Mecánica',             'Ciencias y Tecnología'),
('Departamento de Química',              'Química',              'Ciencias y Tecnología');

UPDATE `departamento` SET `status` = 'disabled' WHERE `ident` = 1;
