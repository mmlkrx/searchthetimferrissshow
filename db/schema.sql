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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: episodes; Type: TABLE; Schema: public; Owner: stfs
--

CREATE TABLE public.episodes (
    id integer NOT NULL,
    title text,
    document tsvector,
    show_notes_url text,
    transcript text
);


ALTER TABLE public.episodes OWNER TO stfs;

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

--
-- Name: episodes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: stfs
--

ALTER SEQUENCE public.episodes_id_seq OWNED BY public.episodes.id;


--
-- Name: episodes id; Type: DEFAULT; Schema: public; Owner: stfs
--

ALTER TABLE ONLY public.episodes ALTER COLUMN id SET DEFAULT nextval('public.episodes_id_seq'::regclass);


--
-- Name: episodes episodes_pkey; Type: CONSTRAINT; Schema: public; Owner: stfs
--

ALTER TABLE ONLY public.episodes
    ADD CONSTRAINT episodes_pkey PRIMARY KEY (id);


--
-- Name: episodes_document_idx; Type: INDEX; Schema: public; Owner: stfs
--

CREATE INDEX episodes_document_idx ON public.episodes USING gin (document);


--
-- PostgreSQL database dump complete
--

