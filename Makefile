# Operation fsoc case-study PDF build
#
# Targets:
#   make all    (default) compile every .tex in tex/ into a PDF at the repo root
#   make clean  remove compiled PDFs and LaTeX auxiliary files
#   make check  run sanitization greps against tex/ to catch leaks before commit

TEX_SRC := $(wildcard tex/*.tex)
PDF_OUT := $(patsubst tex/%.tex,%.pdf,$(TEX_SRC))
BUILD   := .build

.PHONY: all clean check

all: $(PDF_OUT)

%.pdf: tex/%.tex | $(BUILD)
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory=$(BUILD) $<
	pdflatex -interaction=nonstopmode -halt-on-error -output-directory=$(BUILD) $<
	cp $(BUILD)/$(notdir $@) $@

$(BUILD):
	mkdir -p $(BUILD)

clean:
	rm -rf $(BUILD)
	rm -f *.pdf

check:
	@echo "== VLAN IPs =="
	@! grep -rIE '10\.(10|20|30|40)\.[0-9]' tex/ || (echo "LEAK"; exit 1)
	@echo "   clean"
	@echo "== real domains =="
	@! grep -rIE 'phuturum\.(me|lan)' tex/ || (echo "LEAK"; exit 1)
	@echo "   clean"
	@echo "== specific product names =="
	@! grep -rIEi '\b(OPNsense|Suricata|CrowdSec|Wazuh|WireGuard|Unbound|AdGuard|Pi-hole|Quad9|NextDNS|Cloudflare|Mullvad|ProtonVPN|Rogers|Vaultwarden|Bitwarden|Authelia|Authentik|Proxmox|VMware|ESXi|Nginx|Caddy|Traefik|Watchtower|OpenMediaVault|OMV|autossh|fail2ban)\b' tex/ || (echo "LEAK"; exit 1)
	@echo "   clean"
	@echo "== em-dashes =="
	@! grep -rIE -- '---' tex/ || (echo "LEAK: em-dashes still present"; exit 1)
	@echo "   clean"
	@echo ""
	@echo "all checks passed"
