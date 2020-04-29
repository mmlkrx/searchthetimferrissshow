--
-- PostgreSQL database dump
--

-- Dumped from database version 12.2 (Debian 12.2-2.pgdg100+1)
-- Dumped by pg_dump version 12.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: episodes_id_seq; Type: SEQUENCE; Schema: public; Owner: stfs
--

CREATE SEQUENCE public.episodes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.episodes_id_seq OWNER TO stfs;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: episodes; Type: TABLE; Schema: public; Owner: stfs
--

CREATE TABLE public.episodes (
    id integer DEFAULT nextval('public.episodes_id_seq'::regclass) NOT NULL,
    title text,
    show_notes_url text,
    transcript text,
    number smallint NOT NULL,
    transcript_ts tsvector
);


ALTER TABLE public.episodes OWNER TO stfs;

--
-- Name: episodes episodes_number_key; Type: CONSTRAINT; Schema: public; Owner: stfs
--

ALTER TABLE ONLY public.episodes
    ADD CONSTRAINT episodes_number_key UNIQUE (number);


--
-- Name: episodes episodes_pkey; Type: CONSTRAINT; Schema: public; Owner: stfs
--

ALTER TABLE ONLY public.episodes
    ADD CONSTRAINT episodes_pkey PRIMARY KEY (id);


--
-- PostgreSQL database dump complete
--

