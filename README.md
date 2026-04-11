# claude-skills

My custom skills for [Claude Code](https://docs.anthropic.com/en/docs/claude-code).

## Skills

| Skill | Description |
|-------|-------------|
| [icon-finder](./icon-finder) | Search & retrieve icons from Lucide, Heroicons, Phosphor, Tabler, Remix Icon, Bootstrap Icons via Iconify API |
| [academic-review-skill](./academic-review-skill) | Structured review for academic papers, thesis proposals, and journal submissions |

## Installation

### Quick install (symlink all skills)

```bash
./install.sh
```

### Install a single skill

```bash
ln -sf "$(pwd)/icon-finder" ~/.claude/skills/icon-finder
```

Or copy directly:

```bash
cp -r icon-finder ~/.claude/skills/
```

## Creating a new skill

1. Create a new directory: `mkdir my-skill`
2. Add a `SKILL.md` with frontmatter (`name`, `description`) and instructions
3. Run `./install.sh` to symlink into Claude Code
4. The skill appears automatically in your next Claude Code session

## Structure

```
claude-skills/
├── README.md
├── install.sh
├── icon-finder/
│   ├── SKILL.md          # Skill instructions
│   ├── README.md         # Documentation
│   └── LICENSE
├── academic-review-skill/
│   ├── SKILL.md
│   └── references/       # Evaluation criteria
└── ...
```

## License

MIT
