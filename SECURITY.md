# Security Posture

This repository is a sanitized case study. The full security posture, redaction philosophy, and responsible-disclosure guidance is in [`6-Security.pdf`](6-Security.pdf).

## Summary

- Specific products, versions, network topology, IPs, hostnames, domains, rule IDs, and script internals are deliberately kept out. This includes the operator workstation's stack (distribution, desktop, terminal and shell, editor, bootloader, encryption layout), which is the most-privileged endpoint and the one I least want to describe.
- Category-level descriptions narrow enough to infer a product are also kept out.
- Operational tuning is out too: the thresholds and capacity numbers the monitoring triggers on, the physical escrow arrangement for the backup encryption key, the internals of the task conductor that runs the project, and the destination of the planned hardware relocation beyond the fact that there is one.
- The sanitization gate (`make check`) enforces this on every build, failing on any IP, real domain, denylisted product or hostname, or em-dash before the PDFs compile. The denylist is extended with each revision as the live system grows new tooling.
- What is published is the methodology, the threat-model structure, the design reasoning, and integration lessons generalized to the class-of-trap level.

## Reporting a redaction failure

If you believe something in this repository meaningfully exposes the underlying deployment (a real IP / hostname / domain I missed, a category-level phrase that narrows to a specific product, or an inference chain that reveals more than any single document does on its own), please open an issue with the `security` label or reach me through the contact on my GitHub profile.

I take it seriously. The redaction posture is part of the engineering, not an afterthought.
