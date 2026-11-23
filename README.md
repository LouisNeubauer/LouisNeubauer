<p align="center">
  <img src="assets/banner.svg" alt="Louis Neubauer — MIT Sloan MSMS 2027 — I build software that stays live after the demo." width="100%">
</p>

<p align="center">
  <a href="https://louisneubauer.com"><img alt="Website" src="https://img.shields.io/badge/Website-louisneubauer.com-0B1220?style=for-the-badge&logo=safari&logoColor=white"></a>
  <a href="https://www.linkedin.com/in/louis-neubauer/"><img alt="LinkedIn" src="https://img.shields.io/badge/LinkedIn-Connect-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white"></a>
  <img alt="Focus" src="https://img.shields.io/badge/Focus-Finance%20·%20Applied%20AI%20·%20Product-6366F1?style=for-the-badge">
</p>

---

## Hello 👋

I am a **Master of Science in Management Studies candidate at MIT Sloan (2027)**, and I build things that run in production rather than in a slide deck.

I am heading into **finance**, and I come at it from the technical side: I would rather build the model and the tool than wait for someone else to. My work sits where three lines meet — **capital allocation and energy markets**, **machine learning that changes a real decision**, and **products that survive past the demo**. The projects below are the evidence.

```text
Capital decisions  →  models that earn their place  →  software that stays up
```

<br>

## 🚀 Flagship work

<table>
<tr>
<td width="50%" valign="top">

### 🍽️ Boston Inspection Risk Ranking
**MIT 15.071 — The AI Edge · Fall 2026**

Boston's Inspectional Services Department runs ~6,000 routine restaurant inspections a year, and 59 % of them fail. No published rule decides which visit comes first. We built one.

A LightGBM model ranked by failure risk puts **88.1 %** of failures inside the first 20 % of visits — against a 59 % baseline and 80.3 % for the strongest hand-written rule. In practice: **~324 more failed inspections caught per year**, found **1.1 weeks sooner**, with the same inspectors and the same budget.

We also measured the fairness cost and recommended deploying **without location features** — equal accuracy, far more even coverage across Dorchester and Roxbury.

`Python` `LightGBM` `XGBoost` `scikit-learn` `MiniLM / transformers`

**→ [Read the full analysis](https://github.com/nh13120/boston-restaurant-inspection-risk)**
<br><sub>Team: Nicolas Hong · Louis Neubauer · Robin Cen · Jose Plaza Carreras</sub>

</td>
<td width="50%" valign="top">

### ⚡ AI, Electricity Demand & Capital
**Master's Thesis · MIT Sloan**

*AI-Driven Electricity Demand and the Allocation of Capital: Bridge Power vs. Clean Energy Investment.*
Advisor: **Prof. Roberto Rigobon**.

Data centres are rewriting the load curve. The question this thesis asks is where the money goes because of it — into gas as a bridge, or into clean generation — and what actually drives that split.

The research workspace is built like an engineering project, not a folder of drafts: a single source-of-truth state document, a **claims ledger** where every assertion is traced to its source, a decisions log, and specialist research agents for literature, data and review.

`Research engineering` `Energy economics` `Reproducible analysis`

<sub>🔒 Private repository — happy to walk through the methodology.</sub>

</td>
</tr>
</table>

<br>

## 🏗️ How I build

Most side projects die at the demo. I got tired of that, so I built the thing that fixes it: **BuildYourMind**, a production template that turns an idea into a deployed, tested, monitored application — and keeps it that way.

```mermaid
flowchart LR
    A["💡 Idea"] --> B["📋 Kickoff<br/><sub>plan, locked</sub>"]
    B --> C["🔨 Build<br/><sub>generators + recipes</sub>"]
    C --> D{"🛡️ Guardrails"}
    D -->|"fails"| C
    D -->|"passes"| E["🚦 CI<br/><sub>check · test · migrate</sub>"]
    E --> F["🌍 Live on Vercel"]
    F --> G["✅ Post-deploy<br/>verification"]
    G -->|"regression"| H["↩️ Rollback"]
    G -->|"healthy"| I["📈 Keeps running"]

    style A fill:#1E293B,stroke:#38BDF8,color:#F8FAFC
    style D fill:#312E81,stroke:#6366F1,color:#F8FAFC
    style F fill:#065F46,stroke:#10B981,color:#F8FAFC
    style I fill:#065F46,stroke:#10B981,color:#F8FAFC
    style H fill:#7F1D1D,stroke:#EF4444,color:#F8FAFC
```

**The guardrails are not advice — they are enforced**, by local hooks, by `npm run check`, by CI, and again by a live check after every deploy:

| Guardrail | What it prevents |
|---|---|
| 🔐 Strict CSP + Trusted Types | Injected script ever executing |
| 🗝️ Secrets only as 1Password references | A key reaching the repo, the disk or an agent |
| 💉 Parameterised SQL, always | SQL injection |
| 💸 Daily AI budget + kill switch | A runaway loop becoming a runaway bill |
| 🧪 Machine-checked "Done when" | A feature being called finished when it is not |
| ♿ Accessibility + console-clean checks | Shipping something only the author can use |

<sub>Two deliberate variants: **BuildYourMind** for ideas you mean to keep (moves the date rather than cutting the work) and **hackathon-template** for a deadline (cuts scope, ships the demo path). Same stack, opposite instincts.</sub>

<br>

## 🗺️ How the pieces fit together

Not a folder of unrelated side projects. One template, one shared ingestion
layer, and products built on top of both.

```mermaid
flowchart TB
    subgraph FOUND["⚙️ Foundation"]
        BYM["<b>BuildYourMind</b><br/><sub>production template</sub>"]
        HT["<b>hackathon-template</b><br/><sub>deadline variant</sub>"]
    end

    subgraph DATA["🧠 Knowledge layer"]
        SA["<b>Study Archive</b><br/><sub>ingest · embed · index<br/>pgvector + concept graph</sub>"]
    end

    subgraph PROD["🚀 Products"]
        PT["<b>Private Tutor V1</b><br/><sub>live</sub>"]
        W2E["<b>Way2Excellence V2</b><br/><sub>research-led rebuild</sub>"]
        TWJ["<b>The World's Journal</b><br/><sub>publishing platform</sub>"]
    end

    subgraph RES["📊 Research"]
        THESIS["<b>Thesis</b><br/><sub>AI electricity demand<br/>&amp; capital allocation</sub>"]
        AIEDGE["<b>15.071</b><br/><sub>inspection risk ranking</sub>"]
    end

    HT -.->|"forked into"| BYM
    BYM ==> PT
    BYM ==> TWJ
    SA ==>|"course material,<br/>read-only"| PT
    PT -.->|"audited, then rebuilt as"| W2E
    AIEDGE -.->|"methods carried into"| THESIS

    style BYM fill:#312E81,stroke:#6366F1,color:#F8FAFC
    style SA fill:#1E3A8A,stroke:#38BDF8,color:#F8FAFC
    style PT fill:#065F46,stroke:#10B981,color:#F8FAFC
    style TWJ fill:#065F46,stroke:#10B981,color:#F8FAFC
    style THESIS fill:#7C2D12,stroke:#F97316,color:#F8FAFC
    style AIEDGE fill:#7C2D12,stroke:#F97316,color:#F8FAFC
```

<br>

## 📐 Engineering, in numbers

Everything below is my own code — written, tested and deployed, not scaffolded and abandoned.

<table>
<tr>
<td align="center"><h3>~87k</h3><sub>lines of TypeScript,<br>JavaScript and SQL<br>across five live projects</sub></td>
<td align="center"><h3>~190</h3><sub>test files — unit, API,<br>security, accessibility,<br>load and real-browser</sub></td>
<td align="center"><h3>90+</h3><sub>API routes<br>serving production<br>traffic</sub></td>
<td align="center"><h3>30</h3><sub>database models<br>in the archive<br>schema alone</sub></td>
</tr>
</table>

**What those tests actually cover** — because a test count on its own means nothing:

| | |
|---|---|
| 🔒 `security.test.js` | CSP and Trusted Types hold, SQL stays parameterised, no secret reaches the repository |
| ♿ `a11y.test.js` | Every feature is usable by keyboard and by a screen reader — enforced, not aspirational |
| 🌐 `browser.test.js` | Real Chromium via Playwright, against the running application |
| 📈 `api-load.test.js` | Routes under concurrency, with rate limiting proven to engage |
| 💸 `ai.test.js` | The daily AI budget guard and kill switch actually stop a runaway loop |
| 🗄️ `*.db.test.js` | Database behaviour against a real Postgres, not a mock that agrees with me |

## 🧠 Machine learning, specifically

Not "uses AI". Here is what is actually running:

| System | What the neural network does | How it is kept honest |
|---|---|---|
| **Study Archive retrieval** | `voyage-4-large` embeds every chunk into **1024-dimensional vectors**, stored in Postgres via **pgvector** and searched by cosine distance over an **HNSW index**. A second neural model — a **cross-encoder reranker** — re-scores the shortlist by reading query and passage together. | Dense, lexical and concept-graph arms are fused by **Reciprocal Rank Fusion** rather than by adding incomparable scores. Every ranking change is scored against a hand-built golden set. |
| **Study Archive understanding** | LLM passes extract concepts, build the concept graph and tag chunks against it. | Concepts are reviewed; the per-document fallback is explicit, not silent. |
| **Private Tutor** | A large model answers; a **separate, smaller model verifies** the answer against the source material before it is shown. | Teaching material is authored in reviewable sessions, never improvised at request time. |
| **Inspection risk ranking** | Gradient-boosted trees over inspection history; a **fine-tuned MiniLM transformer** over inspector comments as a second model. | Settings frozen before the test years. The transformer gained **one point** — and was **not** shipped, because one point does not justify serving a neural network. |

> **The pattern:** reach for the heavier model only when the measurement says it earns its place — and say so out loud when it does not.

<br>

## 📦 Projects

<table>
<tr><th align="left">Project</th><th align="left">What it is</th><th align="left">Stack</th><th align="left">Status</th></tr>

<tr><td><b>Study Archive</b><br><sub>🔒 private</sub></td>
<td>Every lecture slide, reading, note, problem set and recording from a semester — ingested automatically, embedded into a <b>pgvector</b> index, organised into a concept graph, and answerable by a tutor that <b>cites the exact slide</b>. Three retrieval arms fused by rank, then reranked by a cross-encoder; every change scored against a golden set.</td>
<td><code>Next.js</code> <code>TypeScript</code> <code>Prisma</code> <code>pgvector</code> <code>Neon</code> <code>Claude API</code> <code>WebAuthn</code> <code>MCP</code></td>
<td>🟢 Running</td></tr>

<tr><td><b>Private Tutor (V1)</b><br><sub>🔒 private</sub></td>
<td>A study system that teaches each topic from zero and <b>proves it skipped nothing</b>. Every subject is a tree; every fact carries a chip naming its source ("L7 · slide 12"); anything outside the course is labelled as such. Teaching material is authored in reviewable sessions — not improvised at request time — and quick Q&amp;A is checked by a second model.</td>
<td><code>JavaScript</code> <code>Vercel</code> <code>Neon</code> <code>NVIDIA Nemotron</code> <code>Canvas API</code></td>
<td>🟢 Live</td></tr>

<tr><td><b>Way2Excellence V2</b><br><sub>🔒 private</sub></td>
<td>The ground-up rebuild of that tutor — and a deliberate experiment in <b>deciding from evidence instead of taste</b>. Six research memos (learning science, gamification, product teardowns, stack, licensing, multi-tenancy) settle the design questions before a line of code, each claim carrying a source link and an explicit "unverified" section. V1 stays live so the two can be compared.</td>
<td><code>Research-first</code> <code>Learning science</code></td>
<td>🔵 Planning</td></tr>

<tr><td><b>The World's Journal</b><br><sub>🔒 private</sub></td>
<td>A publishing platform where everyone has their own journal: long-form writing and photography, a quiet editor, and an article page that reads like a well-set magazine. Built on one hard rule — <b>nothing goes public that the writer did not publish</b>.</td>
<td><code>JavaScript</code> <code>Vercel</code> <code>Neon</code> <code>Postgres</code></td>
<td>🟡 Building</td></tr>

<tr><td><b>BuildYourMind</b><br><sub>🔒 private</sub></td>
<td>The production template above: deployed skeleton from minute one, enforced guardrails, feature generators, tested recipes (search, accounts, uploads, cron, domains) and a documented agent workflow.</td>
<td><code>Node 22</code> <code>Vercel</code> <code>Neon</code> <code>Playwright</code> <code>GitHub Actions</code></td>
<td>🟢 Maintained</td></tr>

<tr><td><b>hackathon-template</b><br><sub>🔒 private</sub></td>
<td>Same foundation, tuned for a clock: two questions, a 60-second demo script, and a live app in roughly 15–20 minutes.</td>
<td><code>Node 22</code> <code>Vercel</code> <code>Neon</code></td>
<td>🟢 Maintained</td></tr>

</table>

<br>

## 🎓 Where it started — Le Wagon, 2021

Before any of this, there was a nine-week bootcamp and no autocomplete worth the name.

[Le Wagon](https://www.lewagon.com/) is an intensive full-stack programme — nine weeks, full time, nine in the morning until seven at night with homework on top — running Ruby, object-oriented design, SQL and databases, front-end and Ruby on Rails, before turning you loose on a real project. ([programme](https://www.lewagon.com/web-development-course) · [weekly structure](https://medium.com/le-wagon/9-weeks-teaching-at-lewagon-new-entrepreneur-coding-school-in-paris-d72a3daae7c7))

**I learned to code there the slow way — reading errors, drawing schemas on paper, pairing daily — and that foundation is the reason I can now direct AI tools instead of being directed by them.** You cannot review what you do not understand.

The repositories below are that apprenticeship, left exactly as it happened:

| Repository | The lesson |
|---|---|
| [**The_card**](https://github.com/LouisNeubauer/The_card) 🏆 | **Final project.** A QR-code restaurant ordering app — accounts, menus, live orders, line items. Built by a team of five in 23 days: **266 commits through 121 reviewed pull requests**, of which 75 commits are mine. Branch-and-review from day one, nine weeks into learning to code. |
| [Le_Card](https://github.com/LouisNeubauer/Le_Card) | The first run at that domain model — kept, because the second one was better for having had a first. |
| [rails-watch-list](https://github.com/LouisNeubauer/rails-watch-list) | Many-to-many relationships, modelled properly: lists, movies and the bookmarks between them. |
| [rails-wikinimous](https://github.com/LouisNeubauer/rails-wikinimous) | Full CRUD by hand, one route at a time — before `resources` made it invisible. |
| [rails-task-manager](https://github.com/LouisNeubauer/rails-task-manager) | REST conventions: seven actions, and why they are the seven. |
| [rails-longest-word-game](https://github.com/LouisNeubauer/rails-longest-word-game) | Sessions, form round-trips and talking to an external API. |
| [rails-stupid-coaching](https://github.com/LouisNeubauer/rails-stupid-coaching) | The first controller — request in, response out, nothing hidden. |
| [Sailing-School](https://github.com/LouisNeubauer/Sailing-School) | A landing page built from components, back when every pixel was CSS by hand. |
| [first-website](https://github.com/LouisNeubauer/first-website) | Where it genuinely began: raw HTML and CSS, a profile page, and far too many beers. 🍺 |
| [R_a_R](https://github.com/LouisNeubauer/R_a_R) · [rails-yelp-mvp](https://github.com/LouisNeubauer/rails-yelp-mvp) | Scaffolds from the final sprint, kept honestly as the starting points they are. |

<br>

## 🧰 Toolbox

<p>
<img alt="Python" src="https://img.shields.io/badge/Python-3776AB?style=flat-square&logo=python&logoColor=white">
<img alt="JavaScript" src="https://img.shields.io/badge/JavaScript-F7DF1E?style=flat-square&logo=javascript&logoColor=black">
<img alt="TypeScript" src="https://img.shields.io/badge/TypeScript-3178C6?style=flat-square&logo=typescript&logoColor=white">
<img alt="Ruby" src="https://img.shields.io/badge/Ruby-CC342D?style=flat-square&logo=ruby&logoColor=white">
<img alt="SQL" src="https://img.shields.io/badge/SQL-4479A1?style=flat-square&logo=postgresql&logoColor=white">
</p>
<p>
<img alt="LightGBM" src="https://img.shields.io/badge/LightGBM-02569B?style=flat-square">
<img alt="XGBoost" src="https://img.shields.io/badge/XGBoost-EC4E20?style=flat-square">
<img alt="scikit-learn" src="https://img.shields.io/badge/scikit--learn-F7931E?style=flat-square&logo=scikitlearn&logoColor=white">
<img alt="Transformers" src="https://img.shields.io/badge/Transformers-FFD21E?style=flat-square&logo=huggingface&logoColor=black">
<img alt="Jupyter" src="https://img.shields.io/badge/Jupyter-F37626?style=flat-square&logo=jupyter&logoColor=white">
</p>
<p>
<img alt="Next.js" src="https://img.shields.io/badge/Next.js-000000?style=flat-square&logo=nextdotjs&logoColor=white">
<img alt="Rails" src="https://img.shields.io/badge/Rails-D30001?style=flat-square&logo=rubyonrails&logoColor=white">
<img alt="Node.js" src="https://img.shields.io/badge/Node.js-5FA04E?style=flat-square&logo=nodedotjs&logoColor=white">
<img alt="Postgres" src="https://img.shields.io/badge/PostgreSQL-4169E1?style=flat-square&logo=postgresql&logoColor=white">
<img alt="Prisma" src="https://img.shields.io/badge/Prisma-2D3748?style=flat-square&logo=prisma&logoColor=white">
</p>
<p>
<img alt="Vercel" src="https://img.shields.io/badge/Vercel-000000?style=flat-square&logo=vercel&logoColor=white">
<img alt="Neon" src="https://img.shields.io/badge/Neon-00E599?style=flat-square&logo=neon&logoColor=black">
<img alt="GitHub Actions" src="https://img.shields.io/badge/GitHub%20Actions-2088FF?style=flat-square&logo=githubactions&logoColor=white">
<img alt="Playwright" src="https://img.shields.io/badge/Playwright-2EAD33?style=flat-square&logo=playwright&logoColor=white">
<img alt="Cloudflare R2" src="https://img.shields.io/badge/Cloudflare%20R2-F38020?style=flat-square&logo=cloudflare&logoColor=white">
</p>

<br>

## 📡 Latest work

<!-- LATEST-WORK:START -->

| Repository | What it is | Last update |
|---|---|---|
| **[LouisNeubauer](https://github.com/LouisNeubauer/LouisNeubauer)** | Profile README <sub>`JavaScript`</sub> | today |
| **[The_card](https://github.com/LouisNeubauer/The_card)** | Le Wagon final project (2021) — a Ruby on Rails restaurant ordering app: accounts, menus, orders and QR-code table ordering. <sub>`Ruby`</sub> | today |
| **[R_a_R](https://github.com/LouisNeubauer/R_a_R)** | Le Wagon (2021) — Rails application scaffold from the final project sprint. <sub>`Ruby`</sub> | today |
| **[rails-yelp-mvp](https://github.com/LouisNeubauer/rails-yelp-mvp)** | Le Wagon (2021) — Rails MVP scaffold: database setup and model generation. <sub>`Ruby`</sub> | today |
| **[rails-watch-list](https://github.com/LouisNeubauer/rails-watch-list)** | Le Wagon (2021) — many-to-many modelling in Rails: lists, movies and the bookmarks between them. <sub>`Ruby`</sub> | today |

<details>
<summary><b>Recent public activity</b></summary>

- Pushed 0 commits to [`LouisNeubauer/Sailing-School`](https://github.com/LouisNeubauer/Sailing-School)
- Pushed 0 commits to [`LouisNeubauer/The-AI-Edge---Restaurant-Inspection`](https://github.com/LouisNeubauer/The-AI-Edge---Restaurant-Inspection)

</details>

<sub>Rebuilt automatically — last run 2026-11-23.</sub>

<!-- LATEST-WORK:END -->

<sub>This section rebuilds itself from my public activity — see <a href=".github/workflows/latest-work.yml">the workflow</a>.</sub>

<br>

---

<p align="center">
  <b>Open to summer 2027 internships</b> in finance, applied AI and data-driven product.<br>
  <sub>Capital markets &amp; energy · Machine learning · Applied AI · Full-stack product</sub>
</p>

<p align="center">
  <a href="https://louisneubauer.com">Website</a> ·
  <a href="https://www.linkedin.com/in/louis-neubauer/">LinkedIn</a> ·
  <a href="https://github.com/LouisNeubauer?tab=repositories">All repositories</a>
</p>
