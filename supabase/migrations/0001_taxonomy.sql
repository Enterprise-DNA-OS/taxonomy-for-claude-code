create table schemes (
 id uuid primary key default gen_random_uuid(), code text not null unique check(btrim(code)<>''), name text not null check(btrim(name)<>''), uri text not null unique,
 owner text not null check(btrim(owner)<>''), languages text[] not null default array['en'] check(cardinality(languages)>0),
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table concepts (
 id uuid primary key default gen_random_uuid(), scheme_id uuid not null references schemes(id), uri text not null unique, code text not null unique,
 definition text not null default '', owner text not null default '', status text not null default 'draft' check(status in ('draft','approved','retired')),
 review_due date, approved_by text, approved_at timestamptz, replacement_id uuid references concepts(id),
 created_at timestamptz not null default now(), updated_at timestamptz not null default now(), check(replacement_id is distinct from id)
);
create table labels (
 id uuid primary key default gen_random_uuid(), concept_id uuid not null references concepts(id), kind text not null check(kind in ('pref','alt','hidden')),
 lang text not null check(lang=lower(lang)), value text not null check(btrim(value)<>''),
 created_at timestamptz not null default now(), updated_at timestamptz not null default now(), unique(concept_id,lang,value)
);
create unique index one_pref_per_language on labels(concept_id,lang) where kind='pref';
create table relations (
 id uuid primary key default gen_random_uuid(), subject_id uuid not null references concepts(id), kind text not null check(kind in ('broader','related')),
 object_id uuid not null references concepts(id), created_at timestamptz not null default now(), updated_at timestamptz not null default now(),
 unique(subject_id,kind,object_id), check(subject_id<>object_id)
);
create table requests (
 id uuid primary key default gen_random_uuid(), concept_id uuid not null references concepts(id), title text not null check(btrim(title)<>''), owner text not null check(btrim(owner)<>''),
 due date not null, status text not null default 'open' check(status in ('open','accepted','rejected')), decision_note text, decided_by text,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table events (
 id uuid primary key default gen_random_uuid(), scheme_id uuid not null references schemes(id), concept_id uuid references concepts(id), actor text not null,
 action text not null, detail jsonb not null, created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create table imports (
 id uuid primary key default gen_random_uuid(), scheme_id uuid not null references schemes(id), source text not null, digest text not null, raw jsonb not null, summary jsonb not null,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now(), unique(scheme_id,source,digest)
);
create table releases (
 id uuid primary key default gen_random_uuid(), scheme_id uuid not null references schemes(id), version text not null, actor text not null, note text not null, snapshot jsonb not null,
 created_at timestamptz not null default now(), updated_at timestamptz not null default now(), unique(scheme_id,version)
);
create function touch_updated_at() returns trigger language plpgsql as $$ begin new.updated_at=now(); return new; end $$;
do $$ declare t text; begin foreach t in array array['schemes','concepts','labels','relations','requests','events','imports','releases'] loop
 execute format('create trigger touch before update on %I for each row execute function touch_updated_at()',t);
 execute format('alter table %I enable row level security',t); execute format('revoke all on %I from public',t);
end loop; end $$;
create view concept_register as
 select c.id,c.scheme_id,s.code scheme,c.code,c.uri,coalesce((select value from labels where concept_id=c.id and kind='pref' order by lang limit 1),c.code) name,
 c.definition,c.owner,c.status,c.review_due,c.updated_at from concepts c join schemes s on s.id=c.scheme_id;
create view broader_paths as
 with recursive paths as (
 select subject_id child,object_id ancestor,array[subject_id,object_id] trail from relations where kind='broader'
 union all select p.child,r.object_id,p.trail||r.object_id from paths p join relations r on r.subject_id=p.ancestor and r.kind='broader' where not r.object_id=any(p.trail)
 ) select distinct child,ancestor from paths;
create view review_queue as
 select c.id,c.scheme_id,c.scheme,c.code,c.name,c.owner,c.status,c.review_due,
 (select count(*)::int from requests r where r.concept_id=c.id and r.status='open') open_requests,
 case when c.review_due<current_date then 'overdue review' when c.status='draft' then 'draft needs review' when c.review_due is null then 'no review date' else 'review due soon' end reason
 from concept_register c where c.status<>'retired' and (c.status='draft' or c.review_due is null or c.review_due<=current_date+14);
create view translation_gaps as
 select c.id,c.scheme_id,c.scheme,c.code,c.name,l.lang from concept_register c join schemes s on s.id=c.scheme_id cross join unnest(s.languages) l(lang)
 where c.status<>'retired' and not exists(select 1 from labels x where x.concept_id=c.id and x.kind='pref' and x.lang=l.lang);
create view label_collisions as
 select c.scheme_id,l.lang,lower(l.value) label,count(distinct c.id)::int concepts,string_agg(distinct c.code,', ' order by c.code) codes
 from labels l join concepts c on c.id=l.concept_id where c.status<>'retired' and l.kind<>'hidden'
 group by c.scheme_id,l.lang,lower(l.value) having count(distinct c.id)>1;
create view taxonomy_week as
 select s.id,s.code,s.name,s.owner,
 (select count(*)::int from concepts where scheme_id=s.id and status<>'retired') active_concepts,
 (select count(*)::int from review_queue where scheme_id=s.id) reviews,
 (select count(*)::int from translation_gaps where scheme_id=s.id) missing_translations,
 (select count(*)::int from requests r join concepts c on c.id=r.concept_id where c.scheme_id=s.id and r.status='open' and r.due<current_date) overdue_requests
 from schemes s;
revoke all on concept_register,broader_paths,review_queue,translation_gaps,label_collisions,taxonomy_week from public;
