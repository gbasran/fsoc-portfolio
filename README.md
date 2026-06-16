# Operation fsoc: Case Study

A defense-first, multi-phase security engineering project I have been running out of my own homelab since August 2025. This repository is a **sanitized writeup**, not a runbook. Specific products, version numbers, narrow category-level descriptions, architectural details, IP addresses, hostnames, domains, and script internals have been deliberately kept out.

It is run as a systems-engineering effort, not a series of one-off tweaks: a charter, a requirements specification with stable IDs, a requirements traceability matrix, architecture and interface control documents, decision records, as-built documentation, and a verification-and-validation discipline.

What is here is the engineering process: the systems-engineering baseline, the threat model structure, the audit methodology, the design goals behind the monitoring scripts, and the integration lessons generalized to the class-of-trap level.

## The documents (read in order)

| # | Document | What it covers |
|---|---|---|
| 1 | [`1-Overview.pdf`](1-Overview.pdf) | What the project is, why I built it, high-level architecture, defensive bias, organization, status |
| 2 | [`2-ThreatModel.pdf`](2-ThreatModel.pdf) | What I defend against, what I explicitly do not, the assume-breach table, severity categories |
| 3 | [`3-HardeningMethodology.pdf`](3-HardeningMethodology.pdf) | The five-step audit loop, the operational-health dimension, phase ordering, gating protocol |
| 4 | [`4-ScriptsShowcase.pdf`](4-ScriptsShowcase.pdf) | Production monitoring automation at the goal level (no code, no layer mapping) |
| 5 | [`5-LessonsLearned.pdf`](5-LessonsLearned.pdf) | Integration traps, generalized to the class-of-trap level |
| 6 | [`6-Security.pdf`](6-Security.pdf) | What is redacted, what is published, how to report a leak |
| 7 | [`7-WorkstationMigration.pdf`](7-WorkstationMigration.pdf) | Bringing the operator workstation under the same threat model; the residual risk it does and does not close |

LaTeX sources for all seven are in [`tex/`](tex/).

*Revised 2026-06-15 (rev. 3): updated to today's state and the work planned next. Fleet authentication has finished its cutover to certificate-only access; an operational-health and capacity dimension was added to the monitoring after an outage the security audit could not have caught; a recovery-insurance milestone proved the backups actually restore, escrowed the backup encryption key off the fleet, and put a staleness alarm on the backups themselves; an unused service and a redundant external entry path were retired to shrink attack surface; execution of the change-management process is now governed by a risk-classified automation layer with human approval gates; and the operator-workstation work has progressed to a verified self-healing layer, with a terminal-native command center being built on top. A planned physical relocation of the hardware is the next external deadline and doubles as a full-restore validation. The sanitization gate was extended again to cover the new tooling.*

## Author

Gurmann Basran. Computer Science student, Founder at Phuturum Tech, aspiring security engineer. [github.com/gbasran](https://github.com/gbasran)

*The live infrastructure described in this case study is personal, and is not shared with Phuturum Tech's production infrastructure.*

## License

MIT. See [`LICENSE`](LICENSE).
