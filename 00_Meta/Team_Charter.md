# Team Charter

## Roles

| Role | Entity | Responsibility |
|------|--------|---------------|
| **Architect** | Kimi | System design, TЗ, code review, integration |
| **Primary Builder** | DeepSeek v4 Pro | Production code implementation |
| **Reserve Researcher** | DeepSeek v4 Flash | API research, auxiliary tools |
| **Reserve Architect** | Qwen 3.7 Max | Complex architectural decisions |
| **Concept Artist** | Leonardo.Ai Free | Visual concepts, textures, UI icons |
| **Producer / Operator** | Roman | Project owner, art generation, testing, git |

## Communication Rules

1. Architect is the single point of contact for all architectural decisions.
2. Builder implements strictly per TЗ from Architect.
3. Reserve models are activated only by Architect's request.
4. Leonardo prompts come exclusively from Architect.
5. Roman operates Leonardo and tests builds.

## Escalation Protocol

- Builder stuck (3 review iterations) → Architect calls Reserve Builder.
- Architectural deadlock → Architect calls Reserve Architect.
- Unknown API / optimization issue → Architect calls Reserve Researcher.
