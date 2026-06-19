# Team Charter v2

## Roles
| Role | Agent | Responsibility |
|------|-------|----------------|
| **Architect** | Kimi | Design, TZ, review, integration, comms with Roman |
| **Primary Builder** | DeepSeek v4 Pro | Production code (.gd/.tscn) per TZ only |
| **Reserve Researcher** | DeepSeek v4 Flash | API research, tools, backup if Primary stuck |
| **Reserve Architect** | Qwen 3.7 Max | Complex architectural decisions if Kimi blocked |
| **Concept Artist** | Leonardo.Ai Free | Concepts & textures per Kimi prompts only |
| **Producer / Operator** | Roman (Roma) | Testing, asset generation, GitHub, decisions |

## Rules
1. Architect is the only source of TZ. Builder starts only after TZ signed off.
2. Builder does not redesign; asks if TZ is unclear.
3. Reserve activated only by Architect (never by Builder or Roman directly).
4. Leonardo receives prompts only from Architect; Roman operates the UI.
5. All code reviewed by Architect before acceptance (KP/NC table).
6. One CP at a time. No next CP until current is accepted.

## Escalation
- Builder stuck (3 review iterations) → Architect assigns Reserve Builder.
- Architect stuck on pattern choice → Reserve Architect (Qwen) consults.
- API unknown / optimization issue → Reserve Researcher (Flash) investigates.
