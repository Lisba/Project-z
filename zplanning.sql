-- This script was generated by a beta version of the ERD tool in pgAdmin 4.
-- Please log an issue at https://redmine.postgresql.org/projects/pgadmin4/issues/new if you find any bugs, including reproduction steps.
BEGIN;
​
CREATE SEQUENCE user_id_seq
INCREMENT 1
START 1;
​
CREATE SEQUENCE voteSession_id_seq
INCREMENT 1
START 1;
​
CREATE SEQUENCE card_id_seq
INCREMENT 1
START 1;
​
CREATE SEQUENCE team_id_seq
INCREMENT 1
START 1;
​
CREATE TABLE IF NOT EXISTS public."user"
(
    id integer NOT NULL DEFAULT nextval('user_id_seq'),
    first_name text NOT NULL,
    last_name text NOT NULL,
    email text NOT NULL,
    password text NOT NULL,
    role text NOT NULL,
    PRIMARY KEY (id)
);
​
CREATE TABLE IF NOT EXISTS public."voteSession"
(
    id integer NOT NULL DEFAULT nextval('voteSession_id_seq'),
    created_at date NOT NULL,
    title text NOT NULL,
    description text NOT NULL,
    user_id integer,
    CONSTRAINT vote_session_id PRIMARY KEY (id)
);
​
CREATE TABLE IF NOT EXISTS public.card
(
    id integer NOT NULL DEFAULT nextval('card_id_seq'),
    title text NOT NULL,
    link text NOT NULL,
    PRIMARY KEY (id)
);
​
CREATE TABLE IF NOT EXISTS public.team
(
    id integer NOT NULL DEFAULT nextval('team_id_seq'),
    name text NOT NULL,
    PRIMARY KEY (id)
);
​
CREATE TABLE IF NOT EXISTS public."user_voteSession"
(
    user_id integer NOT NULL,
    vote_session_id integer NOT NULL,
    PRIMARY KEY (user_id, vote_session_id)
);
​
CREATE TABLE IF NOT EXISTS public."card_voteSession"
(
    card_id integer NOT NULL,
    vote_session_id integer NOT NULL,
    final_score integer,
    PRIMARY KEY (card_id, vote_session_id)
);
​
CREATE TABLE IF NOT EXISTS public."team_voteSession"
(
    team_id integer NOT NULL,
    vote_session_id integer NOT NULL,
    PRIMARY KEY (team_id, vote_session_id)
);
​
CREATE TABLE IF NOT EXISTS public.user_team
(
    team_id integer NOT NULL,
    user_id integer NOT NULL,
    PRIMARY KEY (team_id, user_id)
);
​
ALTER TABLE IF EXISTS public."voteSession"
    ADD CONSTRAINT user_id_fkey FOREIGN KEY (user_id)
    REFERENCES public."user" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
​
​
ALTER TABLE IF EXISTS public."user_voteSession"
    ADD CONSTRAINT user_id FOREIGN KEY (user_id)
    REFERENCES public."user" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
​
​
ALTER TABLE IF EXISTS public."user_voteSession"
    ADD CONSTRAINT vote_session_id FOREIGN KEY (vote_session_id)
    REFERENCES public."voteSession" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
​
​
ALTER TABLE IF EXISTS public."card_voteSession"
    ADD CONSTRAINT card_id FOREIGN KEY (card_id)
    REFERENCES public.card (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
​
​
ALTER TABLE IF EXISTS public."card_voteSession"
    ADD CONSTRAINT vote_session_id FOREIGN KEY (vote_session_id)
    REFERENCES public."voteSession" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
​
​
ALTER TABLE IF EXISTS public."team_voteSession"
    ADD CONSTRAINT team_id FOREIGN KEY (team_id)
    REFERENCES public.team (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
​
​
ALTER TABLE IF EXISTS public."team_voteSession"
    ADD CONSTRAINT vote_session_id FOREIGN KEY (vote_session_id)
    REFERENCES public."voteSession" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
​
​
ALTER TABLE IF EXISTS public.user_team
    ADD CONSTRAINT team_id FOREIGN KEY (team_id)
    REFERENCES public.team (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
​
​
ALTER TABLE IF EXISTS public.user_team
    ADD CONSTRAINT user_id FOREIGN KEY (user_id)
    REFERENCES public."user" (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;
​
END;