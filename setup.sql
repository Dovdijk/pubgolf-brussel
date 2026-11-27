-- Pubgolf Brussel: eenmalig plakken in Supabase > SQL Editor > Run

create table if not exists teams (
  id uuid primary key,
  name text not null,
  color text,
  players int default 3,
  bonus int default 0,
  created_at timestamptz default now()
);
create table if not exists bars (
  id text primary key,
  name text not null,
  drink text,
  points int default 10,
  lat double precision,
  lng double precision,
  note text,
  src text,
  cat text,
  hours jsonb,
  dist int,
  sort int default 0
);
create table if not exists missions (
  id text primary key,
  title text not null,
  points int default 10,
  repeatable boolean default false,
  type text default 'normaal',
  steal int default 0,
  task text,
  sort int default 0
);
create table if not exists submissions (
  id uuid primary key,
  team_id uuid references teams(id) on delete cascade,
  kind text,
  ref_id text,
  title text,
  points int,
  photo_url text,
  status text default 'ok',
  target_team_id uuid,
  steal int default 0,
  block_task text,
  created_at timestamptz default now()
);

create table if not exists settings (
  id text primary key,
  value jsonb
);

-- Eén team per bar: de database weigert een tweede geldige claim op dezelfde bar
create unique index if not exists one_claim_per_bar
  on submissions (ref_id) where kind = 'bar' and status <> 'rejected';

-- Open toegang voor iedereen met de link (vriendenspel, geen accounts)
alter table teams enable row level security;
alter table bars enable row level security;
alter table missions enable row level security;
alter table submissions enable row level security;
create policy "open teams" on teams for all using (true) with check (true);
create policy "open bars" on bars for all using (true) with check (true);
create policy "open missions" on missions for all using (true) with check (true);
create policy "open submissions" on submissions for all using (true) with check (true);
alter table settings enable row level security;
create policy "open settings" on settings for all using (true) with check (true);

-- Toegang voor de website (anon) tot de tabellen
grant usage on schema public to anon, authenticated;
grant select, insert, update, delete on teams, bars, missions, submissions, settings to anon, authenticated;

-- Live updates
alter publication supabase_realtime add table teams, bars, missions, submissions, settings;

-- Fotobucket
insert into storage.buckets (id, name, public) values ('photos', 'photos', true)
  on conflict (id) do nothing;
create policy "photos lezen" on storage.objects for select using (bucket_id = 'photos');
create policy "photos uploaden" on storage.objects for insert with check (bucket_id = 'photos');
