#!/usr/bin/env bash
# Sets the description and topics on every repository.
#
# These are repository *settings*, not files, so they could not be applied
# from the session that wrote the READMEs — that proxy refuses settings
# writes. Run this once, locally, with the GitHub CLI signed in:
#
#     gh auth status          # must show github.com, with repo scope
#     bash scripts/apply-repo-metadata.sh
#
# It is safe to re-run: every call simply overwrites with the same values.

set -uo pipefail
OWNER=LouisNeubauer
ok=0; fail=0

set_meta() {
  local repo="$1" desc="$2" topics="$3"
  if gh api -X PATCH "repos/$OWNER/$repo" -f description="$desc" --silent 2>/dev/null; then
    jq -nc --arg t "$topics" '{names: ($t | split(","))}' \
      | gh api -X PUT "repos/$OWNER/$repo/topics" --input - --silent 2>/dev/null
    printf '  ✅ %s\n' "$repo"; ok=$((ok+1))
  else
    printf '  ❌ %s — could not update (check access)\n' "$repo"; fail=$((fail+1))
  fi
}

echo "Applying descriptions and topics…"
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

printf '\n%s updated, %s failed.\n' "$ok" "$fail"
