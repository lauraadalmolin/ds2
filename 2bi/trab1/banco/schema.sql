CREATE TABLE comunicadores (
	id_c SERIAL NOT NULL PRIMARY KEY,
	nome VARCHAR (40)
);

CREATE TABLE programas (
	id_p SERIAL NOT NULL PRIMARY KEY,
	id_c INTEGER NOT NULL REFERENCES comunicadores (id_c) ON DELETE CASCADE,
	nome VARCHAR (60),
	duracao INTEGER,
	dias_da_semana VARCHAR (150),
	hora_inicio INTEGER,
	hora_fim INTEGER
);