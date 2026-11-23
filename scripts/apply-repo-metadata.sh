#!/usr/bin/env bash
# Applies everything that is a repository *setting* rather than a file:
# visibility, description and topics. The session that wrote the READMEs
# could not do this — its proxy refuses settings writes — so this runs once,
# from your own machine.
#
#   gh auth status                            # must be signed in to github.com
#   bash scripts/apply-repo-metadata.sh
#
# Needs only bash, git and the GitHub CLI. Safe to re-run: every call
# overwrites with the same values. Nothing is deleted.

set -uo pipefail
OWNER=LouisNeubauer
ok=0; fail=0

if ! gh auth status >/dev/null 2>&1; then
  echo "Not signed in to GitHub. Run:  gh auth login" >&2
  exit 1
fi

make_public() {
  local repo="$1"
  local current
  current=$(gh api "repos/$OWNER/$repo" --jq '.visibility' 2>/dev/null) || {
    printf '  ❌ %-24s cannot read repository\n' "$repo"; fail=$((fail+1)); return
  }
  if [ "$current" = "public" ]; then
    printf '  ✓  %-24s already public\n' "$repo"; return
  fi
  if gh api -X PATCH "repos/$OWNER/$repo" -f visibility=public --silent 2>/dev/null; then
    printf '  ✅ %-24s now public\n' "$repo"; ok=$((ok+1))
  else
    printf '  ❌ %-24s could not change visibility\n' "$repo"; fail=$((fail+1))
  fi
}

set_meta() {
  local repo="$1" desc="$2" topics="$3"
  if ! gh api -X PATCH "repos/$OWNER/$repo" -f description="$desc" --silent 2>/dev/null; then
    printf '  ❌ %-38s description failed\n' "$repo"; fail=$((fail+1)); return
  fi
  # Topics without jq: one -f per name.
  local args=() t
  IFS=',' read -ra parts <<< "$topics"
  for t in "${parts[@]}"; do args+=(-f "names[]=$t"); done
  gh api -X PUT "repos/$OWNER/$repo/topics" "${args[@]}" --silent 2>/dev/null \
    && printf '  ✅ %-38s description + %d topics\n' "$repo" "${#parts[@]}" \
    || printf '  ⚠️  %-38s description set, topics failed\n' "$repo"
  ok=$((ok+1))
}

echo "① Making the Le Wagon final project public…"
make_public The_card
make_public Le_Card

echo
echo "② Applying descriptions and topics…"
set_meta The-AI-Edge---Restaurant-Inspection $'MIT 15.071 "The AI Edge" \342\200\224 ranking Boston\'s 6,000 yearly restaurant inspections by risk of failing. Full analysis in nh13120/boston-restaurant-inspection-risk.' machine-learning\,lightgbm\,python\,mit\,data-science\,public-policy
set_meta The_card $'Le Wagon final project (2021) \342\200\224 a Ruby on Rails restaurant ordering app: accounts, menus, orders and QR-code table ordering.' ruby-on-rails\,ruby\,devise\,postgresql\,bootcamp-project\,le-wagon
set_meta Le_Card $'Le Wagon (2021) \342\200\224 the first pass at the restaurant ordering domain model in Ruby on Rails.' ruby-on-rails\,ruby\,devise\,bootcamp-project\,le-wagon
set_meta R_a_R $'Le Wagon (2021) \342\200\224 Rails application scaffold from the final project sprint.' ruby-on-rails\,ruby\,bootcamp-project\,le-wagon
set_meta rails-watch-list $'Le Wagon (2021) \342\200\224 many-to-many modelling in Rails: lists, movies and the bookmarks between them.' ruby-on-rails\,ruby\,activerecord\,postgresql\,bootcamp-project\,le-wagon
set_meta rails-yelp-mvp $'Le Wagon (2021) \342\200\224 Rails MVP scaffold: database setup and model generation.' ruby-on-rails\,ruby\,activerecord\,bootcamp-project\,le-wagon
set_meta rails-wikinimous $'Le Wagon (2021) \342\200\224 full CRUD in Rails, written out one route at a time.' ruby-on-rails\,ruby\,crud\,rest\,bootcamp-project\,le-wagon
set_meta rails-task-manager $'Le Wagon (2021) \342\200\224 the seven RESTful actions in Rails, written by hand.' ruby-on-rails\,ruby\,rest\,crud\,bootcamp-project\,le-wagon
set_meta rails-longest-word-game $'Le Wagon (2021) \342\200\224 sessions, form round-trips and an external API in Rails.' ruby-on-rails\,ruby\,sessions\,api\,bootcamp-project\,le-wagon
set_meta rails-stupid-coaching $'Le Wagon (2021) \342\200\224 a first Rails controller: request in, response out, nothing hidden.' ruby-on-rails\,ruby\,mvc\,bootcamp-project\,le-wagon
set_meta Sailing-School $'Le Wagon (2021) \342\200\224 a landing page built from components in hand-written HTML and CSS.' html\,css\,landing-page\,frontend\,bootcamp-project\,le-wagon
set_meta first-website $'Le Wagon (2021) \342\200\224 where it started: a personal profile page in raw HTML and CSS.' html\,css\,frontend\,bootcamp-project\,le-wagon
set_meta study-archive A\ semester\ of\ course\ material\ ingested\ and\ indexed\,\ answerable\ by\ a\ tutor\ that\ cites\ the\ exact\ slide. nextjs\,typescript\,prisma\,neon\,rag\,claude\,education
set_meta tutor-bym-1 $'Private Tutor V1 \342\200\224 teaches every topic from zero and traces each fact back to the slide it came from.' education\,edtech\,vercel\,neon\,javascript\,llm
set_meta the-worlds-journal-v1 A\ publishing\ platform\ where\ everyone\ has\ their\ own\ journal:\ long-form\ writing\ and\ photography. publishing\,javascript\,vercel\,neon\,postgresql
set_meta ai-power-res $'Master\'s thesis workspace \342\200\224 AI-driven electricity demand and the allocation of capital (MIT Sloan).' research\,energy\,economics\,mit\,reproducible-research
set_meta way2excellence-v2 $'Way2Excellence V2 \342\200\224 a study tutor rebuilt from scratch, with every design decision settled against sourced evidence.' edtech\,learning-science\,research\,product-design
set_meta BuildYourMind Turn\ a\ real\ idea\ into\ a\ product\ you\ keep\ running:\ a\ production\ template\ with\ guardrails\ CI\ enforces. template\,vercel\,neon\,nodejs\,github-actions\,developer-tools
set_meta hackathon-template Idea\ to\ a\ live\,\ deployed\ app\ in\ 15-20\ minutes:\ the\ deadline-tuned\ sibling\ of\ BuildYourMind. template\,hackathon\,vercel\,neon\,nodejs
set_meta reading-list An\ unstarted\ project\ scaffold\ from\ the\ BuildYourMind\ template. template\,scaffold
set_meta test-idea A\ scratch\ project\ used\ to\ exercise\ the\ BuildYourMind\ template\ end\ to\ end. template\,scaffold
set_meta draft1 $'Retired \342\200\224 the Study Tutor built here now lives in study-archive.' archived-project\,retired

echo
echo "③ Linking the now-public repositories from the profile README…"

# Only link what is actually public *right now* — re-read it from GitHub
# rather than trusting that step ① succeeded. A link to a private repository
# 404s for exactly the people this page is written for.
for repo in The_card Le_Card; do
  vis=$(gh api "repos/$OWNER/$repo" --jq '.visibility' 2>/dev/null)
  if [ "$vis" != "public" ]; then
    printf '  –  %s is still %s; leaving the profile links alone.\n' "$repo" "${vis:-unreadable}"
    printf '\n%s updated, %s failed.\n' "$ok" "$fail"
    exit 0
  fi
done

cd "$(dirname "$0")/.."
python3 - <<'RELINK'
import pathlib, subprocess, sys
p = pathlib.Path("README.md")
if not p.exists():
    print("  – README.md not found; run this from inside the profile repository"); sys.exit(0)
s = p.read_text()
subs = [("| **The_card** 🏆 <sub>🔒 private</sub> |",
         "| [**The_card**](https://github.com/LouisNeubauer/The_card) 🏆 |"),
        ("| **Le_Card** <sub>🔒 private</sub> |",
         "| [Le_Card](https://github.com/LouisNeubauer/Le_Card) |")]
changed = False
for old, new in subs:
    if old in s:
        s = s.replace(old, new); changed = True
if not changed:
    print("  –  profile README already links them"); sys.exit(0)
p.write_text(s)
for cmd in (["git","add","README.md"],
            ["git","commit","-m","Link The_card and Le_Card now that they are public"],
            ["git","push"]):
    if subprocess.run(cmd).returncode != 0:
        print("  ⚠️  README updated locally, but the push did not complete — commit it yourself."); sys.exit(0)
print("  ✅ profile README updated and pushed")
RELINK

printf '\n%s updated, %s failed.\n' "$ok" "$fail"
