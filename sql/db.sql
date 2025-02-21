--
-- PostgreSQL database dump
--

-- Dumped from database version 16.3
-- Dumped by pg_dump version 16.3

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
-- Name: notify_messenger_messages(); Type: FUNCTION; Schema: public; Owner: yhb
--

CREATE FUNCTION public.notify_messenger_messages() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
            BEGIN
                PERFORM pg_notify('messenger_messages', NEW.queue_name::text);
                RETURN NEW;
            END;
        $$;


ALTER FUNCTION public.notify_messenger_messages() OWNER TO yhb;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: category; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.category (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL
);


ALTER TABLE public.category OWNER TO yhb;

--
-- Name: category_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.category_id_seq OWNER TO yhb;

--
-- Name: category_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.category_id_seq OWNED BY public.category.id;


--
-- Name: comment; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.comment (
    id integer NOT NULL,
    node_id integer,
    author_id integer NOT NULL,
    body text NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    up integer DEFAULT 0 NOT NULL,
    down integer DEFAULT 0 NOT NULL,
    deleted boolean NOT NULL,
    approved boolean
);


ALTER TABLE public.comment OWNER TO yhb;

--
-- Name: COLUMN comment.created_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public.comment.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.comment_id_seq OWNER TO yhb;

--
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.comment_id_seq OWNED BY public.comment.id;


--
-- Name: conf; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.conf (
    id integer NOT NULL,
    language_id integer,
    sitename character varying(255) NOT NULL,
    keywords text,
    description character varying(255) DEFAULT NULL::character varying,
    address character varying(255) DEFAULT NULL::character varying,
    phone character varying(25) DEFAULT NULL::character varying,
    email character varying(55) DEFAULT NULL::character varying,
    logo character varying(255) DEFAULT NULL::character varying,
    updated_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    note character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.conf OWNER TO yhb;

--
-- Name: COLUMN conf.keywords; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public.conf.keywords IS '(DC2Type:simple_array)';


--
-- Name: COLUMN conf.updated_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public.conf.updated_at IS '(DC2Type:datetime_immutable)';


--
-- Name: conf_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.conf_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.conf_id_seq OWNER TO yhb;

--
-- Name: conf_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.conf_id_seq OWNED BY public.conf.id;


--
-- Name: doctrine_migration_versions; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.doctrine_migration_versions (
    version character varying(191) NOT NULL,
    executed_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    execution_time integer
);


ALTER TABLE public.doctrine_migration_versions OWNER TO yhb;

--
-- Name: down; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.down (
    id integer NOT NULL,
    node_id integer,
    u_id integer NOT NULL,
    comment_id integer,
    created_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.down OWNER TO yhb;

--
-- Name: COLUMN down.created_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public.down.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: down_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.down_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.down_id_seq OWNER TO yhb;

--
-- Name: down_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.down_id_seq OWNED BY public.down.id;


--
-- Name: fav; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.fav (
    id integer NOT NULL,
    node_id integer NOT NULL,
    u_id integer NOT NULL,
    created_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.fav OWNER TO yhb;

--
-- Name: COLUMN fav.created_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public.fav.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: fav_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.fav_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.fav_id_seq OWNER TO yhb;

--
-- Name: fav_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.fav_id_seq OWNED BY public.fav.id;


--
-- Name: feedback; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.feedback (
    id integer NOT NULL,
    node_id integer,
    u_id integer,
    firstname character varying(15) DEFAULT NULL::character varying,
    lastname character varying(15) DEFAULT NULL::character varying,
    email character varying(35) DEFAULT NULL::character varying,
    phone character varying(20) DEFAULT NULL::character varying,
    title character varying(255) DEFAULT NULL::character varying,
    body text NOT NULL,
    country character varying(30) DEFAULT NULL::character varying,
    sex smallint,
    province character varying(255) DEFAULT NULL::character varying,
    city character varying(255) DEFAULT NULL::character varying,
    note character varying(255) DEFAULT NULL::character varying,
    name character varying(255) DEFAULT NULL::character varying,
    type smallint,
    status smallint NOT NULL,
    created_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.feedback OWNER TO yhb;

--
-- Name: COLUMN feedback.created_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public.feedback.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: feedback_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.feedback_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.feedback_id_seq OWNER TO yhb;

--
-- Name: feedback_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.feedback_id_seq OWNED BY public.feedback.id;


--
-- Name: image; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.image (
    id integer NOT NULL,
    node_id integer,
    image character varying(255) NOT NULL,
    title character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.image OWNER TO yhb;

--
-- Name: image_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.image_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.image_id_seq OWNER TO yhb;

--
-- Name: image_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.image_id_seq OWNED BY public.image.id;


--
-- Name: language; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.language (
    id integer NOT NULL,
    language character varying(30) NOT NULL,
    prefix character varying(15) NOT NULL,
    locale character varying(15) NOT NULL
);


ALTER TABLE public.language OWNER TO yhb;

--
-- Name: language_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.language_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.language_id_seq OWNER TO yhb;

--
-- Name: language_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.language_id_seq OWNED BY public.language.id;


--
-- Name: like; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public."like" (
    id integer NOT NULL,
    node_id integer NOT NULL,
    u_id integer NOT NULL,
    created_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public."like" OWNER TO yhb;

--
-- Name: COLUMN "like".created_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public."like".created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: like_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.like_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.like_id_seq OWNER TO yhb;

--
-- Name: like_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.like_id_seq OWNED BY public."like".id;


--
-- Name: link; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.link (
    id integer NOT NULL,
    menu_id integer NOT NULL,
    title character varying(255) NOT NULL,
    link character varying(255) NOT NULL,
    weight smallint NOT NULL
);


ALTER TABLE public.link OWNER TO yhb;

--
-- Name: link_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.link_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.link_id_seq OWNER TO yhb;

--
-- Name: link_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.link_id_seq OWNED BY public.link.id;


--
-- Name: menu; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.menu (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL
);


ALTER TABLE public.menu OWNER TO yhb;

--
-- Name: menu_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.menu_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.menu_id_seq OWNER TO yhb;

--
-- Name: menu_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.menu_id_seq OWNED BY public.menu.id;


--
-- Name: messenger_messages; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.messenger_messages (
    id bigint NOT NULL,
    body text NOT NULL,
    headers text NOT NULL,
    queue_name character varying(190) NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    available_at timestamp(0) without time zone NOT NULL,
    delivered_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


ALTER TABLE public.messenger_messages OWNER TO yhb;

--
-- Name: COLUMN messenger_messages.created_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public.messenger_messages.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN messenger_messages.available_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public.messenger_messages.available_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN messenger_messages.delivered_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public.messenger_messages.delivered_at IS '(DC2Type:datetime_immutable)';


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.messenger_messages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.messenger_messages_id_seq OWNER TO yhb;

--
-- Name: messenger_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.messenger_messages_id_seq OWNED BY public.messenger_messages.id;


--
-- Name: node; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.node (
    id integer NOT NULL,
    language_id integer,
    category_id integer,
    parent_id integer,
    author_id integer,
    title character varying(255) NOT NULL,
    body text,
    image character varying(255) DEFAULT NULL::character varying,
    summary text,
    video character varying(255) DEFAULT NULL::character varying,
    audio character varying(255) DEFAULT NULL::character varying,
    qr character varying(255) DEFAULT NULL::character varying,
    phone character varying(255) DEFAULT NULL::character varying,
    latitude double precision,
    longitude double precision,
    address character varying(255) DEFAULT NULL::character varying,
    price integer,
    created_at timestamp(0) without time zone NOT NULL,
    updated_at timestamp(0) without time zone NOT NULL,
    deleted boolean,
    marker character varying(255) DEFAULT NULL::character varying,
    start_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    end_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    note character varying(255) DEFAULT NULL::character varying,
    published boolean
);


ALTER TABLE public.node OWNER TO yhb;

--
-- Name: COLUMN node.created_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public.node.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN node.updated_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public.node.updated_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN node.start_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public.node.start_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN node.end_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public.node.end_at IS '(DC2Type:datetime_immutable)';


--
-- Name: node_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.node_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.node_id_seq OWNER TO yhb;

--
-- Name: node_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.node_id_seq OWNED BY public.node.id;


--
-- Name: node_region; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.node_region (
    node_id integer NOT NULL,
    region_id integer NOT NULL
);


ALTER TABLE public.node_region OWNER TO yhb;

--
-- Name: node_tag; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.node_tag (
    node_id integer NOT NULL,
    tag_id integer NOT NULL
);


ALTER TABLE public.node_tag OWNER TO yhb;

--
-- Name: order; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public."order" (
    id integer NOT NULL,
    node_id integer NOT NULL,
    consumer_id integer NOT NULL,
    quantity smallint NOT NULL,
    amount integer NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    paid_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    used_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    status smallint NOT NULL,
    price integer NOT NULL,
    cancelled_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    refunded_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    deleted_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    sn character varying(255) NOT NULL,
    wx_trans_id character varying(255) DEFAULT NULL::character varying,
    bank_type character varying(255) DEFAULT NULL::character varying,
    wx_prepay_id character varying(255) DEFAULT NULL::character varying,
    deleted boolean NOT NULL
);


ALTER TABLE public."order" OWNER TO yhb;

--
-- Name: COLUMN "order".created_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public."order".created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN "order".paid_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public."order".paid_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN "order".used_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public."order".used_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN "order".cancelled_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public."order".cancelled_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN "order".refunded_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public."order".refunded_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN "order".deleted_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public."order".deleted_at IS '(DC2Type:datetime_immutable)';


--
-- Name: order_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.order_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.order_id_seq OWNER TO yhb;

--
-- Name: order_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.order_id_seq OWNED BY public."order".id;


--
-- Name: page; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.page (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL,
    weight smallint
);


ALTER TABLE public.page OWNER TO yhb;

--
-- Name: page_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.page_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.page_id_seq OWNER TO yhb;

--
-- Name: page_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.page_id_seq OWNED BY public.page.id;


--
-- Name: rate; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.rate (
    id integer NOT NULL,
    node_id integer NOT NULL,
    u_id integer NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    rate double precision NOT NULL
);


ALTER TABLE public.rate OWNER TO yhb;

--
-- Name: COLUMN rate.created_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public.rate.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: rate_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.rate_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.rate_id_seq OWNER TO yhb;

--
-- Name: rate_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.rate_id_seq OWNED BY public.rate.id;


--
-- Name: refund; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.refund (
    id integer NOT NULL,
    ord_id integer NOT NULL,
    created_at timestamp(0) without time zone NOT NULL,
    reason smallint NOT NULL,
    note character varying(255) DEFAULT NULL::character varying,
    sn character varying(255) NOT NULL,
    wx_refund_id character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.refund OWNER TO yhb;

--
-- Name: COLUMN refund.created_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public.refund.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: refund_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.refund_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.refund_id_seq OWNER TO yhb;

--
-- Name: refund_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.refund_id_seq OWNED BY public.refund.id;


--
-- Name: region; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.region (
    id integer NOT NULL,
    page_id integer,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL,
    count smallint NOT NULL,
    icon character varying(20) DEFAULT NULL::character varying,
    fields text,
    description character varying(255) DEFAULT NULL::character varying,
    weight smallint,
    marker character varying(255) DEFAULT NULL::character varying,
    created_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    updated_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone
);


ALTER TABLE public.region OWNER TO yhb;

--
-- Name: COLUMN region.fields; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public.region.fields IS '(DC2Type:simple_array)';


--
-- Name: COLUMN region.created_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public.region.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: COLUMN region.updated_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public.region.updated_at IS '(DC2Type:datetime_immutable)';


--
-- Name: region_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.region_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.region_id_seq OWNER TO yhb;

--
-- Name: region_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.region_id_seq OWNED BY public.region.id;


--
-- Name: spec; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.spec (
    id integer NOT NULL,
    node_id integer NOT NULL,
    name character varying(25) NOT NULL,
    value character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public.spec OWNER TO yhb;

--
-- Name: spec_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.spec_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.spec_id_seq OWNER TO yhb;

--
-- Name: spec_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.spec_id_seq OWNED BY public.spec.id;


--
-- Name: tag; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.tag (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    label character varying(255) NOT NULL
);


ALTER TABLE public.tag OWNER TO yhb;

--
-- Name: tag_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.tag_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tag_id_seq OWNER TO yhb;

--
-- Name: tag_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.tag_id_seq OWNED BY public.tag.id;


--
-- Name: up; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public.up (
    id integer NOT NULL,
    node_id integer,
    u_id integer NOT NULL,
    comment_id integer,
    created_at timestamp(0) without time zone NOT NULL
);


ALTER TABLE public.up OWNER TO yhb;

--
-- Name: COLUMN up.created_at; Type: COMMENT; Schema: public; Owner: yhb
--

COMMENT ON COLUMN public.up.created_at IS '(DC2Type:datetime_immutable)';


--
-- Name: up_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.up_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.up_id_seq OWNER TO yhb;

--
-- Name: up_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.up_id_seq OWNED BY public.up.id;


--
-- Name: user; Type: TABLE; Schema: public; Owner: yhb
--

CREATE TABLE public."user" (
    id integer NOT NULL,
    username character varying(180) NOT NULL,
    roles json NOT NULL,
    password character varying(255) NOT NULL,
    plain_password character varying(255) DEFAULT NULL::character varying,
    openid character varying(255) DEFAULT NULL::character varying,
    name character varying(255) DEFAULT NULL::character varying,
    phone character varying(255) DEFAULT NULL::character varying,
    avatar character varying(255) DEFAULT NULL::character varying
);


ALTER TABLE public."user" OWNER TO yhb;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: yhb
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.user_id_seq OWNER TO yhb;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: yhb
--

ALTER SEQUENCE public.user_id_seq OWNED BY public."user".id;


--
-- Name: category id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.category ALTER COLUMN id SET DEFAULT nextval('public.category_id_seq'::regclass);


--
-- Name: comment id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.comment ALTER COLUMN id SET DEFAULT nextval('public.comment_id_seq'::regclass);


--
-- Name: conf id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.conf ALTER COLUMN id SET DEFAULT nextval('public.conf_id_seq'::regclass);


--
-- Name: down id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.down ALTER COLUMN id SET DEFAULT nextval('public.down_id_seq'::regclass);


--
-- Name: fav id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.fav ALTER COLUMN id SET DEFAULT nextval('public.fav_id_seq'::regclass);


--
-- Name: feedback id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.feedback ALTER COLUMN id SET DEFAULT nextval('public.feedback_id_seq'::regclass);


--
-- Name: image id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.image ALTER COLUMN id SET DEFAULT nextval('public.image_id_seq'::regclass);


--
-- Name: language id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.language ALTER COLUMN id SET DEFAULT nextval('public.language_id_seq'::regclass);


--
-- Name: like id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public."like" ALTER COLUMN id SET DEFAULT nextval('public.like_id_seq'::regclass);


--
-- Name: link id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.link ALTER COLUMN id SET DEFAULT nextval('public.link_id_seq'::regclass);


--
-- Name: menu id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.menu ALTER COLUMN id SET DEFAULT nextval('public.menu_id_seq'::regclass);


--
-- Name: messenger_messages id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.messenger_messages ALTER COLUMN id SET DEFAULT nextval('public.messenger_messages_id_seq'::regclass);


--
-- Name: node id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.node ALTER COLUMN id SET DEFAULT nextval('public.node_id_seq'::regclass);


--
-- Name: order id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public."order" ALTER COLUMN id SET DEFAULT nextval('public.order_id_seq'::regclass);


--
-- Name: page id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.page ALTER COLUMN id SET DEFAULT nextval('public.page_id_seq'::regclass);


--
-- Name: rate id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.rate ALTER COLUMN id SET DEFAULT nextval('public.rate_id_seq'::regclass);


--
-- Name: refund id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.refund ALTER COLUMN id SET DEFAULT nextval('public.refund_id_seq'::regclass);


--
-- Name: region id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.region ALTER COLUMN id SET DEFAULT nextval('public.region_id_seq'::regclass);


--
-- Name: spec id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.spec ALTER COLUMN id SET DEFAULT nextval('public.spec_id_seq'::regclass);


--
-- Name: tag id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.tag ALTER COLUMN id SET DEFAULT nextval('public.tag_id_seq'::regclass);


--
-- Name: up id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.up ALTER COLUMN id SET DEFAULT nextval('public.up_id_seq'::regclass);


--
-- Name: user id; Type: DEFAULT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public."user" ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: category; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.category (id, name, label) FROM stdin;
\.


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.comment (id, node_id, author_id, body, created_at, up, down, deleted, approved) FROM stdin;
\.


--
-- Data for Name: conf; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.conf (id, language_id, sitename, keywords, description, address, phone, email, logo, updated_at, note) FROM stdin;
1	\N	医惠保	医惠保	医惠保	湖北省武汉市湖北省武汉市	8888 8888	info@yhb.com	8ac30220-84ad-4110-98e6-25497dba26b8-removalai-preview-67b6f25ce3226306987658.png	2025-02-20 09:14:04	\N
\.


--
-- Data for Name: doctrine_migration_versions; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.doctrine_migration_versions (version, executed_at, execution_time) FROM stdin;
DoctrineMigrations\\Version20250114072605	2025-01-14 07:26:13	588
\.


--
-- Data for Name: down; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.down (id, node_id, u_id, comment_id, created_at) FROM stdin;
\.


--
-- Data for Name: fav; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.fav (id, node_id, u_id, created_at) FROM stdin;
\.


--
-- Data for Name: feedback; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.feedback (id, node_id, u_id, firstname, lastname, email, phone, title, body, country, sex, province, city, note, name, type, status, created_at) FROM stdin;
\.


--
-- Data for Name: image; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.image (id, node_id, image, title) FROM stdin;
\.


--
-- Data for Name: language; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.language (id, language, prefix, locale) FROM stdin;
\.


--
-- Data for Name: like; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public."like" (id, node_id, u_id, created_at) FROM stdin;
\.


--
-- Data for Name: link; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.link (id, menu_id, title, link, weight) FROM stdin;
\.


--
-- Data for Name: menu; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.menu (id, name, label) FROM stdin;
\.


--
-- Data for Name: messenger_messages; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.messenger_messages (id, body, headers, queue_name, created_at, available_at, delivered_at) FROM stdin;
\.


--
-- Data for Name: node; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.node (id, language_id, category_id, parent_id, author_id, title, body, image, summary, video, audio, qr, phone, latitude, longitude, address, price, created_at, updated_at, deleted, marker, start_at, end_at, note, published) FROM stdin;
1	\N	\N	\N	1	高度定制化	\N	\N	根据不同医院规模、科室设置和管理需求，定制专属风险管理方案。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 08:29:36	2025-01-23 08:29:36	f	\N	\N	\N	\N	\N
2	\N	\N	\N	1	操作简便	\N	\N	简洁直观的界面设计，无需复杂培训，医护人员即可快速上手。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 08:30:00	2025-01-23 08:30:00	f	\N	\N	\N	\N	\N
3	\N	\N	\N	1	安全可靠	\N	\N	采用多重加密技术，保障患者信息和医院数据安全。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 08:30:21	2025-01-23 08:30:21	f	\N	\N	\N	\N	\N
8	\N	\N	\N	1	王医生	\N	testimonial2-67b6c2b4a4da9039372589.jpg	在引入这套医院风险管理系统之前，我们医院在医疗差错防控上总是力不从心，一些细微的疏忽都可能引发严重后果。但自从用了医疗差错防范解决方案，效果立竿见影。智能识别技术就像一位严谨的 “监督者”，在医嘱、药品调配等环节严格把关，电子病历系统的对接也让信息核对更精准。以前每月都有几起潜在差错隐患，现在几乎为零，患者的就医安全得到了极大保障，真的是帮了大忙！	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 09:27:34	2025-02-20 05:50:44	f	\N	\N	\N	\N	\N
5	\N	\N	\N	1	数据驱动，优化医院运营	\N	banner1-679210bf8ab15023939548.jpg	深度分析数据，助力科学决策	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 08:31:52	2025-01-23 09:49:51	f	\N	\N	\N	\N	\N
10	\N	\N	\N	1	关于我们	\N	\N	我们是一家专注于医疗行业风险管理解决方案的创新型科技企业，始终致力于运用前沿技术为医疗机构筑牢安全防线，助力其实现高效、稳定的运营。\r\n自成立以来，我们汇聚了一批来自医疗、信息技术、数据分析等多领域的专业人才。医疗专家凭借深厚的行业经验，精准把握医院运营中的各类风险痛点；技术精英则运用先进的算法、大数据分析技术以及软件开发能力，将复杂的风险管理流程转化为智能化、便捷化的系统解决方案。\r\n在技术研发上，我们不断投入，紧跟行业趋势。自主研发的智能风险识别引擎，融合了机器学习、深度学习等技术，能够快速、准确地识别医疗流程中潜藏的风险因素；同时，通过与各大医疗机构的深度合作，持续优化系统算法，确保系统始终贴合不断变化的医疗场景需求。\r\n我们秉持 “客户至上，安全第一” 的服务理念。从售前的需求调研、方案定制，到售中的系统部署、操作培训，再到售后的 7*24 小时技术支持，我们为每一位客户提供全生命周期的贴心服务。无论何时何地，客户遇到任何问题，我们的专业团队都会迅速响应，全力解决，保障医院风险管理系统的稳定运行。\r\n多年来，我们的产品和服务已覆盖全国数十个省市的各级医疗机构，帮助众多医院有效降低了运营风险，提升了医疗服务质量。未来，我们将继续砥砺前行，不断创新，为医疗行业的风险管理贡献更多力量，守护每一位患者的健康与安全。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 09:28:44	2025-01-23 09:28:44	f	\N	\N	\N	\N	\N
19	\N	\N	\N	1	患者安全保障	\N	\N	从患者入院到出院，全程跟踪患者的身体状况和治疗进展。通过智能设备采集患者生命体征数据，利用数据分析模型预测患者跌倒、压疮等风险事件。一旦风险预警触发，医护人员及时采取干预措施，保障患者住院期间的安全。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 09:33:33	2025-01-23 09:33:33	f	\N	\N	\N	\N	\N
18	\N	\N	\N	1	医院感染控制	\N	\N	搭建感染风险监测网络，对病房、手术室、供应室等重点区域的环境数据、人员流动数据进行实时采集分析。结合微生物检测数据，精准定位感染源和传播途径，为医院制定针对性的消毒、隔离和人员防护措施提供依据。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 09:33:15	2025-01-23 09:33:15	f	\N	\N	\N	\N	\N
17	\N	\N	\N	1	医疗差错防范	\N	\N	利用智能识别技术，在医嘱开立、药品调配、手术核对等关键环节设置多重校验机制。通过与电子病历系统无缝对接，实时比对患者信息与操作流程，一旦发现异常，立即预警并阻断操作，降低医疗差错发生率。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 09:32:55	2025-01-23 09:32:55	f	\N	\N	\N	\N	\N
6	\N	\N	\N	1	智能风控，守护医疗安全	\N	banner2-679210b17b2c4379233624.jpg	精准识别风险，降低医疗差错	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 09:26:00	2025-01-23 09:49:37	f	\N	\N	\N	\N	\N
4	\N	\N	\N	1	全面防控，应对突发挑战	\N	banner1-679210c7e8d85494215086.jpg	定制应急方案，高效指挥调度	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 08:31:21	2025-01-23 09:49:59	f	\N	\N	\N	\N	\N
7	\N	\N	\N	1	李医生	\N	testimonial3-67b6c2bb695e5622037363.jpg	医院感染防控一直是我们的重点工作，可传统管理方式效率低、效果差。这个医院风险管理系统的感染控制解决方案给了我们全新的思路。24 小时实时采集环境和人员数据，配合微生物检测分析，感染源和传播途径无处遁形。根据系统提供的依据制定防控措施后，医院感染率明显下降，病房环境更安全，患者和医护人员都更安心，强烈推荐！	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 09:27:08	2025-02-20 05:50:51	f	\N	\N	\N	\N	\N
16	\N	\N	\N	1	数据安全保障与定期更新	\N	service9-67b7c43286945408047379.jpg	采用多重加密技术，对患者信息、医疗数据等进行严密防护，防止数据泄露。并根据医疗行业新法规、新风险特征，定期更新系统功能与风险数据库，保持系统的先进性和适用性。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 09:31:24	2025-02-21 00:09:22	f	\N	\N	\N	\N	\N
15	\N	\N	\N	1	操作培训与技术支持	\N	service8-67b7c4386e3af501128182.jpg	为医院工作人员提供系统操作培训课程，涵盖线上视频教程、线下实操指导等多种形式，确保医护人员快速掌握系统使用技巧。同时，设立 7*24 小时技术支持团队，随时解答使用过程中的疑问，保障系统稳定运行。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 09:31:00	2025-02-21 00:09:28	f	\N	\N	\N	\N	\N
13	\N	\N	\N	1	深度数据统计与可视化分析	\N	service6-67b7c444469ee961141807.jpg	对海量风险数据深度挖掘，运用专业数据分析工具，生成直观易懂的可视化报表，如风险趋势图、科室风险占比饼状图等，为医院管理层提供清晰、全面的数据洞察，助力科学决策。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 09:30:20	2025-02-21 00:09:40	f	\N	\N	\N	\N	\N
12	\N	\N	\N	1	24 小时实时监控与即时预警	\N	service5-67b7c44a577fd231714778.jpg	构建全天候风险监控体系，实时跟踪关键风险指标。一旦风险数值突破预设警戒线，系统即刻通过短信、弹窗等多渠道发出预警，确保医院管理及医护人员能第一时间响应，将风险遏制在萌芽状态。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 09:30:01	2025-02-21 00:09:46	f	\N	\N	\N	\N	\N
11	\N	\N	\N	1	风险智能识别与精准评估	\N	service4-67b7c450cf85f919780585.jpg	借助前沿人工智能算法，全方位扫描医疗流程，从门诊挂号、病房护理到手术操作、药品配送等环节，精准揪出潜在风险点，并依据行业标准和历史数据，进行量化评估，为后续防控提供科学依据。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 09:29:40	2025-02-21 00:09:52	f	\N	\N	\N	\N	\N
14	\N	\N	\N	1	定制化风险防控方案	\N	service1-67b7c8a6bf769037489454.jpg	充分考量不同医院的规模大小、科室特色、管理模式等差异，量身定制专属的风险管理策略，确保方案贴合医院实际需求，有效提升风险应对能力。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 09:30:40	2025-02-21 00:28:22	f	\N	\N	\N	\N	\N
22	\N	\N	\N	1	应急事件管理	\N	\N	针对自然灾害、公共卫生事件等突发情况，制定应急预案模板，并结合医院实际资源进行个性化配置。系统实时跟踪应急物资储备、人员调配等信息，在应急事件发生时，快速启动预案，实现高效指挥调度。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 09:34:24	2025-01-23 09:34:24	f	\N	\N	\N	\N	\N
21	\N	\N	\N	1	财务风险管控	\N	\N	整合医院财务数据，对医保结算、费用报销、成本核算等环节进行实时监控。通过数据分析预测医保拒付风险、资金周转风险等，提前制定应对策略，确保医院财务稳定运行。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 09:34:07	2025-01-23 09:34:07	f	\N	\N	\N	\N	\N
20	\N	\N	\N	1	医疗纠纷应对	\N	\N	建立医疗纠纷案例库和智能分析系统，对过往纠纷案例进行深度剖析，总结风险因素和应对策略。在纠纷发生时，系统快速提供相似案例的处理经验和法律依据，协助医院管理部门与患者沟通协商，妥善解决纠纷。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 09:33:50	2025-01-23 09:33:50	f	\N	\N	\N	\N	\N
23	\N	\N	\N	1	首席技术官 - 诸葛	\N	\N	拥有计算机科学博士学位，在人工智能与大数据处理领域拥有超过 15 年的研究与实践经验。曾在知名科技企业主导多个大型数据处理与算法优化项目。加入我们团队后，负责医院风险管理系统核心技术架构的搭建与优化。他带领技术团队研发的智能风险识别算法，大幅提升了系统对医疗风险的精准识别能力，确保系统在复杂医疗场景下的高效稳定运行。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 09:56:25	2025-01-23 09:56:25	f	\N	\N	\N	\N	\N
24	\N	\N	\N	1	医疗顾问 - 夏侯	\N	\N	毕业于顶尖医学院，拥有 20 余年临床一线工作经验，曾担任三甲医院科室主任。作为医疗领域专家，她深度参与系统设计，从专业医疗角度提供丰富的实践经验与行业见解。凭借对医疗流程的深入理解，帮助团队精准定位医院运营中的风险点，确保系统功能贴合实际医疗需求，为医护人员和患者提供切实有效的风险管理支持。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 09:59:36	2025-01-23 09:59:36	f	\N	\N	\N	\N	\N
26	\N	\N	\N	1	数据分析师 - 东方	\N	doctor2-67b6f305aa57a565374194.jpg	专注于数据分析领域，拥有统计学硕士学位，并持有多项专业数据分析认证。在团队中，他负责收集、整理和分析与医院风险管理相关的海量数据。通过运用先进的数据分析方法和工具，王强从复杂数据中挖掘有价值的信息，为风险评估模型的优化提供数据支撑，助力系统生成准确、直观的风险分析报告，为医院决策层提供有力的数据支持。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 10:01:32	2025-02-20 09:16:53	f	\N	\N	\N	\N	\N
9	\N	\N	\N	1	刘女士	\N	testimonial1-67b6c2aae5a56663134271.jpg	作为医院管理者，财务风险管控至关重要。之前医保结算和成本核算存在不少风险，让我十分头疼。使用这套系统的财务风险管控解决方案后，实时监控和精准预测功能太强大了。通过提前制定应对策略，我们成功避免了几次医保拒付风险，资金周转也更顺畅，为医院的稳定运营提供了坚实后盾，是医院管理的得力助手！	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 09:27:55	2025-02-20 05:50:34	f	\N	\N	\N	\N	\N
25	\N	\N	\N	1	产品经理 - 欧阳	\N	doctor1-67b6f30c3cf8f634939247.jpg	具备丰富的医疗产品管理经验，熟悉医疗行业各类业务流程与规范。在医院风险管理系统的产品规划与设计过程中，他充分调研市场需求与客户痛点，协调各方资源，推动产品从概念到落地的全流程。通过与技术、医疗和市场团队紧密合作，确保系统功能不仅满足当前医院风险管理需求，还能随着行业发展不断迭代升级，保持领先竞争力。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 10:00:46	2025-02-20 09:17:00	f	\N	\N	\N	\N	\N
28	\N	\N	\N	1	客户服务经理 - 司马	\N	doctor4-67b6f2fa0e035407754707.jpg	拥有丰富的客户服务管理经验，致力于为客户提供优质、高效的服务体验。在医院风险管理系统项目中，他领导客户服务团队，负责系统的售后支持与客户关系维护。确保客户在使用系统过程中遇到的任何问题都能得到及时响应与解决，通过定期回访与满意度调查，收集客户反馈，为产品优化提供宝贵意见，不断提升客户对系统的满意度与忠诚度。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 10:02:55	2025-02-20 09:16:42	f	\N	\N	\N	\N	\N
27	\N	\N	\N	1	市场营销总监 - 南宫	\N	doctor3-67b6f2ff8bbb4491242388.jpg	在医疗科技市场营销领域拥有卓越成就，拥有 10 多年成功推广医疗软件与服务的经验。她深入了解医疗市场动态和客户需求，制定并执行全面的市场推广策略，提升医院风险管理系统的品牌知名度与市场占有率。赵静凭借出色的沟通与合作能力，与各大医疗机构建立良好合作关系，成功将系统推向全国多个地区，帮助众多医院实现风险管理的数字化转型。	\N	\N	\N	\N	\N	\N	\N	\N	2025-01-23 10:02:09	2025-02-20 09:16:47	f	\N	\N	\N	\N	\N
\.


--
-- Data for Name: node_region; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.node_region (node_id, region_id) FROM stdin;
1	1
2	1
3	1
4	2
5	2
6	2
7	3
8	3
9	3
10	4
11	5
12	5
13	5
14	5
15	5
16	5
17	6
18	6
19	6
20	6
21	6
22	6
23	7
24	7
25	7
26	7
27	7
28	7
\.


--
-- Data for Name: node_tag; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.node_tag (node_id, tag_id) FROM stdin;
\.


--
-- Data for Name: order; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public."order" (id, node_id, consumer_id, quantity, amount, created_at, paid_at, used_at, status, price, cancelled_at, refunded_at, deleted_at, sn, wx_trans_id, bank_type, wx_prepay_id, deleted) FROM stdin;
\.


--
-- Data for Name: page; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.page (id, name, label, weight) FROM stdin;
1	首页	home	0
5	团队	team	0
2	关于我们	about	0
3	联系我们	contact	0
4	产品服务	services	0
6	业务咨询	feedback	0
\.


--
-- Data for Name: rate; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.rate (id, node_id, u_id, created_at, rate) FROM stdin;
\.


--
-- Data for Name: refund; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.refund (id, ord_id, created_at, reason, note, sn, wx_refund_id) FROM stdin;
\.


--
-- Data for Name: region; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.region (id, page_id, name, label, count, icon, fields, description, weight, marker, created_at, updated_at) FROM stdin;
4	2	关于我们	about	5	list	image,summary,body	\N	0	\N	2025-01-23 08:21:09	\N
3	1	客户评价	testimonial	5	list	image,summary,body	\N	0	\N	2025-01-23 08:20:51	\N
2	1	轮播图	slider	5	list	image,summary,body	\N	0	\N	2025-01-23 08:20:17	\N
1	1	优势	youshi	5	list	image,summary,body	\N	0	\N	2025-01-23 08:19:35	\N
6	4	解决方案	solutions	5	list	image,summary,body	\N	0	\N	2025-01-23 09:32:03	\N
7	5	成员	staffs	5	list	image,summary,body	\N	0	\N	2025-01-23 09:54:12	\N
5	4	产品服务	services	6	list	image,summary,body	\N	0	\N	2025-01-23 08:22:49	\N
\.


--
-- Data for Name: spec; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.spec (id, node_id, name, value) FROM stdin;
\.


--
-- Data for Name: tag; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.tag (id, name, label) FROM stdin;
\.


--
-- Data for Name: up; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public.up (id, node_id, u_id, comment_id, created_at) FROM stdin;
\.


--
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: yhb
--

COPY public."user" (id, username, roles, password, plain_password, openid, name, phone, avatar) FROM stdin;
1	al	["ROLE_SUPER_ADMIN"]	$2y$13$MaCEqCRTC2ds1KO7tDSVzOCAkHOEXGpcDoqbHycFXhJ917lS.KfM2	\N	\N	al	\N	avatar.jpg
\.


--
-- Name: category_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.category_id_seq', 1, false);


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.comment_id_seq', 1, false);


--
-- Name: conf_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.conf_id_seq', 1, true);


--
-- Name: down_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.down_id_seq', 1, false);


--
-- Name: fav_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.fav_id_seq', 1, false);


--
-- Name: feedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.feedback_id_seq', 1, false);


--
-- Name: image_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.image_id_seq', 1, false);


--
-- Name: language_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.language_id_seq', 1, false);


--
-- Name: like_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.like_id_seq', 1, false);


--
-- Name: link_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.link_id_seq', 1, false);


--
-- Name: menu_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.menu_id_seq', 1, false);


--
-- Name: messenger_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.messenger_messages_id_seq', 1, false);


--
-- Name: node_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.node_id_seq', 28, true);


--
-- Name: order_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.order_id_seq', 1, false);


--
-- Name: page_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.page_id_seq', 6, true);


--
-- Name: rate_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.rate_id_seq', 1, false);


--
-- Name: refund_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.refund_id_seq', 1, false);


--
-- Name: region_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.region_id_seq', 7, true);


--
-- Name: spec_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.spec_id_seq', 1, false);


--
-- Name: tag_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.tag_id_seq', 1, false);


--
-- Name: up_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.up_id_seq', 1, false);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: yhb
--

SELECT pg_catalog.setval('public.user_id_seq', 1, true);


--
-- Name: category category_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.category
    ADD CONSTRAINT category_pkey PRIMARY KEY (id);


--
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- Name: conf conf_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.conf
    ADD CONSTRAINT conf_pkey PRIMARY KEY (id);


--
-- Name: doctrine_migration_versions doctrine_migration_versions_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.doctrine_migration_versions
    ADD CONSTRAINT doctrine_migration_versions_pkey PRIMARY KEY (version);


--
-- Name: down down_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.down
    ADD CONSTRAINT down_pkey PRIMARY KEY (id);


--
-- Name: fav fav_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.fav
    ADD CONSTRAINT fav_pkey PRIMARY KEY (id);


--
-- Name: feedback feedback_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT feedback_pkey PRIMARY KEY (id);


--
-- Name: image image_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT image_pkey PRIMARY KEY (id);


--
-- Name: language language_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.language
    ADD CONSTRAINT language_pkey PRIMARY KEY (id);


--
-- Name: like like_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public."like"
    ADD CONSTRAINT like_pkey PRIMARY KEY (id);


--
-- Name: link link_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.link
    ADD CONSTRAINT link_pkey PRIMARY KEY (id);


--
-- Name: menu menu_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.menu
    ADD CONSTRAINT menu_pkey PRIMARY KEY (id);


--
-- Name: messenger_messages messenger_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.messenger_messages
    ADD CONSTRAINT messenger_messages_pkey PRIMARY KEY (id);


--
-- Name: node node_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT node_pkey PRIMARY KEY (id);


--
-- Name: node_region node_region_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.node_region
    ADD CONSTRAINT node_region_pkey PRIMARY KEY (node_id, region_id);


--
-- Name: node_tag node_tag_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.node_tag
    ADD CONSTRAINT node_tag_pkey PRIMARY KEY (node_id, tag_id);


--
-- Name: order order_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT order_pkey PRIMARY KEY (id);


--
-- Name: page page_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.page
    ADD CONSTRAINT page_pkey PRIMARY KEY (id);


--
-- Name: rate rate_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.rate
    ADD CONSTRAINT rate_pkey PRIMARY KEY (id);


--
-- Name: refund refund_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.refund
    ADD CONSTRAINT refund_pkey PRIMARY KEY (id);


--
-- Name: region region_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT region_pkey PRIMARY KEY (id);


--
-- Name: spec spec_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.spec
    ADD CONSTRAINT spec_pkey PRIMARY KEY (id);


--
-- Name: tag tag_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.tag
    ADD CONSTRAINT tag_pkey PRIMARY KEY (id);


--
-- Name: up up_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.up
    ADD CONSTRAINT up_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: idx_14f389a882f1baf4; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_14f389a882f1baf4 ON public.conf USING btree (language_id);


--
-- Name: idx_1cff903b460d9fd7; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_1cff903b460d9fd7 ON public.down USING btree (node_id);


--
-- Name: idx_1cff903be4a59390; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_1cff903be4a59390 ON public.down USING btree (u_id);


--
-- Name: idx_1cff903bf8697d13; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_1cff903bf8697d13 ON public.down USING btree (comment_id);


--
-- Name: idx_36ac99f1ccd7e912; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_36ac99f1ccd7e912 ON public.link USING btree (menu_id);


--
-- Name: idx_4394ee70460d9fd7; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_4394ee70460d9fd7 ON public.up USING btree (node_id);


--
-- Name: idx_4394ee70e4a59390; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_4394ee70e4a59390 ON public.up USING btree (u_id);


--
-- Name: idx_4394ee70f8697d13; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_4394ee70f8697d13 ON public.up USING btree (comment_id);


--
-- Name: idx_70ac95f8460d9fd7; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_70ac95f8460d9fd7 ON public.node_tag USING btree (node_id);


--
-- Name: idx_70ac95f8bad26311; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_70ac95f8bad26311 ON public.node_tag USING btree (tag_id);


--
-- Name: idx_75ea56e016ba31db; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_75ea56e016ba31db ON public.messenger_messages USING btree (delivered_at);


--
-- Name: idx_75ea56e0e3bd61ce; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_75ea56e0e3bd61ce ON public.messenger_messages USING btree (available_at);


--
-- Name: idx_75ea56e0fb7336f0; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_75ea56e0fb7336f0 ON public.messenger_messages USING btree (queue_name);


--
-- Name: idx_769be06f460d9fd7; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_769be06f460d9fd7 ON public.fav USING btree (node_id);


--
-- Name: idx_769be06fe4a59390; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_769be06fe4a59390 ON public.fav USING btree (u_id);


--
-- Name: idx_857fe84512469de2; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_857fe84512469de2 ON public.node USING btree (category_id);


--
-- Name: idx_857fe845727aca70; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_857fe845727aca70 ON public.node USING btree (parent_id);


--
-- Name: idx_857fe84582f1baf4; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_857fe84582f1baf4 ON public.node USING btree (language_id);


--
-- Name: idx_857fe845f675f31b; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_857fe845f675f31b ON public.node USING btree (author_id);


--
-- Name: idx_9474526c460d9fd7; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_9474526c460d9fd7 ON public.comment USING btree (node_id);


--
-- Name: idx_9474526cf675f31b; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_9474526cf675f31b ON public.comment USING btree (author_id);


--
-- Name: idx_ac6340b3460d9fd7; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_ac6340b3460d9fd7 ON public."like" USING btree (node_id);


--
-- Name: idx_ac6340b3e4a59390; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_ac6340b3e4a59390 ON public."like" USING btree (u_id);


--
-- Name: idx_bb70e4d3460d9fd7; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_bb70e4d3460d9fd7 ON public.node_region USING btree (node_id);


--
-- Name: idx_bb70e4d398260155; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_bb70e4d398260155 ON public.node_region USING btree (region_id);


--
-- Name: idx_c00e173e460d9fd7; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_c00e173e460d9fd7 ON public.spec USING btree (node_id);


--
-- Name: idx_c53d045f460d9fd7; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_c53d045f460d9fd7 ON public.image USING btree (node_id);


--
-- Name: idx_d2294458460d9fd7; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_d2294458460d9fd7 ON public.feedback USING btree (node_id);


--
-- Name: idx_d2294458e4a59390; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_d2294458e4a59390 ON public.feedback USING btree (u_id);


--
-- Name: idx_dfec3f39460d9fd7; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_dfec3f39460d9fd7 ON public.rate USING btree (node_id);


--
-- Name: idx_dfec3f39e4a59390; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_dfec3f39e4a59390 ON public.rate USING btree (u_id);


--
-- Name: idx_f529939837fdbd6d; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_f529939837fdbd6d ON public."order" USING btree (consumer_id);


--
-- Name: idx_f5299398460d9fd7; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_f5299398460d9fd7 ON public."order" USING btree (node_id);


--
-- Name: idx_f62f176c4663e4; Type: INDEX; Schema: public; Owner: yhb
--

CREATE INDEX idx_f62f176c4663e4 ON public.region USING btree (page_id);


--
-- Name: uniq_5b2c1458e636d3f5; Type: INDEX; Schema: public; Owner: yhb
--

CREATE UNIQUE INDEX uniq_5b2c1458e636d3f5 ON public.refund USING btree (ord_id);


--
-- Name: uniq_8d93d649f85e0677; Type: INDEX; Schema: public; Owner: yhb
--

CREATE UNIQUE INDEX uniq_8d93d649f85e0677 ON public."user" USING btree (username);


--
-- Name: messenger_messages notify_trigger; Type: TRIGGER; Schema: public; Owner: yhb
--

CREATE TRIGGER notify_trigger AFTER INSERT OR UPDATE ON public.messenger_messages FOR EACH ROW EXECUTE FUNCTION public.notify_messenger_messages();


--
-- Name: conf fk_14f389a882f1baf4; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.conf
    ADD CONSTRAINT fk_14f389a882f1baf4 FOREIGN KEY (language_id) REFERENCES public.language(id);


--
-- Name: down fk_1cff903b460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.down
    ADD CONSTRAINT fk_1cff903b460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: down fk_1cff903be4a59390; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.down
    ADD CONSTRAINT fk_1cff903be4a59390 FOREIGN KEY (u_id) REFERENCES public."user"(id);


--
-- Name: down fk_1cff903bf8697d13; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.down
    ADD CONSTRAINT fk_1cff903bf8697d13 FOREIGN KEY (comment_id) REFERENCES public.comment(id);


--
-- Name: link fk_36ac99f1ccd7e912; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.link
    ADD CONSTRAINT fk_36ac99f1ccd7e912 FOREIGN KEY (menu_id) REFERENCES public.menu(id);


--
-- Name: up fk_4394ee70460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.up
    ADD CONSTRAINT fk_4394ee70460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: up fk_4394ee70e4a59390; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.up
    ADD CONSTRAINT fk_4394ee70e4a59390 FOREIGN KEY (u_id) REFERENCES public."user"(id);


--
-- Name: up fk_4394ee70f8697d13; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.up
    ADD CONSTRAINT fk_4394ee70f8697d13 FOREIGN KEY (comment_id) REFERENCES public.comment(id);


--
-- Name: refund fk_5b2c1458e636d3f5; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.refund
    ADD CONSTRAINT fk_5b2c1458e636d3f5 FOREIGN KEY (ord_id) REFERENCES public."order"(id);


--
-- Name: node_tag fk_70ac95f8460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.node_tag
    ADD CONSTRAINT fk_70ac95f8460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id) ON DELETE CASCADE;


--
-- Name: node_tag fk_70ac95f8bad26311; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.node_tag
    ADD CONSTRAINT fk_70ac95f8bad26311 FOREIGN KEY (tag_id) REFERENCES public.tag(id) ON DELETE CASCADE;


--
-- Name: fav fk_769be06f460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.fav
    ADD CONSTRAINT fk_769be06f460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: fav fk_769be06fe4a59390; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.fav
    ADD CONSTRAINT fk_769be06fe4a59390 FOREIGN KEY (u_id) REFERENCES public."user"(id);


--
-- Name: node fk_857fe84512469de2; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT fk_857fe84512469de2 FOREIGN KEY (category_id) REFERENCES public.category(id);


--
-- Name: node fk_857fe845727aca70; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT fk_857fe845727aca70 FOREIGN KEY (parent_id) REFERENCES public.node(id);


--
-- Name: node fk_857fe84582f1baf4; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT fk_857fe84582f1baf4 FOREIGN KEY (language_id) REFERENCES public.language(id);


--
-- Name: node fk_857fe845f675f31b; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.node
    ADD CONSTRAINT fk_857fe845f675f31b FOREIGN KEY (author_id) REFERENCES public."user"(id);


--
-- Name: comment fk_9474526c460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT fk_9474526c460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: comment fk_9474526cf675f31b; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT fk_9474526cf675f31b FOREIGN KEY (author_id) REFERENCES public."user"(id);


--
-- Name: like fk_ac6340b3460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public."like"
    ADD CONSTRAINT fk_ac6340b3460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: like fk_ac6340b3e4a59390; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public."like"
    ADD CONSTRAINT fk_ac6340b3e4a59390 FOREIGN KEY (u_id) REFERENCES public."user"(id);


--
-- Name: node_region fk_bb70e4d3460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.node_region
    ADD CONSTRAINT fk_bb70e4d3460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id) ON DELETE CASCADE;


--
-- Name: node_region fk_bb70e4d398260155; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.node_region
    ADD CONSTRAINT fk_bb70e4d398260155 FOREIGN KEY (region_id) REFERENCES public.region(id) ON DELETE CASCADE;


--
-- Name: spec fk_c00e173e460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.spec
    ADD CONSTRAINT fk_c00e173e460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: image fk_c53d045f460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.image
    ADD CONSTRAINT fk_c53d045f460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: feedback fk_d2294458460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT fk_d2294458460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: feedback fk_d2294458e4a59390; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.feedback
    ADD CONSTRAINT fk_d2294458e4a59390 FOREIGN KEY (u_id) REFERENCES public."user"(id);


--
-- Name: rate fk_dfec3f39460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.rate
    ADD CONSTRAINT fk_dfec3f39460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: rate fk_dfec3f39e4a59390; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.rate
    ADD CONSTRAINT fk_dfec3f39e4a59390 FOREIGN KEY (u_id) REFERENCES public."user"(id);


--
-- Name: order fk_f529939837fdbd6d; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT fk_f529939837fdbd6d FOREIGN KEY (consumer_id) REFERENCES public."user"(id);


--
-- Name: order fk_f5299398460d9fd7; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public."order"
    ADD CONSTRAINT fk_f5299398460d9fd7 FOREIGN KEY (node_id) REFERENCES public.node(id);


--
-- Name: region fk_f62f176c4663e4; Type: FK CONSTRAINT; Schema: public; Owner: yhb
--

ALTER TABLE ONLY public.region
    ADD CONSTRAINT fk_f62f176c4663e4 FOREIGN KEY (page_id) REFERENCES public.page(id);


--
-- PostgreSQL database dump complete
--

