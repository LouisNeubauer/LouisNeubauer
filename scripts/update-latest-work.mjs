#!/usr/bin/env node
/**
 * Rebuilds the "Latest work" section of README.md from public GitHub activity.
 *
 * Reads only public data, so the default GITHUB_TOKEN is enough and private
 * repositories never appear. If the API is unreachable the README is left
 * exactly as it is, and the script exits 0 — a transient outage must not
 * blank the profile.
 */

import { readFile, writeFile } from 'node:fs/promises';

const USER = process.env.PROFILE_USER || 'LouisNeubauer';
const README = new URL('../README.md', import.meta.url);
const START = '<!-- LATEST-WORK:START -->';
const END = '<!-- LATEST-WORK:END -->';
const MAX_REPOS = 5;
const MAX_EVENTS = 5;

const headers = {
  accept: 'application/vnd.github+json',
  'x-github-api-version': '2022-11-28',
  'user-agent': 'profile-latest-work-workflow',
};
if (process.env.GITHUB_TOKEN) headers.authorization = `Bearer ${process.env.GITHUB_TOKEN}`;

async function api(path) {
  const res = await fetch(`https://api.github.com${path}`, { headers });
  if (!res.ok) throw new Error(`GitHub API ${res.status} for ${path}`);
  return res.json();
}

function ago(iso) {
  const days = Math.floor((Date.now() - new Date(iso).getTime()) / 86400000);
  if (days <= 0) return 'today';
  if (days === 1) return 'yesterday';
  if (days < 30) return `${days} days ago`;
  const months = Math.floor(days / 30);
  if (months < 12) return months === 1 ? 'last month' : `${months} months ago`;
  const years = Math.floor(months / 12);
  return years === 1 ? 'last year' : `${years} years ago`;
}

const escape = (s) => String(s ?? '').replace(/\|/g, '\\|').replace(/[\r\n]+/g, ' ').trim();

function describeEvent(e) {
  const repo = `[\`${e.repo.name}\`](https://github.com/${e.repo.name})`;
  switch (e.type) {
    case 'PushEvent': {
      const n = e.payload?.commits?.length ?? 0;
      const msg = e.payload?.commits?.at(-1)?.message?.split('\n')[0];
      return `Pushed ${n} commit${n === 1 ? '' : 's'} to ${repo}${msg ? ` — ${escape(msg)}` : ''}`;
    }
    case 'PullRequestEvent':
      return `${e.payload.action === 'closed' && e.payload.pull_request?.merged ? 'Merged' : `${e.payload.action[0].toUpperCase()}${e.payload.action.slice(1)}`} PR [#${e.payload.number}](${e.payload.pull_request?.html_url}) in ${repo} — ${escape(e.payload.pull_request?.title)}`;
    case 'CreateEvent':
      return `Created ${e.payload.ref_type}${e.payload.ref ? ` \`${escape(e.payload.ref)}\`` : ''} in ${repo}`;
    case 'ReleaseEvent':
      return `Released [${escape(e.payload.release?.tag_name)}](${e.payload.release?.html_url}) in ${repo}`;
    case 'IssuesEvent':
      return `${e.payload.action[0].toUpperCase()}${e.payload.action.slice(1)} issue [#${e.payload.issue?.number}](${e.payload.issue?.html_url}) in ${repo}`;
    default:
      return null;
  }
}

export function render(repos, events) {
  const lines = [];

  const active = repos
    .filter((r) => !r.private && !r.archived)
    .sort((a, b) => new Date(b.pushed_at) - new Date(a.pushed_at))
    .slice(0, MAX_REPOS);

  if (active.length) {
    lines.push('| Repository | What it is | Last update |');
    lines.push('|---|---|---|');
    for (const r of active) {
      const desc = escape(r.description) || '_No description yet._';
      const lang = r.language ? ` <sub>\`${escape(r.language)}\`</sub>` : '';
      lines.push(`| **[${escape(r.name)}](${r.html_url})** | ${desc}${lang} | ${ago(r.pushed_at)} |`);
    }
  }

  const feed = events.map(describeEvent).filter(Boolean).slice(0, MAX_EVENTS);
  if (feed.length) {
    if (lines.length) lines.push('');
    lines.push('<details>');
    lines.push('<summary><b>Recent public activity</b></summary>');
    lines.push('');
    for (const item of feed) lines.push(`- ${item}`);
    lines.push('');
    lines.push('</details>');
  }

  if (!lines.length) return null;

  lines.push('');
  lines.push(
    `<sub>Rebuilt automatically — last run ${new Date().toISOString().slice(0, 10)}.</sub>`,
  );
  return lines.join('\n');
}

async function main() {
  let repos = [];
  let events = [];
  try {
    [repos, events] = await Promise.all([
      api(`/users/${USER}/repos?per_page=100&sort=pushed&type=owner`),
      api(`/users/${USER}/events/public?per_page=100`).catch(() => []),
    ]);
  } catch (err) {
    console.error(`Could not reach the GitHub API — leaving README unchanged. ${err.message}`);
    return;
  }

  const body = render(repos, Array.isArray(events) ? events : []);
  if (!body) {
    console.error('No public activity to show — leaving README unchanged.');
    return;
  }

  const readme = await readFile(README, 'utf8');
  const start = readme.indexOf(START);
  const end = readme.indexOf(END);
  if (start === -1 || end === -1 || end < start) {
    console.error(`Markers ${START} / ${END} not found — leaving README unchanged.`);
    process.exitCode = 1;
    return;
  }

  const next = `${readme.slice(0, start + START.length)}\n\n${body}\n\n${readme.slice(end)}`;
  if (next === readme) {
    console.log('Latest work section already up to date.');
    return;
  }

  await writeFile(README, next);
  console.log('Latest work section updated.');
}

if (import.meta.url === `file://${process.argv[1]}`) await main();
