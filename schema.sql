-- If you want to run this schema repeatedly you'll need to drop
-- the table before re-creating it. Note that you'll lose any
-- data if you drop and add a table:

DROP TABLE IF EXISTS programmers CASCADE;
DROP TABLE IF EXISTS technologies CASCADE;
DROP TABLE IF EXISTS programmers_technologies CASCADE;
-- Define your schema here:

CREATE TABLE programmers (
  id SERIAL PRIMARY KEY,
  programmer VARCHAR(255) NOT NULL,
  experience INTEGER NOT NULL,
  is_senior VARCHAR(255) NOT NULL,
  friend_id INTEGER
);

CREATE TABLE technologies (
  id SERIAL PRIMARY KEY,
  technology VARCHAR(255) NOT NULL
);


CREATE TABLE programmers_technologies (
  programmer_id INTEGER REFERENCES programmers(id),
  technology_id INTEGER NULL REFERENCES technologies(id)
);

INSERT INTO programmers (
  id, programmer, experience, is_senior , friend_id)
  VALUES (1,'Stallman',4,0,6),(2,'knuth',8,1,6),(3,'venema',1,0,8),(4,'gates',9,'true',NULL),(5,'hopper',3,0,3),(6,'van rossum',4,0,1),(7,'Jake',9,1,7),(8,'stroustrup',7,1,6);
INSERT INTO technologies (id, technology)
  VALUES (1,'c++'),(2,'python'),(3,'emacs'),(4,'postfix'),(5,'microsoft bob'),(6,'tex'),(7,'cobol');
INSERT INTO programmers_technologies (programmer_id, technology_id)
  VALUES (6,2),(2,6),(5,null),(7,3),(3,2),(8,1);
