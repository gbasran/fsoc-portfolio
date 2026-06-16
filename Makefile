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
	@! grep -rIEi 'phuturum\.(me|lan)|cfargotunnel\.com|cloudflare\.com|icloud\.com|namecheap' tex/ || (echo "LEAK"; exit 1)
	@echo "   clean"
	@echo "== specific product names (infrastructure) =="
	@! grep -rIEi '\b(OPNsense|Suricata|CrowdSec|Wazuh|WireGuard|Unbound|AdGuard|Pi-hole|Quad9|NextDNS|Cloudflare|cloudflared|Mullvad|ProtonVPN|Rogers|Vaultwarden|Bitwarden|Authelia|Authentik|Proxmox|VMware|ESXi|Nginx|Caddy|Traefik|Watchtower|OpenMediaVault|OMV|autossh|fail2ban|Thinkst|ntfy|ttyd|portainer|diun|filebrowser|socket-proxy|uptime-kuma|Grafana|Loki|Headscale|NetBird|Immich|Paperless|Ollama|runc|etckeeper|snap-pac|pacman|dracut|initramfs|Debian|Ubuntu|Wiki\.js|Kodachi|Ventoy|Kali|Whonix|GOAD)\b' tex/ || (echo "LEAK"; exit 1)
	@echo "   clean"
	@echo "== specific product names (workstation + desktop stack) =="
	@# Added with the rev.2 update (workstation-migration milestone). Same reasoning as
	@# the infrastructure list: naming the distro, compositor, terminal, shell, editor,
	@# multiplexer, file manager, theme, bootloader, or filesystem narrows the stack to a
	@# fingerprint. Common-word tool names (a pager, a finder, a top-clone) are left out of
	@# the prose entirely rather than listed here, because their names would false-positive.
	@! grep -rIEi '\b(EndeavourOS|Arch Linux|Hyprland|hyprctl|Hyprlock|hypridle|hyprbars|aquamarine|Wayland|Waybar|Fuzzel|Mako|nwg-dock|nwg-drawer|eww|wlogout|imv|zathura|fzf|Zellij|Yazi|Helix|Neovim|Starship|Atuin|Kitty|Catppuccin|Kvantum|Snapper|PipeWire|NVIDIA|Lazygit|Lazydocker|mpvpaper|swww|SDDM|Plymouth|Spicetify|Vesktop|Vivaldi|Obsidian|MangoHud|Fastfetch|sheldon|Thunar|Nautilus|Dolphin|PCManFM|Docker|containerd|runc|GNU Stow|Stow|Zsh|systemd-boot|btrfs|LUKS|ripgrep|zoxide|Visual Studio|VS Code)\b' tex/ || (echo "LEAK"; exit 1)
	@echo "   clean"
	@echo "== methodology + verification tooling =="
	@# Added rev.3: the V-model upgrade-safety and documentation tooling used on the
	@# workstation. Named at role level in the prose (a verification suite, a config-tracking
	@# system); the product names are gated here so they cannot slip back in.
	@! grep -rIEi '\b(goss|bats|arc42|Di[aá]taxis)\b' tex/ || (echo "LEAK"; exit 1)
	@echo "   clean"
	@echo "== fleet hostnames =="
	@! grep -rIEi '\b(shodan|optiplex|latitude|dev-fortress|docker-services|meridian|workauto|alderson)\b' tex/ || (echo "LEAK"; exit 1)
	@echo "   clean"
	@echo "== geographic (beyond country level) =="
	@! grep -rIEi '\b(Calgary|Alberta|Lethbridge|Uleth)\b' tex/ || (echo "LEAK"; exit 1)
	@echo "   clean"
	@echo "== CVE identifiers =="
	@! grep -rIE 'CVE-[0-9]{4}-[0-9]+' tex/ || (echo "LEAK"; exit 1)
	@echo "   clean"
	@echo "== email addresses =="
	@! grep -rIE '[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}' tex/ || (echo "LEAK"; exit 1)
	@echo "   clean"
	@echo "== IPv4 literals =="
	@! grep -rIE '\b([0-9]{1,3}\.){3}[0-9]{1,3}\b' tex/ || (echo "LEAK"; exit 1)
	@echo "   clean"
	@echo "== em-dashes =="
	@! grep -rIE -- '---' tex/ || (echo "LEAK: em-dashes still present"; exit 1)
	@echo "   clean"
	@echo ""
	@echo "all checks passed"
