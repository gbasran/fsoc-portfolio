# Operation fsoc: Case Study

A defense-first, multi-phase security engineering project I have been running out of my own homelab since August 2025. This repository is a **sanitized writeup**, not a runbook. Specific products, version numbers, narrow category-level descriptions, architectural details, IP addresses, hostnames, domains, and script internals have been deliberately kept out.

What is here is the engineering process: the threat model structure, the audit methodology, the design goals behind the monitoring scripts, and the integration lessons generalized to the class-of-trap level.

## The documents (read in order)

| # | Document | What it covers |
|---|---|---|
| 1 | [`1-Overview.pdf`](1-Overview.pdf) | What the project is, why I built it, high-level architecture, defensive bias, organization, status |
| 2 | [`2-ThreatModel.pdf`](2-ThreatModel.pdf) | What I defend against, what I explicitly do not, the assume-breach table, severity categories |
| 3 | [`3-HardeningMethodology.pdf`](3-HardeningMethodology.pdf) | The five-step audit loop, phase ordering, gating protocol |
| 4 | [`4-ScriptsShowcase.pdf`](4-ScriptsShowcase.pdf) | Production monitoring automation at the goal level (no code, no layer mapping) |
| 5 | [`5-LessonsLearned.pdf`](5-LessonsLearned.pdf) | Integration traps, generalized to the class-of-trap level |
| 6 | [`6-Security.pdf`](6-Security.pdf) | What is redacted, what is published, how to report a leak |
| 7 | [`7-WorkstationMigration.pdf`](7-WorkstationMigration.pdf) | Bringing the operator workstation under the same threat model; the residual risk it does and does not close |

LaTeX sources for all seven are in [`tex/`](tex/).

*Revised 2026-06-04 (rev. 2): updated for the audit, remediation, and second hardening milestones, the move to certificate-based fleet auth and deployed canary tokens, and the operator-workstation migration (document 7). The sanitization gate was extended to cover the workstation and desktop stack.*

## Author

Gurmann Basran. Computer Science student at the University of Lethbridge, Founder at Phuturum Tech, aspiring security engineer. [github.com/gbasran](https://github.com/gbasran)

*The live infrastructure described in this case study is personal, and is not shared with Phuturum Tech's production infrastructure.*

## License

MIT. See [`LICENSE`](LICENSE).
