--
-- PostgreSQL database dump
--

\restrict r4hjhwPNGF9g2r1nN6qBueyNrRwJ7efIAWolGkdzJPKJbYARyQ6DccssCq8G1WS

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2025-12-25 13:18:45

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 5234 (class 1262 OID 147459)
-- Name: demo_storeDb; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE "demo_storeDb" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'br';


\unrestrict r4hjhwPNGF9g2r1nN6qBueyNrRwJ7efIAWolGkdzJPKJbYARyQ6DccssCq8G1WS
\connect "demo_storeDb"
\restrict r4hjhwPNGF9g2r1nN6qBueyNrRwJ7efIAWolGkdzJPKJbYARyQ6DccssCq8G1WS

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- TOC entry 6 (class 2615 OID 147860)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

-- *not* creating schema, since initdb creates it


--
-- TOC entry 5235 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS '';


--
-- TOC entry 2 (class 3079 OID 147971)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA public;


--
-- TOC entry 5237 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 314 (class 1255 OID 148008)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: public; Owner: -
--

CREATE FUNCTION public.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
   NEW.updated_at = NOW();
   RETURN NEW;
END;
$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 218 (class 1259 OID 148009)
-- Name: addresses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.addresses (
    id integer NOT NULL,
    client_user_id uuid NOT NULL,
    cep character varying(9) NOT NULL,
    logradouro character varying(255) NOT NULL,
    numero character varying(20) NOT NULL,
    complemento character varying(100),
    bairro character varying(100) NOT NULL,
    cidade character varying(100) NOT NULL,
    estado character varying(2) NOT NULL,
    pais character varying(50),
    referencia character varying(255),
    created_at timestamp without time zone DEFAULT now(),
    updated_at timestamp without time zone DEFAULT now(),
    profile_id uuid
);


--
-- TOC entry 219 (class 1259 OID 148016)
-- Name: addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.addresses_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5238 (class 0 OID 0)
-- Dependencies: 219
-- Name: addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.addresses_id_seq OWNED BY public.addresses.id;


--
-- TOC entry 220 (class 1259 OID 148017)
-- Name: blog_posts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.blog_posts (
    id integer NOT NULL,
    page_id integer NOT NULL,
    slug character varying(255) NOT NULL,
    title character varying(255) NOT NULL,
    excerpt character varying(300),
    content text NOT NULL,
    cover_image character varying(500),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- TOC entry 221 (class 1259 OID 148022)
-- Name: blog_posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.blog_posts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5239 (class 0 OID 0)
-- Dependencies: 221
-- Name: blog_posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.blog_posts_id_seq OWNED BY public.blog_posts.id;


--
-- TOC entry 222 (class 1259 OID 148023)
-- Name: cart_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cart_items (
    id integer NOT NULL,
    cart_id integer NOT NULL,
    product_id integer NOT NULL,
    product_name text NOT NULL,
    product_price numeric(10,2) NOT NULL,
    product_image text,
    product_height numeric(10,2),
    product_width numeric(10,2),
    product_weight numeric(10,2),
    product_length numeric(10,2),
    quantity integer,
    created_at timestamp without time zone,
    user_id uuid,
    variation_data json
);


--
-- TOC entry 223 (class 1259 OID 148028)
-- Name: cart_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.cart_items_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5240 (class 0 OID 0)
-- Dependencies: 223
-- Name: cart_items_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.cart_items_id_seq OWNED BY public.cart_items.id;


--
-- TOC entry 224 (class 1259 OID 148029)
-- Name: carts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.carts (
    id integer NOT NULL,
    created_at timestamp without time zone,
    client_id uuid,
    user_id uuid
);


--
-- TOC entry 225 (class 1259 OID 148032)
-- Name: carts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.carts_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5241 (class 0 OID 0)
-- Dependencies: 225
-- Name: carts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.carts_id_seq OWNED BY public.carts.id;


--
-- TOC entry 276 (class 1259 OID 148311)
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    name character varying(50),
    is_subcategory boolean,
    parent_id integer,
    user_id uuid,
    id integer NOT NULL
);


--
-- TOC entry 277 (class 1259 OID 148336)
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.categories ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 226 (class 1259 OID 148036)
-- Name: client_users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.client_users (
    name character varying(150) NOT NULL,
    birth_date date NOT NULL,
    email character varying(150) NOT NULL,
    password_hash character varying(255) NOT NULL,
    type character varying(50) DEFAULT 'client'::character varying,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_at timestamp without time zone,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- TOC entry 227 (class 1259 OID 148044)
-- Name: comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.comments (
    id integer NOT NULL,
    comment character varying(128),
    user_id character varying(50),
    user_name character varying(50),
    product_id integer,
    status character varying(50),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    avatar_url character varying(256)
);


--
-- TOC entry 228 (class 1259 OID 148049)
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5242 (class 0 OID 0)
-- Dependencies: 228
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.comments_id_seq OWNED BY public.comments.id;


--
-- TOC entry 229 (class 1259 OID 148050)
-- Name: coupons; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coupons (
    id integer NOT NULL,
    user_id integer,
    title character varying(50),
    code character varying(50),
    discount real,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    image_path character varying(128),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    client_username character varying(50),
    client_id character varying(50)
);


--
-- TOC entry 230 (class 1259 OID 148053)
-- Name: coupons_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.coupons ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.coupons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 231 (class 1259 OID 148054)
-- Name: coupons_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.coupons_user (
    id integer NOT NULL,
    coupon_id integer,
    title character varying(50),
    code character varying(50),
    discount real,
    start_date character varying(50),
    end_date character varying(50),
    created_at character varying(50),
    client_username character varying(50),
    updated_at character varying(50),
    client_id uuid
);


--
-- TOC entry 232 (class 1259 OID 148057)
-- Name: coupons_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.coupons_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.coupons_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 233 (class 1259 OID 148058)
-- Name: delivery_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.delivery_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 234 (class 1259 OID 148059)
-- Name: delivery; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.delivery (
    id integer DEFAULT nextval('public.delivery_id_seq'::regclass),
    product_ids json,
    recipient_name character varying(50),
    street character varying(50),
    number integer,
    complement character varying(50),
    city character varying(50),
    state character varying(50),
    zip_code character varying(50),
    country character varying(50),
    phone character varying(50),
    bairro character varying(50),
    total_value numeric(10,2),
    delivery_id integer,
    width real,
    height real,
    length real,
    weight real,
    melhorenvio_id character varying(50),
    order_id character varying(50),
    user_id character varying(255),
    user_name character varying(50),
    serviceid character varying(50),
    quote numeric,
    coupon character varying(50),
    discount numeric,
    delivery_min character varying(50),
    delivery_max character varying(50),
    status character varying(50),
    diameter numeric,
    format character varying(50),
    billed_weight numeric,
    receipt character varying(50),
    own_hand character varying(50),
    collect character varying(50),
    collect_schedule_at timestamp without time zone,
    reverse character varying(50),
    non_commercial character varying(50),
    authorization_code character varying(50),
    tracking character varying(50),
    self_tracking character varying(50),
    delivery_receipt character varying(50),
    additional_info character varying(50),
    cte_key character varying(50),
    paid_at timestamp without time zone,
    generated_at timestamp without time zone,
    posted_at timestamp without time zone,
    delivered_at timestamp without time zone,
    canceled_at timestamp without time zone,
    suspend_at timestamp without time zone,
    expired_at timestamp without time zone,
    create_at timestamp without time zone,
    updated_at timestamp without time zone,
    parse_api_at timestamp without time zone,
    received_at timestamp without time zone,
    risk character varying(50),
    product_id json
);


--
-- TOC entry 235 (class 1259 OID 148065)
-- Name: notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.notifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 236 (class 1259 OID 148066)
-- Name: notifications; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.notifications (
    id integer DEFAULT nextval('public.notifications_id_seq'::regclass),
    user_id character varying(50),
    message character varying(128),
    is_read boolean,
    created_at character varying(50),
    is_global boolean
);


--
-- TOC entry 237 (class 1259 OID 148070)
-- Name: order_items_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.order_items_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 238 (class 1259 OID 148071)
-- Name: order_items; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.order_items (
    id integer DEFAULT nextval('public.order_items_id_seq'::regclass),
    order_id integer,
    product_id integer,
    quantity integer,
    unit_price real,
    total_price real
);


--
-- TOC entry 239 (class 1259 OID 148075)
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    payment_id integer,
    delivery_id integer,
    shipment_info character varying(50),
    total_amount real,
    order_date timestamp without time zone,
    status character varying(50),
    user_id uuid
);


--
-- TOC entry 240 (class 1259 OID 148078)
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.orders ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 241 (class 1259 OID 148079)
-- Name: pages; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.pages (
    name character varying(50),
    title character varying(50),
    content character varying(50),
    hero_title character varying(50),
    hero_subtitle character varying(128),
    hero_background_color character varying(50),
    hero_image character varying(128),
    hero_buttons character varying(512),
    carousel_images character varying(50),
    footer_text character varying(50),
    id integer NOT NULL
);


--
-- TOC entry 242 (class 1259 OID 148084)
-- Name: pages_new_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.pages_new_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5243 (class 0 OID 0)
-- Dependencies: 242
-- Name: pages_new_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.pages_new_id_seq OWNED BY public.pages.id;


--
-- TOC entry 243 (class 1259 OID 148085)
-- Name: password_reset_token; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.password_reset_token (
    id character varying(50),
    user_id character varying(50),
    token character varying(50),
    expire_at character varying(50)
);


--
-- TOC entry 244 (class 1259 OID 148088)
-- Name: payment_products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payment_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 245 (class 1259 OID 148089)
-- Name: payments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payments (
    id integer NOT NULL,
    payment_id text,
    total_value real,
    payment_date character varying(50),
    payment_type character varying(50),
    cpf character varying(11),
    email character varying(50),
    status character varying(50),
    usuario_id uuid,
    coupon_code character varying(50),
    coupon_amount real,
    name character varying(50)
);


--
-- TOC entry 246 (class 1259 OID 148094)
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.payments ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 247 (class 1259 OID 148095)
-- Name: payments_product_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.payments_product_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 248 (class 1259 OID 148096)
-- Name: payments_product; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.payments_product (
    id integer DEFAULT nextval('public.payments_product_id_seq'::regclass) NOT NULL,
    payment_id integer,
    product_id integer,
    product_name character varying(64),
    product_quantity integer,
    product_price real
);


--
-- TOC entry 249 (class 1259 OID 148100)
-- Name: post_comments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.post_comments (
    id integer NOT NULL,
    post_id integer NOT NULL,
    user_id uuid,
    username character varying(100),
    user_avatar character varying(500),
    login_provider character varying(50),
    text text NOT NULL,
    status character varying(20) NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- TOC entry 250 (class 1259 OID 148105)
-- Name: post_comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.post_comments_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5244 (class 0 OID 0)
-- Dependencies: 250
-- Name: post_comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.post_comments_id_seq OWNED BY public.post_comments.id;


--
-- TOC entry 251 (class 1259 OID 148106)
-- Name: post_seo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.post_seo (
    id integer NOT NULL,
    post_id integer NOT NULL,
    keywords character varying(255),
    description character varying(255),
    canonical_url character varying(255),
    og_title character varying(255),
    og_description character varying(255),
    og_image character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- TOC entry 252 (class 1259 OID 148111)
-- Name: post_seo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.post_seo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5245 (class 0 OID 0)
-- Dependencies: 252
-- Name: post_seo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.post_seo_id_seq OWNED BY public.post_seo.id;


--
-- TOC entry 253 (class 1259 OID 148112)
-- Name: post_views; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.post_views (
    id integer NOT NULL,
    post_id integer NOT NULL,
    created_at timestamp without time zone
);


--
-- TOC entry 254 (class 1259 OID 148115)
-- Name: post_views_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.post_views_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5246 (class 0 OID 0)
-- Dependencies: 254
-- Name: post_views_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.post_views_id_seq OWNED BY public.post_views.id;


--
-- TOC entry 255 (class 1259 OID 148116)
-- Name: product_images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_images (
    id integer NOT NULL,
    product_id integer,
    image_path character varying(256),
    is_thumbnail boolean,
    created_at timestamp without time zone
);


--
-- TOC entry 256 (class 1259 OID 148119)
-- Name: product_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.product_images ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.product_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 257 (class 1259 OID 148120)
-- Name: product_seo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_seo (
    id integer NOT NULL,
    product_id integer,
    meta_title character varying(128),
    meta_description character varying(512),
    slug character varying(50),
    keywords character varying(512),
    created_at character varying(50),
    updated_at character varying(50)
);


--
-- TOC entry 258 (class 1259 OID 148125)
-- Name: product_seo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.product_seo ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.product_seo_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 259 (class 1259 OID 148126)
-- Name: product_variations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_variations (
    id integer NOT NULL,
    product_id integer NOT NULL,
    product_name character varying(255) NOT NULL,
    variation_type character varying(20) NOT NULL,
    value character varying(255) NOT NULL,
    quantity integer NOT NULL,
    created_at timestamp without time zone
);


--
-- TOC entry 260 (class 1259 OID 148131)
-- Name: product_variations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.product_variations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5247 (class 0 OID 0)
-- Dependencies: 260
-- Name: product_variations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.product_variations_id_seq OWNED BY public.product_variations.id;


--
-- TOC entry 261 (class 1259 OID 148132)
-- Name: product_videos; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.product_videos (
    id character varying(50),
    product_id integer,
    video_path character varying(50),
    created_at timestamp without time zone
);


--
-- TOC entry 262 (class 1259 OID 148135)
-- Name: products; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.products (
    id integer NOT NULL,
    name character varying(128),
    description character varying(1024),
    price numeric(10,2),
    category_id integer,
    subcategory_id integer,
    image_paths json,
    quantity integer,
    width real,
    height real,
    weight real,
    length real,
    user_id text,
    thumbnail_path character varying(512)
);


--
-- TOC entry 263 (class 1259 OID 148140)
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.products ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 264 (class 1259 OID 148141)
-- Name: profiles; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.profiles (
    user_id uuid,
    username character varying(50),
    full_name character varying(50),
    birth_date character varying(50),
    avatar_url character varying(255),
    phone character varying(20) DEFAULT ''::character varying NOT NULL,
    mobile character varying(20) DEFAULT ''::character varying NOT NULL,
    id integer NOT NULL,
    client_user_id uuid,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- TOC entry 265 (class 1259 OID 148148)
-- Name: profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.profiles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5248 (class 0 OID 0)
-- Dependencies: 265
-- Name: profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.profiles_id_seq OWNED BY public.profiles.id;


--
-- TOC entry 266 (class 1259 OID 148149)
-- Name: seo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.seo (
    id integer,
    route integer,
    metatitle character varying(128),
    metadescription character varying(256),
    metakeywords character varying(256),
    ogtitle character varying(64),
    ogdescription character varying(256),
    ogimage character varying(128)
);


--
-- TOC entry 267 (class 1259 OID 148154)
-- Name: stock; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.stock (
    id integer NOT NULL,
    id_product integer,
    user_id text,
    category_id integer,
    product_name character varying(128),
    product_price real,
    product_quantity real,
    variations jsonb,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- TOC entry 268 (class 1259 OID 148159)
-- Name: stock_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.stock ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.stock_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 269 (class 1259 OID 148160)
-- Name: subcategories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.subcategories (
    id character varying(50),
    name character varying(50),
    category_id character varying(50)
);


--
-- TOC entry 270 (class 1259 OID 148163)
-- Name: token_blocklist; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.token_blocklist (
    id integer NOT NULL,
    jti character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    created_at timestamp without time zone
);


--
-- TOC entry 271 (class 1259 OID 148166)
-- Name: token_blocklist_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.token_blocklist_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5249 (class 0 OID 0)
-- Dependencies: 271
-- Name: token_blocklist_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.token_blocklist_id_seq OWNED BY public.token_blocklist.id;


--
-- TOC entry 272 (class 1259 OID 148167)
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    email character varying(50),
    password character varying(64),
    name character varying(50),
    birth_date character varying(50),
    type character varying(50) DEFAULT 'client'::character varying NOT NULL,
    fcm_token text,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


--
-- TOC entry 273 (class 1259 OID 148176)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 274 (class 1259 OID 148177)
-- Name: variations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.variations (
    id integer NOT NULL,
    product_id integer NOT NULL,
    variation_type character varying(50) NOT NULL,
    value character varying(100) NOT NULL,
    quantity integer
);


--
-- TOC entry 275 (class 1259 OID 148180)
-- Name: variations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.variations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 5250 (class 0 OID 0)
-- Dependencies: 275
-- Name: variations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.variations_id_seq OWNED BY public.variations.id;


--
-- TOC entry 4931 (class 2604 OID 148314)
-- Name: addresses id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses ALTER COLUMN id SET DEFAULT nextval('public.addresses_id_seq'::regclass);


--
-- TOC entry 4934 (class 2604 OID 148315)
-- Name: blog_posts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts ALTER COLUMN id SET DEFAULT nextval('public.blog_posts_id_seq'::regclass);


--
-- TOC entry 4935 (class 2604 OID 148316)
-- Name: cart_items id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items ALTER COLUMN id SET DEFAULT nextval('public.cart_items_id_seq'::regclass);


--
-- TOC entry 4936 (class 2604 OID 148317)
-- Name: carts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts ALTER COLUMN id SET DEFAULT nextval('public.carts_id_seq'::regclass);


--
-- TOC entry 4940 (class 2604 OID 148318)
-- Name: comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.comments ALTER COLUMN id SET DEFAULT nextval('public.comments_id_seq'::regclass);


--
-- TOC entry 4944 (class 2604 OID 148319)
-- Name: pages id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pages ALTER COLUMN id SET DEFAULT nextval('public.pages_new_id_seq'::regclass);


--
-- TOC entry 4946 (class 2604 OID 148320)
-- Name: post_comments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_comments ALTER COLUMN id SET DEFAULT nextval('public.post_comments_id_seq'::regclass);


--
-- TOC entry 4947 (class 2604 OID 148321)
-- Name: post_seo id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_seo ALTER COLUMN id SET DEFAULT nextval('public.post_seo_id_seq'::regclass);


--
-- TOC entry 4948 (class 2604 OID 148322)
-- Name: post_views id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_views ALTER COLUMN id SET DEFAULT nextval('public.post_views_id_seq'::regclass);


--
-- TOC entry 4949 (class 2604 OID 148323)
-- Name: product_variations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variations ALTER COLUMN id SET DEFAULT nextval('public.product_variations_id_seq'::regclass);


--
-- TOC entry 4952 (class 2604 OID 148324)
-- Name: profiles id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles ALTER COLUMN id SET DEFAULT nextval('public.profiles_id_seq'::regclass);


--
-- TOC entry 4955 (class 2604 OID 148325)
-- Name: token_blocklist id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.token_blocklist ALTER COLUMN id SET DEFAULT nextval('public.token_blocklist_id_seq'::regclass);


--
-- TOC entry 4960 (class 2604 OID 148326)
-- Name: variations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variations ALTER COLUMN id SET DEFAULT nextval('public.variations_id_seq'::regclass);


--
-- TOC entry 5169 (class 0 OID 148009)
-- Dependencies: 218
-- Data for Name: addresses; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.addresses VALUES (48, 'e77f01ac-251c-4a28-9a23-e55fba2afc13', '73082-180', 'Quadra QMS 19', '11', 'sadsadsa', 'Setor de Mansões de Sobradinho', 'Brasília', 'DF', 'sadsadsa', NULL, '2025-12-24 12:17:48.020494', '2025-12-24 12:17:48.020494', NULL);


--
-- TOC entry 5171 (class 0 OID 148017)
-- Dependencies: 220
-- Data for Name: blog_posts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.blog_posts VALUES (23, 1, 'como-escolher-sua-seda', 'Como escolher sua seda ', 'Descubra a melhor forma de escolher a sua seda', '<p><strong>sadsadsadsadsasdsadsadsadsaguy</strong></p><p>&lt;ad-banner slot="1234567890" format="auto"&gt;&lt;/ad-banner&gt;</p><p><strong>oifjdsoifjdsofd</strong></p><p>&lt;ad-banner slot="1234567890" format="auto"&gt;&lt;/ad-banner&gt;</p><p><strong>dsadihsaiudhsaiudhsaidsa</strong></p><p>&lt;ad-banner slot="1234567890" format="auto"&gt;&lt;/ad-banner&gt;</p>', 'https://res.cloudinary.com/dnfnevy9e/image/upload/v1759169702/blogs/como-escolher-sua-seda/cover.png', '2025-09-29 18:15:01.408837', NULL);


--
-- TOC entry 5173 (class 0 OID 148023)
-- Dependencies: 222
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.cart_items VALUES (124, 6, 82, 'Camiseta Oversize Roxa', 69.90, 'https://res.cloudinary.com/dnfnevy9e/image/upload/v1766587112/product_images/Camiseta_Oversize_Roxa/56710d72-89e2-45a8-8201-4f1d605aeb02_20251224143832270922.png', 3.00, 25.00, 0.30, 30.00, 1, '2025-12-24 14:42:24.727603', 'e77f01ac-251c-4a28-9a23-e55fba2afc13', '[{"variation_id": 84, "quantity": 1, "value": "XG"}, {"variation_id": 89, "quantity": 1, "value": "#8507F3"}]');
INSERT INTO public.cart_items VALUES (130, 6, 83, 'Caneca Personalizada', 34.90, 'https://res.cloudinary.com/dnfnevy9e/image/upload/v1766590169/product_images/Caneca_Personalizada/5ccb5095-0ea3-414a-ab09-088f9b944bcc_20251224152927255332.png', 9.50, 12.00, 0.40, 12.00, 1, '2025-12-24 15:40:52.348656', 'e77f01ac-251c-4a28-9a23-e55fba2afc13', '[{"variation_id": 91, "quantity": 1, "value": "#FCF8F8"}]');


--
-- TOC entry 5175 (class 0 OID 148029)
-- Dependencies: 224
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.carts VALUES (5, '2025-12-24 14:41:32.656092', NULL, '9d509dc8-9f53-4be5-985a-7105090a1a23');
INSERT INTO public.carts VALUES (6, '2025-12-24 14:42:24.676023', NULL, 'e77f01ac-251c-4a28-9a23-e55fba2afc13');


--
-- TOC entry 5227 (class 0 OID 148311)
-- Dependencies: 276
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.categories OVERRIDING SYSTEM VALUE VALUES ('Camisetas', false, NULL, '9d509dc8-9f53-4be5-985a-7105090a1a23', 31);
INSERT INTO public.categories OVERRIDING SYSTEM VALUE VALUES ('Básica', true, 31, '9d509dc8-9f53-4be5-985a-7105090a1a23', 32);
INSERT INTO public.categories OVERRIDING SYSTEM VALUE VALUES ('Canecas', false, NULL, '9d509dc8-9f53-4be5-985a-7105090a1a23', 33);
INSERT INTO public.categories OVERRIDING SYSTEM VALUE VALUES ('Personalizadas', true, 33, '9d509dc8-9f53-4be5-985a-7105090a1a23', 34);
INSERT INTO public.categories OVERRIDING SYSTEM VALUE VALUES ('Bonés', false, NULL, '9d509dc8-9f53-4be5-985a-7105090a1a23', 35);
INSERT INTO public.categories OVERRIDING SYSTEM VALUE VALUES ('Casual', true, 31, '9d509dc8-9f53-4be5-985a-7105090a1a23', 36);
INSERT INTO public.categories OVERRIDING SYSTEM VALUE VALUES ('Casual', true, 35, '9d509dc8-9f53-4be5-985a-7105090a1a23', 37);
INSERT INTO public.categories OVERRIDING SYSTEM VALUE VALUES ('Moletom', false, NULL, '9d509dc8-9f53-4be5-985a-7105090a1a23', 38);
INSERT INTO public.categories OVERRIDING SYSTEM VALUE VALUES ('Casual', true, 38, '9d509dc8-9f53-4be5-985a-7105090a1a23', 39);


--
-- TOC entry 5177 (class 0 OID 148036)
-- Dependencies: 226
-- Data for Name: client_users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.client_users VALUES ('rafael ', '2004-02-26', 'rafael.f.p.faria@hotmail.com', 'scrypt:32768:8:1$hlxgmAsjPZYL9W6q$78e9945f93bccd4bfd69e10ffd65db2698412b4fe8af76bde924dd395a98e38b862f5e556d3027126006dba58d5d4baaed40478759acb701cb9c833c1ff06367', 'client', '2025-10-24 16:00:57.076011', NULL, 'e77f01ac-251c-4a28-9a23-e55fba2afc13');


--
-- TOC entry 5178 (class 0 OID 148044)
-- Dependencies: 227
-- Data for Name: comments; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5180 (class 0 OID 148050)
-- Dependencies: 229
-- Data for Name: coupons; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5182 (class 0 OID 148054)
-- Dependencies: 231
-- Data for Name: coupons_user; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5185 (class 0 OID 148059)
-- Dependencies: 234
-- Data for Name: delivery; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.delivery VALUES (124, '["82"]', 'rafael ', 'Quadra QMS 19', 11, 'sadsadsa', 'Brasília', 'DF', '73082-180', 'sadsadsa', NULL, 'Setor de Mansões de Sobradinho', 162.33, NULL, 25, 3, 30, 0.3, NULL, NULL, 'e77f01ac-251c-4a28-9a23-e55fba2afc13', 'apro', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL);


--
-- TOC entry 5187 (class 0 OID 148066)
-- Dependencies: 236
-- Data for Name: notifications; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.notifications VALUES (63, '9d509dc8-9f53-4be5-985a-7105090a1a23', 'Novo pedido recebido: #245, Para: Cliente, valor total: R$162.33', false, '2025-12-24 15:19:54.102097', true);
INSERT INTO public.notifications VALUES (64, '2270f1e3-99e8-42c0-a0d7-930e750c8749', 'Novo pedido recebido: #245, Para: Cliente, valor total: R$162.33', false, '2025-12-24 15:19:54.150893', true);
INSERT INTO public.notifications VALUES (65, '97832ada-019c-42e3-b1e7-4b7f3c09a35c', 'Novo pedido recebido: #245, Para: Cliente, valor total: R$162.33', false, '2025-12-24 15:19:54.309554', true);


--
-- TOC entry 5189 (class 0 OID 148071)
-- Dependencies: 238
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.order_items VALUES (195, 245, 82, 1, 69.9, 162.33);


--
-- TOC entry 5190 (class 0 OID 148075)
-- Dependencies: 239
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.orders VALUES (245, 176, 124, '73082-180', 162.33, '2025-12-24 15:19:54.097469', 'approved', 'e77f01ac-251c-4a28-9a23-e55fba2afc13');


--
-- TOC entry 5192 (class 0 OID 148079)
-- Dependencies: 241
-- Data for Name: pages; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.pages VALUES ('Blog', 'Blog', '<p>Blog description</p>', 'Blog', 'Blog', '#3F51B5', 'http://localhost:5000/uploadImages/uploads/logo.png', '[]', '[]', '', 1);
INSERT INTO public.pages VALUES ('Home Page', 'Home Page', '<p><strong>Welcome To...</strong></p>', 'Tudo que você precisa para relaxar !', 'Kits completos com os melhores acessórios, entregues na sua porta.', '#000000', 'http://localhost:5000/uploadImages/uploads/logo.png', '[{"label": "Hero Button", "url": "fdsfds", "icon": {"title": "Facebook", "value": "mdi-facebook"}, "heroButtonBackgroundColor": "#000000"}]', '[]', '', 5);


--
-- TOC entry 5194 (class 0 OID 148085)
-- Dependencies: 243
-- Data for Name: password_reset_token; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5196 (class 0 OID 148089)
-- Dependencies: 245
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.payments OVERRIDING SYSTEM VALUE VALUES (176, '1343394843', 162.33, '2025-12-24T11:19:53.934-04:00', 'crédito', '12345678909', 'rafael.f.p.faria@hotmail.com', 'approved', 'e77f01ac-251c-4a28-9a23-e55fba2afc13', NULL, 0, 'apro');


--
-- TOC entry 5199 (class 0 OID 148096)
-- Dependencies: 248
-- Data for Name: payments_product; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.payments_product VALUES (308, 176, 82, 'Camiseta Oversize Roxa', 1, 69.9);


--
-- TOC entry 5200 (class 0 OID 148100)
-- Dependencies: 249
-- Data for Name: post_comments; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5202 (class 0 OID 148106)
-- Dependencies: 251
-- Data for Name: post_seo; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5204 (class 0 OID 148112)
-- Dependencies: 253
-- Data for Name: post_views; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5206 (class 0 OID 148116)
-- Dependencies: 255
-- Data for Name: product_images; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.product_images OVERRIDING SYSTEM VALUE VALUES (27, 82, 'https://res.cloudinary.com/dnfnevy9e/image/upload/v1766587114/product_images/Camiseta_Oversize_Roxa/56710d72-89e2-45a8-8201-4f1d605aeb02_20251224143833299945.png', false, '2025-12-24 11:38:34.630266');
INSERT INTO public.product_images OVERRIDING SYSTEM VALUE VALUES (28, 84, 'https://res.cloudinary.com/dnfnevy9e/image/upload/v1766604829/product_images/Bone_Casual/ChatGPT_Image_24_de_dez._de_2025_16_26_27_20251224193348016809.png', false, '2025-12-24 16:33:50.003474');
INSERT INTO public.product_images OVERRIDING SYSTEM VALUE VALUES (29, 84, 'https://res.cloudinary.com/dnfnevy9e/image/upload/v1766604830/product_images/Bone_Casual/ChatGPT_Image_24_de_dez._de_2025_16_28_26_20251224193348996955.png', false, '2025-12-24 16:33:50.003474');
INSERT INTO public.product_images OVERRIDING SYSTEM VALUE VALUES (30, 85, 'https://res.cloudinary.com/dnfnevy9e/image/upload/v1766606663/product_images/Moletom_Demo_Store__Preto_Classico/ChatGPT_Image_24_de_dez._de_2025_16_56_51_20251224200421242675.jpg', false, '2025-12-24 17:04:24.895196');
INSERT INTO public.product_images OVERRIDING SYSTEM VALUE VALUES (31, 85, 'https://res.cloudinary.com/dnfnevy9e/image/upload/v1766606665/product_images/Moletom_Demo_Store__Preto_Classico/ChatGPT_Image_24_de_dez._de_2025_16_56_57_20251224200423173407.jpg', false, '2025-12-24 17:04:24.895196');


--
-- TOC entry 5208 (class 0 OID 148120)
-- Dependencies: 257
-- Data for Name: product_seo; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.product_seo VALUES (66, 82, 'Camiseta Oversize Roxa | Estilo Urbano – Rua11 Store', 'Camiseta oversize roxa com estilo urbano, confortável e versátil. Ideal para quem busca atitude, conforto e visual moderno no dia a dia.', 'camiseta-oversize-roxa-rua11', 'camiseta oversize roxa, camiseta oversized, camiseta streetwear, camiseta urbana, camiseta casual, moda streetwear, camiseta unissex, rua11 store', '2025-12-24 14:38:34.581897', '2025-12-24 14:38:34.581901');
INSERT INTO public.product_seo VALUES (67, 83, 'Caneca Personalizada em Cerâmica | Presente Criativo', 'Caneca personalizada em cerâmica com estampa exclusiva, ideal para presentear ou uso diário. Produto resistente, acabamento brilhante e frete simples.', 'caneca-personalizada-ceramica', 'caneca personalizada, caneca de cerâmica, caneca personalizada com nome, caneca para presente, caneca criativa, caneca personalizada barata, caneca personalizada ecommerce, caneca decorada, caneca café personalizada', '2025-12-24 15:29:30.136789', '2025-12-24 15:29:30.136792');
INSERT INTO public.product_seo VALUES (68, 84, 'Boné Casual Ajustável | Estilo e Conforto para o Dia a Dia', 'Boné casual ajustável com design moderno, confortável e resistente. Ideal para uso diário, lazer e estilo urbano. Aproveite.
', 'bone-casual', 'boné casual,boné masculino,boné ajustável,boné moderno,acessório de moda,boné urbano,boné para o dia a dia,boné estiloso', '2025-12-24 19:33:49.959123', '2025-12-24 19:33:49.959126');
INSERT INTO public.product_seo VALUES (69, 85, 'Moletom Preto Demo Store Masculino | Conforto e Estilo Urbano', 'Moletom preto Demo Store masculino com capuz, bolso canguru e estampa exclusiva. Confortável, estiloso e ideal para o dia a dia urbano.', 'moletom-preto-demo-store-masculino', 'moletom preto, moletom masculino, moletom com capuz, moletom streetwear, moletom urbano, moletom demo store, roupa masculina, hoodie preto', '2025-12-24 20:04:24.741318', '2025-12-24 20:04:24.741322');


--
-- TOC entry 5210 (class 0 OID 148126)
-- Dependencies: 259
-- Data for Name: product_variations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.product_variations VALUES (84, 82, 'Camiseta Oversize Roxa', 'Size', 'XG', 10, '2025-12-24 14:38:34.583401');
INSERT INTO public.product_variations VALUES (85, 82, 'Camiseta Oversize Roxa', 'Size', 'GG', 10, '2025-12-24 14:38:34.583403');
INSERT INTO public.product_variations VALUES (86, 82, 'Camiseta Oversize Roxa', 'Size', 'G', 10, '2025-12-24 14:38:34.583405');
INSERT INTO public.product_variations VALUES (87, 82, 'Camiseta Oversize Roxa', 'Size', 'M', 10, '2025-12-24 14:38:34.583406');
INSERT INTO public.product_variations VALUES (88, 82, 'Camiseta Oversize Roxa', 'Size', 'P', 10, '2025-12-24 14:38:34.583407');
INSERT INTO public.product_variations VALUES (89, 82, 'Camiseta Oversize Roxa', 'Color', '#8507F3', 10, '2025-12-24 14:38:34.583408');
INSERT INTO public.product_variations VALUES (90, 82, 'Camiseta Oversize Roxa', 'Color', '#0F0F0F', 10, '2025-12-24 14:38:34.583409');
INSERT INTO public.product_variations VALUES (91, 83, 'Caneca Personalizada', 'Color', '#FCF8F8', 1, '2025-12-24 15:40:25.038978');
INSERT INTO public.product_variations VALUES (92, 84, 'Boné Casual', 'Color', '#0C0C0C', 10, '2025-12-24 19:33:49.960112');
INSERT INTO public.product_variations VALUES (93, 85, 'Moletom Demo Store – Preto Clássico', 'Size', 'GG', 10, '2025-12-24 20:04:24.742482');
INSERT INTO public.product_variations VALUES (94, 85, 'Moletom Demo Store – Preto Clássico', 'Color', '#070707', 10, '2025-12-24 20:04:24.742485');


--
-- TOC entry 5212 (class 0 OID 148132)
-- Dependencies: 261
-- Data for Name: product_videos; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5213 (class 0 OID 148135)
-- Dependencies: 262
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (82, 'Camiseta Oversize Roxa', 'Camiseta oversize confeccionada em algodão de alta qualidade, com caimento confortável e moderno. Ideal para o dia a dia, oferece liberdade de movimento e um visual urbano. Possui gola reforçada, mangas amplas e acabamento premium, garantindo durabilidade e estilo.

Produto pensado para quem busca conforto sem abrir mão do visual.', 69.90, 31, 32, '["https://res.cloudinary.com/dnfnevy9e/image/upload/v1766587114/product_images/Camiseta_Oversize_Roxa/56710d72-89e2-45a8-8201-4f1d605aeb02_20251224143833299945.png"]', 50, 25, 3, 0.3, 30, '9d509dc8-9f53-4be5-985a-7105090a1a23', 'https://res.cloudinary.com/dnfnevy9e/image/upload/v1766587112/product_images/Camiseta_Oversize_Roxa/56710d72-89e2-45a8-8201-4f1d605aeb02_20251224143832270922.png');
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (83, 'Caneca Personalizada', 'Caneca personalizada em cerâmica de alta qualidade, ideal para presentear ou uso diário. Possui acabamento brilhante, estampa nítida e durável, resistente a lavagens. Perfeita para café, chá ou outras bebidas quentes e frias. Produto exclusivo, sem variação de modelo.

📏 Dimensões e Especificações

Altura: 9,5 cm

Largura: 8 cm

Largura (com alça): 12 cm

Peso: 400 g

Capacidade aproximada: 325 ml

📦 Informações adicionais

Variações: Não possui

Material: Cerâmica

', 34.90, 33, 34, '[""]', 100, 12, 9.5, 0.4, 12, '9d509dc8-9f53-4be5-985a-7105090a1a23', 'https://res.cloudinary.com/dnfnevy9e/image/upload/v1766590169/product_images/Caneca_Personalizada/5ccb5095-0ea3-414a-ab09-088f9b944bcc_20251224152927255332.png');
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (84, 'Boné Casual', 'O Boné Casual é a escolha ideal para quem busca estilo e conforto no dia a dia. Com design moderno e acabamento de qualidade, ele combina facilmente com diferentes looks, sendo perfeito para uso urbano, lazer ou atividades ao ar livre. Possui ajuste traseiro que garante melhor encaixe na cabeça e aba curva que oferece proteção contra o sol. Um acessório versátil, resistente e cheio de personalidade.', 59.90, 35, 37, '["https://res.cloudinary.com/dnfnevy9e/image/upload/v1766604829/product_images/Bone_Casual/ChatGPT_Image_24_de_dez._de_2025_16_26_27_20251224193348016809.png", "https://res.cloudinary.com/dnfnevy9e/image/upload/v1766604830/product_images/Bone_Casual/ChatGPT_Image_24_de_dez._de_2025_16_28_26_20251224193348996955.png"]', 10, 18, 13, 0.25, 28, '9d509dc8-9f53-4be5-985a-7105090a1a23', 'https://res.cloudinary.com/dnfnevy9e/image/upload/v1766604828/product_images/Bone_Casual/ChatGPT_Image_24_de_dez._de_2025_16_25_34_20251224193345560596.png');
INSERT INTO public.products OVERRIDING SYSTEM VALUE VALUES (85, 'Moletom Demo Store – Preto Clássico', 'O Moletom Demo Store Preto é a escolha ideal para quem busca estilo urbano, conforto e versatilidade no dia a dia. Produzido em tecido encorpado e macio, oferece excelente caimento e proteção térmica, sendo perfeito para dias frios ou meia-estação.

Com design moderno e minimalista, o logotipo Demo Store estampado no peito adiciona personalidade e identidade à peça. Possui capuz ajustável com cordão, bolso canguru funcional e acabamento reforçado nos punhos e barra, garantindo durabilidade e conforto prolongado.

Ideal para compor looks casuais, streetwear ou urbanos, seja para sair com amigos ou para o uso diário.', 179.90, 38, 39, '["https://res.cloudinary.com/dnfnevy9e/image/upload/v1766606663/product_images/Moletom_Demo_Store__Preto_Classico/ChatGPT_Image_24_de_dez._de_2025_16_56_51_20251224200421242675.jpg", "https://res.cloudinary.com/dnfnevy9e/image/upload/v1766606665/product_images/Moletom_Demo_Store__Preto_Classico/ChatGPT_Image_24_de_dez._de_2025_16_56_57_20251224200423173407.jpg"]', 10, 56, 70, 0.82, 70, '9d509dc8-9f53-4be5-985a-7105090a1a23', 'https://res.cloudinary.com/dnfnevy9e/image/upload/v1766606660/product_images/Moletom_Demo_Store__Preto_Classico/ChatGPT_Image_24_de_dez._de_2025_16_58_57_20251224200415465969.jpg');


--
-- TOC entry 5215 (class 0 OID 148141)
-- Dependencies: 264
-- Data for Name: profiles; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.profiles VALUES (NULL, 'Christoffer Pádua ', 'Christoffer Pádua ', '2005-07-21', '', '', '', 2, NULL, '2025-10-22 00:55:10.962938', '2025-10-22 21:15:43.645438');
INSERT INTO public.profiles VALUES ('e77f01ac-251c-4a28-9a23-e55fba2afc13', 'client', 'rafael ', '2025-10-24', 'https://res.cloudinary.com/dnfnevy9e/image/upload/v1761321842/user_avatars/fwc41kn2hlpy9z8oebep.jpg', '(12) 34567-8909', '(12) 34567-8909', 13, NULL, '2025-10-24 16:03:39.35522', '2025-10-24 13:03:58.352528');
INSERT INTO public.profiles VALUES ('9d509dc8-9f53-4be5-985a-7105090a1a23', 'Teste', 'Teste', '2000-01-01', '', '(00) 00000-0000', '(00) 00000-0000', 17, NULL, '2025-11-25 00:57:39.960006', '2025-12-22 23:24:11.552051');


--
-- TOC entry 5217 (class 0 OID 148149)
-- Dependencies: 266
-- Data for Name: seo; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5218 (class 0 OID 148154)
-- Dependencies: 267
-- Data for Name: stock; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.stock OVERRIDING SYSTEM VALUE VALUES (88, 82, '9d509dc8-9f53-4be5-985a-7105090a1a23', 31, 'Camiseta Oversize Roxa', 69.9, 50, 'null', '2025-12-24 14:38:34.523585', '2025-12-24 14:38:34.523589');
INSERT INTO public.stock OVERRIDING SYSTEM VALUE VALUES (89, 83, '9d509dc8-9f53-4be5-985a-7105090a1a23', 33, 'Caneca Personalizada', 34.9, 100, '{"sizes": [], "colors": [{"value": "#FCF8F8", "quantity": 1}]}', '2025-12-24 15:29:30.081185', '2025-12-24 15:40:25.147367');
INSERT INTO public.stock OVERRIDING SYSTEM VALUE VALUES (90, 84, '9d509dc8-9f53-4be5-985a-7105090a1a23', 35, 'Boné Casual', 59.9, 10, 'null', '2025-12-24 19:33:49.904745', '2025-12-24 19:33:49.904749');
INSERT INTO public.stock OVERRIDING SYSTEM VALUE VALUES (91, 85, '9d509dc8-9f53-4be5-985a-7105090a1a23', 38, 'Moletom Demo Store – Preto Clássico', 179.9, 10, 'null', '2025-12-24 20:04:24.689692', '2025-12-24 20:04:24.689695');


--
-- TOC entry 5220 (class 0 OID 148160)
-- Dependencies: 269
-- Data for Name: subcategories; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5221 (class 0 OID 148163)
-- Dependencies: 270
-- Data for Name: token_blocklist; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.token_blocklist VALUES (73, '2bbfc174-7867-489a-8f7e-212960a6aef9', '9d509dc8-9f53-4be5-985a-7105090a1a23', '2025-12-23 02:37:53.173583');
INSERT INTO public.token_blocklist VALUES (74, '822ca522-1f0b-486e-bee2-64ec3b41e8c1', 'e77f01ac-251c-4a28-9a23-e55fba2afc13', '2025-12-24 21:39:12.660195');


--
-- TOC entry 5223 (class 0 OID 148167)
-- Dependencies: 272
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users VALUES ('rafael.f.p.faria@hotmail.com', '$2b$12$djZz.PBWYIXVn2IoVNdiGOmP0j0tBJ25.R6L9hoVXCguwB3goWlI.', 'Rafael Pádua', '1991-06-05', 'admin', NULL, '2025-11-22 23:50:35.74066', '2025-11-22 23:50:35.74066', '9d509dc8-9f53-4be5-985a-7105090a1a23');
INSERT INTO public.users VALUES ('paduachristoffer@gmail.com', '$2b$12$WzkuF4w1h3isv7KZ/XVjX.LD4N5DCnfHr9NCZKVePviSv1WFH2tX2', 'Christoffer Pádua ', '2005-07-21', 'admin', NULL, '2025-11-22 23:50:35.74066', '2025-11-22 23:50:35.74066', '2270f1e3-99e8-42c0-a0d7-930e750c8749');
INSERT INTO public.users VALUES ('teste@email.com', '$2b$12$sPuz7cwRfiNo6AAo1tsLvuzTIDryS44UZQbagkk.NwUY7g6uwzpQu', 'Teste', '2000-01-01', 'admin', NULL, '2025-11-25 00:57:39.956587', '2025-11-25 00:57:39.95659', '97832ada-019c-42e3-b1e7-4b7f3c09a35c');


--
-- TOC entry 5225 (class 0 OID 148177)
-- Dependencies: 274
-- Data for Name: variations; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 5251 (class 0 OID 0)
-- Dependencies: 219
-- Name: addresses_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.addresses_id_seq', 48, true);


--
-- TOC entry 5252 (class 0 OID 0)
-- Dependencies: 221
-- Name: blog_posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.blog_posts_id_seq', 23, true);


--
-- TOC entry 5253 (class 0 OID 0)
-- Dependencies: 223
-- Name: cart_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.cart_items_id_seq', 131, true);


--
-- TOC entry 5254 (class 0 OID 0)
-- Dependencies: 225
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.carts_id_seq', 6, true);


--
-- TOC entry 5255 (class 0 OID 0)
-- Dependencies: 277
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_id_seq', 39, true);


--
-- TOC entry 5256 (class 0 OID 0)
-- Dependencies: 228
-- Name: comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.comments_id_seq', 31, true);


--
-- TOC entry 5257 (class 0 OID 0)
-- Dependencies: 230
-- Name: coupons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coupons_id_seq', 28, true);


--
-- TOC entry 5258 (class 0 OID 0)
-- Dependencies: 232
-- Name: coupons_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.coupons_user_id_seq', 13, true);


--
-- TOC entry 5259 (class 0 OID 0)
-- Dependencies: 233
-- Name: delivery_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.delivery_id_seq', 124, true);


--
-- TOC entry 5260 (class 0 OID 0)
-- Dependencies: 235
-- Name: notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.notifications_id_seq', 65, true);


--
-- TOC entry 5261 (class 0 OID 0)
-- Dependencies: 237
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.order_items_id_seq', 195, true);


--
-- TOC entry 5262 (class 0 OID 0)
-- Dependencies: 240
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.orders_id_seq', 245, true);


--
-- TOC entry 5263 (class 0 OID 0)
-- Dependencies: 242
-- Name: pages_new_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.pages_new_id_seq', 5, true);


--
-- TOC entry 5264 (class 0 OID 0)
-- Dependencies: 244
-- Name: payment_products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payment_products_id_seq', 3, true);


--
-- TOC entry 5265 (class 0 OID 0)
-- Dependencies: 246
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payments_id_seq', 176, true);


--
-- TOC entry 5266 (class 0 OID 0)
-- Dependencies: 247
-- Name: payments_product_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.payments_product_id_seq', 308, true);


--
-- TOC entry 5267 (class 0 OID 0)
-- Dependencies: 250
-- Name: post_comments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.post_comments_id_seq', 7, true);


--
-- TOC entry 5268 (class 0 OID 0)
-- Dependencies: 252
-- Name: post_seo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.post_seo_id_seq', 4, true);


--
-- TOC entry 5269 (class 0 OID 0)
-- Dependencies: 254
-- Name: post_views_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.post_views_id_seq', 15, true);


--
-- TOC entry 5270 (class 0 OID 0)
-- Dependencies: 256
-- Name: product_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_images_id_seq', 33, true);


--
-- TOC entry 5271 (class 0 OID 0)
-- Dependencies: 258
-- Name: product_seo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_seo_id_seq', 70, true);


--
-- TOC entry 5272 (class 0 OID 0)
-- Dependencies: 260
-- Name: product_variations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.product_variations_id_seq', 96, true);


--
-- TOC entry 5273 (class 0 OID 0)
-- Dependencies: 263
-- Name: products_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.products_id_seq', 86, true);


--
-- TOC entry 5274 (class 0 OID 0)
-- Dependencies: 265
-- Name: profiles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.profiles_id_seq', 17, true);


--
-- TOC entry 5275 (class 0 OID 0)
-- Dependencies: 268
-- Name: stock_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.stock_id_seq', 92, true);


--
-- TOC entry 5276 (class 0 OID 0)
-- Dependencies: 271
-- Name: token_blocklist_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.token_blocklist_id_seq', 74, true);


--
-- TOC entry 5277 (class 0 OID 0)
-- Dependencies: 273
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 3, true);


--
-- TOC entry 5278 (class 0 OID 0)
-- Dependencies: 275
-- Name: variations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.variations_id_seq', 1, false);


--
-- TOC entry 4962 (class 2606 OID 148195)
-- Name: addresses addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_pkey PRIMARY KEY (id);


--
-- TOC entry 4964 (class 2606 OID 148197)
-- Name: blog_posts blog_posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts
    ADD CONSTRAINT blog_posts_pkey PRIMARY KEY (id);


--
-- TOC entry 4966 (class 2606 OID 148199)
-- Name: blog_posts blog_posts_slug_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts
    ADD CONSTRAINT blog_posts_slug_key UNIQUE (slug);


--
-- TOC entry 4968 (class 2606 OID 148201)
-- Name: cart_items cart_items_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_pkey PRIMARY KEY (id);


--
-- TOC entry 4970 (class 2606 OID 148203)
-- Name: carts carts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.carts
    ADD CONSTRAINT carts_pkey PRIMARY KEY (id);


--
-- TOC entry 5011 (class 2606 OID 148338)
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- TOC entry 4972 (class 2606 OID 148205)
-- Name: client_users client_users_email_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_users
    ADD CONSTRAINT client_users_email_key UNIQUE (email);


--
-- TOC entry 4974 (class 2606 OID 148207)
-- Name: client_users client_users_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.client_users
    ADD CONSTRAINT client_users_pk PRIMARY KEY (id);


--
-- TOC entry 4976 (class 2606 OID 148209)
-- Name: pages pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- TOC entry 4978 (class 2606 OID 148211)
-- Name: payments_product payments_product_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.payments_product
    ADD CONSTRAINT payments_product_pkey PRIMARY KEY (id);


--
-- TOC entry 4980 (class 2606 OID 148213)
-- Name: post_comments post_comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_comments
    ADD CONSTRAINT post_comments_pkey PRIMARY KEY (id);


--
-- TOC entry 4982 (class 2606 OID 148215)
-- Name: post_seo post_seo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_seo
    ADD CONSTRAINT post_seo_pkey PRIMARY KEY (id);


--
-- TOC entry 4984 (class 2606 OID 148217)
-- Name: post_seo post_seo_post_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_seo
    ADD CONSTRAINT post_seo_post_id_key UNIQUE (post_id);


--
-- TOC entry 4986 (class 2606 OID 148219)
-- Name: post_views post_views_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_views
    ADD CONSTRAINT post_views_pkey PRIMARY KEY (id);


--
-- TOC entry 4988 (class 2606 OID 148221)
-- Name: product_seo product_seo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_seo
    ADD CONSTRAINT product_seo_pkey PRIMARY KEY (id);


--
-- TOC entry 4991 (class 2606 OID 148223)
-- Name: product_variations product_variations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.product_variations
    ADD CONSTRAINT product_variations_pkey PRIMARY KEY (id);


--
-- TOC entry 4993 (class 2606 OID 148225)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 4995 (class 2606 OID 148227)
-- Name: profiles profiles_client_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_client_user_id_key UNIQUE (client_user_id);


--
-- TOC entry 4997 (class 2606 OID 148229)
-- Name: profiles profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 5001 (class 2606 OID 148231)
-- Name: stock stock_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.stock
    ADD CONSTRAINT stock_pkey PRIMARY KEY (id);


--
-- TOC entry 5005 (class 2606 OID 148233)
-- Name: token_blocklist token_blocklist_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.token_blocklist
    ADD CONSTRAINT token_blocklist_pkey PRIMARY KEY (id);


--
-- TOC entry 4999 (class 2606 OID 148235)
-- Name: profiles unique_user_id; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.profiles
    ADD CONSTRAINT unique_user_id UNIQUE (user_id);


--
-- TOC entry 5007 (class 2606 OID 148237)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 5009 (class 2606 OID 148239)
-- Name: variations variations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variations
    ADD CONSTRAINT variations_pkey PRIMARY KEY (id);


--
-- TOC entry 4989 (class 1259 OID 148240)
-- Name: ix_product_variations_product_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_product_variations_product_id ON public.product_variations USING btree (product_id);


--
-- TOC entry 5002 (class 1259 OID 148241)
-- Name: ix_token_blocklist_jti; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_token_blocklist_jti ON public.token_blocklist USING btree (jti);


--
-- TOC entry 5003 (class 1259 OID 148242)
-- Name: ix_token_blocklist_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX ix_token_blocklist_user_id ON public.token_blocklist USING btree (user_id);


--
-- TOC entry 5023 (class 2620 OID 148243)
-- Name: profiles trigger_update_profiles_updated_at; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER trigger_update_profiles_updated_at BEFORE UPDATE ON public.profiles FOR EACH ROW EXECUTE FUNCTION public.update_updated_at_column();


--
-- TOC entry 5012 (class 2606 OID 148244)
-- Name: addresses addresses_client_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_client_user_id_fkey FOREIGN KEY (client_user_id) REFERENCES public.client_users(id);


--
-- TOC entry 5013 (class 2606 OID 148249)
-- Name: addresses addresses_profile_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.addresses
    ADD CONSTRAINT addresses_profile_id_fkey FOREIGN KEY (profile_id) REFERENCES public.profiles(user_id) ON DELETE CASCADE;


--
-- TOC entry 5014 (class 2606 OID 148254)
-- Name: blog_posts blog_posts_page_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.blog_posts
    ADD CONSTRAINT blog_posts_page_id_fkey FOREIGN KEY (page_id) REFERENCES public.pages(id);


--
-- TOC entry 5015 (class 2606 OID 148259)
-- Name: cart_items cart_items_cart_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_cart_id_fkey FOREIGN KEY (cart_id) REFERENCES public.carts(id);


--
-- TOC entry 5016 (class 2606 OID 148264)
-- Name: cart_items cart_items_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT cart_items_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- TOC entry 5022 (class 2606 OID 148328)
-- Name: categories categories_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- TOC entry 5017 (class 2606 OID 148269)
-- Name: cart_items fk_cart_items_user; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cart_items
    ADD CONSTRAINT fk_cart_items_user FOREIGN KEY (user_id) REFERENCES public.client_users(id);


--
-- TOC entry 5018 (class 2606 OID 148274)
-- Name: post_comments post_comments_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_comments
    ADD CONSTRAINT post_comments_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.blog_posts(id);


--
-- TOC entry 5019 (class 2606 OID 148279)
-- Name: post_seo post_seo_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_seo
    ADD CONSTRAINT post_seo_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.blog_posts(id);


--
-- TOC entry 5020 (class 2606 OID 148284)
-- Name: post_views post_views_post_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_views
    ADD CONSTRAINT post_views_post_id_fkey FOREIGN KEY (post_id) REFERENCES public.blog_posts(id);


--
-- TOC entry 5021 (class 2606 OID 148289)
-- Name: variations variations_product_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.variations
    ADD CONSTRAINT variations_product_id_fkey FOREIGN KEY (product_id) REFERENCES public.products(id);


--
-- TOC entry 5236 (class 0 OID 0)
-- Dependencies: 6
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: -
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


-- Completed on 2025-12-25 13:18:45

--
-- PostgreSQL database dump complete
--

\unrestrict r4hjhwPNGF9g2r1nN6qBueyNrRwJ7efIAWolGkdzJPKJbYARyQ6DccssCq8G1WS

