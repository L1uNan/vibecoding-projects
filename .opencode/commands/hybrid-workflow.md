---
description: Hybrid workflow - combines OpenSpec flexibility with Trinity tracking
---

Hybrid workflow combining OpenSpec flexibility with Trinity tracking.

## Usage

```bash
# Quick mode (clear requirements)
/hybrid-new <name> --mode quick
/hybrid-ff                         # Generate all planning docs
/hybrid-apply                      # Execute with 3-Strike protocol
/hybrid-archive                    # Archive change

# Explore mode (unclear requirements)
/hybrid-explore                    # Explore problem space first
/hybrid-new <name> --mode explore
/hybrid-continue                   # Step-by-step artifact creation
/hybrid-apply
/hybrid-archive

# Structured mode (large features)
/hybrid-new <name> --mode structured
/hybrid-continue                   # Create proposal
/hybrid-continue                   # Create design
/hybrid-continue                   # Create specs
/hybrid-continue                   # Create tasks
/hybrid-apply
/hybrid-verify
/hybrid-archive
```

## Modes

| Mode | Flow | Best For |
|------|------|----------|
| quick | init → ff → apply → archive | Clear requirements, fast delivery |
| explore | explore → init → continue → apply → archive | Unclear requirements, investigation |
| structured | init → proposal → design → specs → tasks → apply → archive | Large features, formal process |

## Key Features

1. **Flexible Start** - Optional exploration phase
2. **Mandatory Tracking** - Planning-with-Files initialization
3. **Fast-Forward** - One-command planning generation
4. **3-Strike Protocol** - Systematic error handling
5. **Verification** - Completeness, correctness, coherence checks

## Commands

| Command | Description |
|---------|-------------|
| `/hybrid-new` | Create new hybrid workflow change |
| `/hybrid-explore` | Explore problem space |
| `/hybrid-ff` | Fast-forward: generate all planning docs |
| `/hybrid-continue` | Create next artifact |
| `/hybrid-apply` | Execute tasks with 3-Strike protocol |
| `/hybrid-verify` | Verify implementation |
| `/hybrid-status` | Show workflow status |
| `/hybrid-archive` | Archive completed change |
