--
-- PostgreSQL database dump
--

-- Dumped from database version 10.5
-- Dumped by pg_dump version 10.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: actions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.actions (
    id integer NOT NULL,
    name character varying NOT NULL,
    started_at timestamp without time zone,
    finished_at timestamp without time zone,
    succeeded boolean,
    error_id integer,
    trigger character varying,
    params text,
    created_at timestamp without time zone NOT NULL
);


--
-- Name: actions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.actions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: actions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.actions_id_seq OWNED BY public.actions.id;


--
-- Name: api_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.api_tokens (
    id integer NOT NULL,
    name character varying NOT NULL,
    user_id integer NOT NULL,
    value character varying NOT NULL
);


--
-- Name: api_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.api_tokens_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: api_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.api_tokens_id_seq OWNED BY public.api_tokens.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: authorizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.authorizations (
    id integer NOT NULL,
    scope character varying,
    access_token character varying,
    refresh_token character varying,
    secret character varying,
    expires_in integer,
    expires_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    user_id integer NOT NULL,
    props jsonb DEFAULT '{}'::jsonb,
    type character varying NOT NULL
);


--
-- Name: authorizations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.authorizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: authorizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.authorizations_id_seq OWNED BY public.authorizations.id;


--
-- Name: commits; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.commits (
    id integer NOT NULL,
    sha character varying,
    message text,
    committer character varying,
    date date,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    committer_email character varying,
    project_id integer NOT NULL,
    authored_at timestamp without time zone NOT NULL,
    unreachable boolean DEFAULT false NOT NULL,
    parent_sha character varying
);


--
-- Name: commits_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.commits_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: commits_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.commits_id_seq OWNED BY public.commits.id;


--
-- Name: commits_pull_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.commits_pull_requests (
    commit_id integer,
    pull_request_id integer
);


--
-- Name: commits_tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.commits_tasks (
    commit_id integer,
    task_id integer
);


--
-- Name: commits_tickets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.commits_tickets (
    commit_id integer,
    ticket_id integer
);


--
-- Name: commits_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.commits_users (
    commit_id integer,
    user_id integer
);


--
-- Name: deploys; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.deploys (
    id integer NOT NULL,
    project_id integer,
    sha character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    environment_name character varying DEFAULT 'Production'::character varying NOT NULL,
    deployer character varying,
    commit_id integer,
    duration integer,
    branch character varying,
    completed_at timestamp without time zone,
    output text,
    user_id integer,
    successful boolean DEFAULT false NOT NULL
);


--
-- Name: deploys_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.deploys_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: deploys_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.deploys_id_seq OWNED BY public.deploys.id;


--
-- Name: errors; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.errors (
    id integer NOT NULL,
    sha character varying NOT NULL,
    message text NOT NULL,
    backtrace text NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    type character varying
);


--
-- Name: errors_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.errors_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: errors_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.errors_id_seq OWNED BY public.errors.id;


--
-- Name: follows; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.follows (
    id integer NOT NULL,
    user_id integer,
    project_id integer
);


--
-- Name: follows_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.follows_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: follows_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.follows_id_seq OWNED BY public.follows.id;


--
-- Name: measurements; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.measurements (
    id integer NOT NULL,
    subject_type character varying,
    subject_id integer,
    name character varying NOT NULL,
    value character varying NOT NULL,
    taken_at timestamp without time zone NOT NULL,
    taken_on date NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: measurements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.measurements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: measurements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.measurements_id_seq OWNED BY public.measurements.id;


--
-- Name: milestones; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.milestones (
    id integer NOT NULL,
    project_id integer NOT NULL,
    remote_id integer,
    name character varying NOT NULL,
    tickets_count integer DEFAULT 0,
    completed_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    destroyed_at timestamp without time zone,
    props jsonb DEFAULT '{}'::jsonb
);


--
-- Name: milestones_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.milestones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: milestones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.milestones_id_seq OWNED BY public.milestones.id;


--
-- Name: persistent_triggers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.persistent_triggers (
    id integer NOT NULL,
    type character varying NOT NULL,
    value text NOT NULL,
    params text DEFAULT '{}'::text NOT NULL,
    action character varying NOT NULL,
    user_id integer NOT NULL
);


--
-- Name: persistent_triggers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.persistent_triggers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: persistent_triggers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.persistent_triggers_id_seq OWNED BY public.persistent_triggers.id;


--
-- Name: projects; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.projects (
    id integer NOT NULL,
    name character varying NOT NULL,
    slug character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    color_name character varying DEFAULT 'default'::character varying NOT NULL,
    retired_at timestamp without time zone,
    category character varying,
    version_control_name character varying DEFAULT 'None'::character varying NOT NULL,
    ticket_tracker_name character varying DEFAULT 'None'::character varying NOT NULL,
    ci_server_name character varying DEFAULT 'None'::character varying NOT NULL,
    error_tracker_name character varying DEFAULT 'None'::character varying,
    last_ticket_tracker_sync_at timestamp without time zone,
    ticket_tracker_sync_started_at timestamp without time zone,
    selected_features text[],
    head_sha character varying,
    props jsonb DEFAULT '{}'::jsonb,
    team_id integer
);


--
-- Name: projects_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.projects_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: projects_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.projects_id_seq OWNED BY public.projects.id;


--
-- Name: pull_requests; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pull_requests (
    id integer NOT NULL,
    project_id integer NOT NULL,
    user_id integer,
    title character varying NOT NULL,
    number integer NOT NULL,
    repo character varying NOT NULL,
    username character varying NOT NULL,
    url character varying NOT NULL,
    base_ref character varying NOT NULL,
    base_sha character varying NOT NULL,
    head_ref character varying NOT NULL,
    head_sha character varying NOT NULL,
    body text,
    props jsonb DEFAULT '{}'::jsonb,
    avatar_url character varying,
    json_labels jsonb DEFAULT '[]'::jsonb,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    closed_at timestamp without time zone,
    merged_at timestamp without time zone
);


--
-- Name: pull_requests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pull_requests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pull_requests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pull_requests_id_seq OWNED BY public.pull_requests.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    user_id integer,
    project_id integer,
    name character varying NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.roles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: tasks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tasks (
    id integer NOT NULL,
    ticket_id integer NOT NULL,
    number integer NOT NULL,
    description character varying,
    effort numeric(6,2),
    first_release_at timestamp without time zone,
    first_commit_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    project_id integer NOT NULL,
    completed_at timestamp without time zone
);


--
-- Name: tasks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tasks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tasks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tasks_id_seq OWNED BY public.tasks.id;


--
-- Name: teams; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams (
    id integer NOT NULL,
    name character varying,
    props jsonb DEFAULT '{}'::jsonb
);


--
-- Name: teams_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.teams_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teams_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.teams_id_seq OWNED BY public.teams.id;


--
-- Name: teams_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.teams_users (
    id integer NOT NULL,
    team_id integer,
    user_id integer,
    roles character varying[],
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: teams_users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.teams_users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: teams_users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.teams_users_id_seq OWNED BY public.teams_users.id;


--
-- Name: tickets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tickets (
    id integer NOT NULL,
    project_id integer,
    number integer NOT NULL,
    summary character varying,
    description text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    remote_id integer,
    expires_at timestamp without time zone,
    tags character varying[],
    type character varying,
    closed_at timestamp without time zone,
    reporter_email character varying,
    reporter_id integer,
    milestone_id integer,
    destroyed_at timestamp without time zone,
    priority character varying DEFAULT 'normal'::character varying NOT NULL,
    props jsonb DEFAULT '{}'::jsonb,
    due_date date
);


--
-- Name: tickets_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.tickets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tickets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.tickets_id_seq OWNED BY public.tickets.id;


--
-- Name: tickets_versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.tickets_versions (
    id integer,
    versioned_type character varying,
    versioned_id integer,
    user_type character varying,
    user_id integer,
    user_name character varying,
    modifications text,
    number integer,
    reverted_from integer,
    tag character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: user_credentials; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.user_credentials (
    id integer NOT NULL,
    user_id integer,
    service character varying,
    login character varying,
    password bytea,
    password_key bytea,
    password_iv bytea,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: user_credentials_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.user_credentials_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_credentials_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.user_credentials_id_seq OWNED BY public.user_credentials.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    invitation_token character varying,
    invitation_sent_at timestamp without time zone,
    invitation_accepted_at timestamp without time zone,
    invitation_limit integer,
    invited_by_type character varying,
    invited_by_id integer,
    authentication_token character varying,
    first_name character varying,
    last_name character varying,
    retired_at timestamp without time zone,
    email_addresses text[],
    invitation_created_at timestamp without time zone,
    current_project_id integer,
    nickname character varying,
    username character varying,
    props jsonb DEFAULT '{}'::jsonb,
    role character varying DEFAULT 'Member'::character varying
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.versions (
    id integer NOT NULL,
    versioned_type character varying,
    versioned_id integer,
    user_type character varying,
    user_id integer,
    user_name character varying,
    modifications text,
    number integer,
    reverted_from integer,
    tag character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.versions_id_seq OWNED BY public.versions.id;


--
-- Name: actions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actions ALTER COLUMN id SET DEFAULT nextval('public.actions_id_seq'::regclass);


--
-- Name: api_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_tokens ALTER COLUMN id SET DEFAULT nextval('public.api_tokens_id_seq'::regclass);


--
-- Name: authorizations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authorizations ALTER COLUMN id SET DEFAULT nextval('public.authorizations_id_seq'::regclass);


--
-- Name: commits id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commits ALTER COLUMN id SET DEFAULT nextval('public.commits_id_seq'::regclass);


--
-- Name: deploys id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deploys ALTER COLUMN id SET DEFAULT nextval('public.deploys_id_seq'::regclass);


--
-- Name: errors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.errors ALTER COLUMN id SET DEFAULT nextval('public.errors_id_seq'::regclass);


--
-- Name: follows id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.follows ALTER COLUMN id SET DEFAULT nextval('public.follows_id_seq'::regclass);


--
-- Name: measurements id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.measurements ALTER COLUMN id SET DEFAULT nextval('public.measurements_id_seq'::regclass);


--
-- Name: milestones id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.milestones ALTER COLUMN id SET DEFAULT nextval('public.milestones_id_seq'::regclass);


--
-- Name: persistent_triggers id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persistent_triggers ALTER COLUMN id SET DEFAULT nextval('public.persistent_triggers_id_seq'::regclass);


--
-- Name: projects id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects ALTER COLUMN id SET DEFAULT nextval('public.projects_id_seq'::regclass);


--
-- Name: pull_requests id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pull_requests ALTER COLUMN id SET DEFAULT nextval('public.pull_requests_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: tasks id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks ALTER COLUMN id SET DEFAULT nextval('public.tasks_id_seq'::regclass);


--
-- Name: teams id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams ALTER COLUMN id SET DEFAULT nextval('public.teams_id_seq'::regclass);


--
-- Name: teams_users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams_users ALTER COLUMN id SET DEFAULT nextval('public.teams_users_id_seq'::regclass);


--
-- Name: tickets id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tickets ALTER COLUMN id SET DEFAULT nextval('public.tickets_id_seq'::regclass);


--
-- Name: user_credentials id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_credentials ALTER COLUMN id SET DEFAULT nextval('public.user_credentials_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Name: versions id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions ALTER COLUMN id SET DEFAULT nextval('public.versions_id_seq'::regclass);


--
-- Name: actions actions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.actions
    ADD CONSTRAINT actions_pkey PRIMARY KEY (id);


--
-- Name: api_tokens api_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_tokens
    ADD CONSTRAINT api_tokens_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: authorizations authorizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authorizations
    ADD CONSTRAINT authorizations_pkey PRIMARY KEY (id);


--
-- Name: commits commits_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.commits
    ADD CONSTRAINT commits_pkey PRIMARY KEY (id);


--
-- Name: deploys deploys_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.deploys
    ADD CONSTRAINT deploys_pkey PRIMARY KEY (id);


--
-- Name: errors errors_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.errors
    ADD CONSTRAINT errors_pkey PRIMARY KEY (id);


--
-- Name: follows follows_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT follows_pkey PRIMARY KEY (id);


--
-- Name: measurements measurements_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.measurements
    ADD CONSTRAINT measurements_pkey PRIMARY KEY (id);


--
-- Name: milestones milestones_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.milestones
    ADD CONSTRAINT milestones_pkey PRIMARY KEY (id);


--
-- Name: persistent_triggers persistent_triggers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.persistent_triggers
    ADD CONSTRAINT persistent_triggers_pkey PRIMARY KEY (id);


--
-- Name: projects projects_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.projects
    ADD CONSTRAINT projects_pkey PRIMARY KEY (id);


--
-- Name: pull_requests pull_requests_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pull_requests
    ADD CONSTRAINT pull_requests_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: tasks tasks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tasks
    ADD CONSTRAINT tasks_pkey PRIMARY KEY (id);


--
-- Name: teams teams_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams
    ADD CONSTRAINT teams_pkey PRIMARY KEY (id);


--
-- Name: teams_users teams_users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.teams_users
    ADD CONSTRAINT teams_users_pkey PRIMARY KEY (id);


--
-- Name: tickets tickets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.tickets
    ADD CONSTRAINT tickets_pkey PRIMARY KEY (id);


--
-- Name: user_credentials user_credentials_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_credentials
    ADD CONSTRAINT user_credentials_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: versions versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: index_actions_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_actions_on_name ON public.actions USING btree (name);


--
-- Name: index_api_tokens_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_api_tokens_on_user_id ON public.api_tokens USING btree (user_id);


--
-- Name: index_api_tokens_on_value; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_api_tokens_on_value ON public.api_tokens USING btree (value);


--
-- Name: index_authorizations_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_authorizations_on_user_id ON public.authorizations USING btree (user_id);


--
-- Name: index_commits_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_commits_on_project_id ON public.commits USING btree (project_id);


--
-- Name: index_commits_on_sha; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_commits_on_sha ON public.commits USING btree (sha);


--
-- Name: index_commits_on_unreachable; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_commits_on_unreachable ON public.commits USING btree (unreachable);


--
-- Name: index_commits_pull_requests_on_commit_id_and_pull_request_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_commits_pull_requests_on_commit_id_and_pull_request_id ON public.commits_pull_requests USING btree (commit_id, pull_request_id);


--
-- Name: index_commits_tasks_on_commit_id_and_task_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_commits_tasks_on_commit_id_and_task_id ON public.commits_tasks USING btree (commit_id, task_id);


--
-- Name: index_commits_tickets_on_commit_id_and_ticket_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_commits_tickets_on_commit_id_and_ticket_id ON public.commits_tickets USING btree (commit_id, ticket_id);


--
-- Name: index_commits_users_on_commit_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_commits_users_on_commit_id_and_user_id ON public.commits_users USING btree (commit_id, user_id);


--
-- Name: index_deploys_on_environment_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_deploys_on_environment_name ON public.deploys USING btree (environment_name);


--
-- Name: index_deploys_on_project_id_and_environment_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_deploys_on_project_id_and_environment_name ON public.deploys USING btree (project_id, environment_name);


--
-- Name: index_errors_on_sha; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_errors_on_sha ON public.errors USING btree (sha);


--
-- Name: index_follows_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_follows_on_project_id ON public.follows USING btree (project_id);


--
-- Name: index_follows_on_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_follows_on_user_id ON public.follows USING btree (user_id);


--
-- Name: index_measurements_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_measurements_on_name ON public.measurements USING btree (name);


--
-- Name: index_measurements_on_subject_type_and_subject_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_measurements_on_subject_type_and_subject_id ON public.measurements USING btree (subject_type, subject_id);


--
-- Name: index_measurements_on_taken_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_measurements_on_taken_at ON public.measurements USING btree (taken_at);


--
-- Name: index_measurements_on_taken_on; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_measurements_on_taken_on ON public.measurements USING btree (taken_on);


--
-- Name: index_milestones_on_destroyed_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_milestones_on_destroyed_at ON public.milestones USING btree (destroyed_at);


--
-- Name: index_milestones_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_milestones_on_project_id ON public.milestones USING btree (project_id);


--
-- Name: index_projects_on_slug; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_projects_on_slug ON public.projects USING btree (slug);


--
-- Name: index_pull_requests_on_closed_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pull_requests_on_closed_at ON public.pull_requests USING btree (closed_at);


--
-- Name: index_pull_requests_on_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_pull_requests_on_project_id ON public.pull_requests USING btree (project_id);


--
-- Name: index_pull_requests_on_project_id_and_number; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_pull_requests_on_project_id_and_number ON public.pull_requests USING btree (project_id, number);


--
-- Name: index_roles_on_user_id_and_project_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_roles_on_user_id_and_project_id ON public.roles USING btree (user_id, project_id);


--
-- Name: index_roles_on_user_id_and_project_id_and_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_roles_on_user_id_and_project_id_and_name ON public.roles USING btree (user_id, project_id, name);


--
-- Name: index_tasks_on_ticket_id_and_number; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_tasks_on_ticket_id_and_number ON public.tasks USING btree (ticket_id, number);


--
-- Name: index_teams_users_on_team_id_and_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_teams_users_on_team_id_and_user_id ON public.teams_users USING btree (team_id, user_id);


--
-- Name: index_tickets_on_destroyed_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tickets_on_destroyed_at ON public.tickets USING btree (destroyed_at);


--
-- Name: index_tickets_on_milestone_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tickets_on_milestone_id ON public.tickets USING btree (milestone_id);


--
-- Name: index_tickets_versions_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tickets_versions_on_created_at ON public.tickets_versions USING btree (created_at);


--
-- Name: index_tickets_versions_on_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tickets_versions_on_number ON public.tickets_versions USING btree (number);


--
-- Name: index_tickets_versions_on_tag; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tickets_versions_on_tag ON public.tickets_versions USING btree (tag);


--
-- Name: index_tickets_versions_on_user_id_and_user_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tickets_versions_on_user_id_and_user_type ON public.tickets_versions USING btree (user_id, user_type);


--
-- Name: index_tickets_versions_on_user_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tickets_versions_on_user_name ON public.tickets_versions USING btree (user_name);


--
-- Name: index_tickets_versions_on_versioned_id_and_versioned_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_tickets_versions_on_versioned_id_and_versioned_type ON public.tickets_versions USING btree (versioned_id, versioned_type);


--
-- Name: index_users_on_authentication_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_authentication_token ON public.users USING btree (authentication_token);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON public.users USING btree (email);


--
-- Name: index_users_on_email_addresses; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_email_addresses ON public.users USING btree (email_addresses);


--
-- Name: index_users_on_invitation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_invitation_token ON public.users USING btree (invitation_token);


--
-- Name: index_users_on_invited_by_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_users_on_invited_by_id ON public.users USING btree (invited_by_id);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON public.users USING btree (reset_password_token);


--
-- Name: index_versions_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_created_at ON public.versions USING btree (created_at);


--
-- Name: index_versions_on_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_number ON public.versions USING btree (number);


--
-- Name: index_versions_on_tag; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_tag ON public.versions USING btree (tag);


--
-- Name: index_versions_on_user_id_and_user_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_user_id_and_user_type ON public.versions USING btree (user_id, user_type);


--
-- Name: index_versions_on_user_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_user_name ON public.versions USING btree (user_name);


--
-- Name: index_versions_on_versioned_id_and_versioned_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_versions_on_versioned_id_and_versioned_type ON public.versions USING btree (versioned_id, versioned_type);


--
-- Name: follows fk_rails_32479bd030; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT fk_rails_32479bd030 FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: authorizations fk_rails_4ecef5b8c5; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.authorizations
    ADD CONSTRAINT fk_rails_4ecef5b8c5 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: follows fk_rails_572bf69092; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.follows
    ADD CONSTRAINT fk_rails_572bf69092 FOREIGN KEY (project_id) REFERENCES public.projects(id) ON DELETE CASCADE;


--
-- Name: api_tokens fk_rails_f16b5e0447; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.api_tokens
    ADD CONSTRAINT fk_rails_f16b5e0447 FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20120324185914'),
('20120324202224'),
('20120324230038'),
('20120406185643'),
('20120408155047'),
('20120417175450'),
('20120417175841'),
('20120417190504'),
('20120417195313'),
('20120501230243'),
('20120504143615'),
('20120525013703'),
('20120607124115'),
('20120626140242'),
('20120626150333'),
('20120626151320'),
('20120626152020'),
('20120626152949'),
('20120715230922'),
('20120726231754'),
('20120804003344'),
('20120823025935'),
('20120826022643'),
('20120827190634'),
('20120913020218'),
('20120920023251'),
('20120922010212'),
('20121026014457'),
('20121027160548'),
('20121126005019'),
('20121214025558'),
('20121219202734'),
('20121220031008'),
('20121222170917'),
('20121222223325'),
('20121222223635'),
('20121224212623'),
('20121225175106'),
('20121230173644'),
('20130105200429'),
('20130119203853'),
('20130119204608'),
('20130119211540'),
('20130119212008'),
('20130120182026'),
('20130302205014'),
('20130312224911'),
('20130407195450'),
('20130407200624'),
('20130407220937'),
('20130416020627'),
('20130420151334'),
('20130420155332'),
('20130420172322'),
('20130420174002'),
('20130420174126'),
('20130428005808'),
('20130504014802'),
('20130504135741'),
('20130505144446'),
('20130505162039'),
('20130505212838'),
('20130518224352'),
('20130518224406'),
('20130518224655'),
('20130518224722'),
('20130519163615'),
('20130525192607'),
('20130706141443'),
('20130710233849'),
('20130711004558'),
('20130711013156'),
('20130728191005'),
('20130815232527'),
('20130914155044'),
('20130921141449'),
('20131002005512'),
('20131002015547'),
('20131002145620'),
('20131003014023'),
('20131004015452'),
('20131004185618'),
('20131013185636'),
('20131027214942'),
('20131112010815'),
('20131216014505'),
('20131223194246'),
('20140106212047'),
('20140106212305'),
('20140114014144'),
('20140217150735'),
('20140217160450'),
('20140217195942'),
('20140327020121'),
('20140406183224'),
('20140411214022'),
('20140418133005'),
('20140419152214'),
('20140428023146'),
('20140429000919'),
('20140515174322'),
('20140515200824'),
('20140516005310'),
('20140516012049'),
('20140517012626'),
('20140521014652'),
('20140526155845'),
('20140526180608'),
('20140606232907'),
('20140806233301'),
('20140810224209'),
('20140824194031'),
('20140824194526'),
('20140907013836'),
('20140921201441'),
('20140925021043'),
('20140929004347'),
('20141027194819'),
('20141202004123'),
('20141226171730'),
('20150116153233'),
('20150119154013'),
('20150220215154'),
('20150222205616'),
('20150222214124'),
('20150223013721'),
('20150302153319'),
('20150323004452'),
('20150323011050'),
('20150808192103'),
('20150808193354'),
('20150817232311'),
('20150820023708'),
('20150902005758'),
('20150902010629'),
('20150902010853'),
('20150927014445'),
('20151108221505'),
('20151108223154'),
('20151108233510'),
('20151201042126'),
('20151202005557'),
('20151202011812'),
('20151205204922'),
('20151205214647'),
('20151209004458'),
('20151209030113'),
('20151228183704'),
('20151228183706'),
('20151228183708'),
('20160120145757'),
('20160317140151'),
('20160419230411'),
('20160420000616'),
('20160507135209'),
('20160507135846'),
('20160510233329'),
('20160625203412'),
('20160625221840'),
('20160625230420'),
('20160711170921'),
('20160713204605'),
('20160715173039'),
('20160812233255'),
('20160813001242'),
('20160814024129'),
('20160815001515'),
('20160916191300'),
('20161102012059'),
('20161102012231'),
('20170113164126'),
('20170113223920'),
('20170113224431'),
('20170113225759'),
('20170113230723'),
('20170113230944'),
('20170113231303'),
('20170113232119'),
('20170115003303'),
('20170115003536'),
('20170115150643'),
('20170116002818'),
('20170116210225'),
('20170118005958'),
('20170130011016'),
('20170205004452'),
('20170206002030'),
('20170206002718'),
('20170206002732'),
('20170209022159'),
('20170213001453'),
('20170215012012'),
('20170216041034'),
('20170226201504'),
('20170301014051'),
('20170307032041'),
('20170307035755'),
('20170310024505'),
('20170329030329'),
('20170329164043'),
('20181102202848');


