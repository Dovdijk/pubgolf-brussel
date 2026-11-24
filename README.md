# Pubgolf Brussel · Kersteditie

Pubgolf-website voor een weekend rond de Grote Markt in Brussel: 133 bars binnen 1 km, elk met een eigen drankje en punten, live race met elfjes, zijmissies (stelen, blokkeren), kotsmelding en een spelleiderpaneel.

## Live zetten

1. **GitHub Pages:** Settings → Pages → Deploy from a branch → `main` / `(root)` → Save.
   De site komt op `https://dovdijk.github.io/pubgolf-brussel/`.
2. **Supabase (voor live delen tussen telefoons):**
   - Maak een project aan op supabase.com.
   - Plak `setup.sql` in de SQL Editor en klik op Run.
   - Vul bovenaan `index.html` `SUPABASE_URL` en `SUPABASE_ANON_KEY` in (Project Settings → API) en verander `ADMIN_PIN`.

Zonder Supabase draait de site in demo-modus met voorbeeldteams; alles blijft dan op één toestel.

## Spelleider

Tik op ⚙ en voer de pincode in. Daar start je het spel, pas je de tijd aan, beheer je teams, bars, missies en foto's.

Kaartgegevens © OpenStreetMap-bijdragers.
