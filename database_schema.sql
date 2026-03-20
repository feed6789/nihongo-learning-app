-- WARNING: This schema is for context only and is not meant to be run.
-- Table order and constraints may not be valid for execution.

CREATE TABLE public.categories (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  level_id bigint NOT NULL,
  title text,
  order_index integer,
  type text,
  CONSTRAINT categories_pkey PRIMARY KEY (id),
  CONSTRAINT categories_level_id_fkey FOREIGN KEY (level_id) REFERENCES public.levels(id)
);
CREATE TABLE public.grammar (
  id uuid NOT NULL DEFAULT gen_random_uuid(),
  category_id bigint NOT NULL,
  title text,
  structure text,
  explanation_vn text,
  explanation_en text,
  CONSTRAINT grammar_pkey PRIMARY KEY (id),
  CONSTRAINT grammar_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id)
);
CREATE TABLE public.kanji (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  character text NOT NULL,
  onyomi text,
  kunyomi text,
  han_viet text,
  meaning_vn text,
  meaning_en text,
  stroke_count integer,
  level_id bigint,
  CONSTRAINT kanji_pkey PRIMARY KEY (id)
);
CREATE TABLE public.levels (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  name text NOT NULL,
  description text,
  CONSTRAINT levels_pkey PRIMARY KEY (id)
);
CREATE TABLE public.profiles (
  id uuid NOT NULL,
  display_name text,
  role text DEFAULT 'learner'::text,
  created_at timestamp without time zone DEFAULT now(),
  CONSTRAINT profiles_pkey PRIMARY KEY (id),
  CONSTRAINT profiles_id_fkey FOREIGN KEY (id) REFERENCES auth.users(id)
);
CREATE TABLE public.user_vocabulary_progress (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  user_id uuid,
  vocabulary_id bigint,
  learned boolean DEFAULT false,
  favorite boolean DEFAULT false,
  last_reviewed timestamp without time zone,
  CONSTRAINT user_vocabulary_progress_pkey PRIMARY KEY (id),
  CONSTRAINT user_vocabulary_progress_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.profiles(id),
  CONSTRAINT user_vocabulary_progress_vocabulary_id_fkey FOREIGN KEY (vocabulary_id) REFERENCES public.vocabulary(id)
);
CREATE TABLE public.vocabulary (
  id bigint GENERATED ALWAYS AS IDENTITY NOT NULL,
  category_id bigint NOT NULL,
  kanji text,
  hiragana text,
  romaji text,
  word_type text,
  meaning_vn text,
  meaning_en text,
  example_jp text,
  example_vn text,
  example_en text,
  audio_url text,
  created_at timestamp with time zone DEFAULT (now() AT TIME ZONE 'utc'::text),
  is_favorite boolean,
  is_learned boolean,
  srs_level integer DEFAULT 0,
  last_review_at timestamp with time zone,
  next_review_at timestamp with time zone,
  CONSTRAINT vocabulary_pkey PRIMARY KEY (id),
  CONSTRAINT vocabulary_category_id_fkey FOREIGN KEY (category_id) REFERENCES public.categories(id)
);