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
	@echo "== specific product names (infrastructure) =="
	@! grep -rIEi '\b(OPNsense|Suricata|CrowdSec|Wazuh|WireGuard|Unbound|AdGuard|Pi-hole|Quad9|NextDNS|Cloudflare|Mullvad|ProtonVPN|Rogers|Vaultwarden|Bitwarden|Authelia|Authentik|Proxmox|VMware|ESXi|Nginx|Caddy|Traefik|Watchtower|OpenMediaVault|OMV|autossh|fail2ban|Thinkst)\b' tex/ || (echo "LEAK"; exit 1)
	@echo "   clean"
	@echo "== specific product names (workstation + desktop stack) =="
	@# Added with the rev.2 update (workstation-migration milestone). Same reasoning as
	@# the infrastructure list: naming the distro, compositor, terminal, shell, editor,
	@# multiplexer, file manager, theme, bootloader, or filesystem narrows the stack to a
	@# fingerprint. Common-word tool names (a pager, a finder, a top-clone) are left out of
	@# the prose entirely rather than listed here, because their names would false-positive.
	@! grep -rIEi '\b(EndeavourOS|Arch Linux|Hyprland|hyprctl|Hyprlock|hypridle|hyprbars|Wayland|Waybar|Fuzzel|Mako|Zellij|Yazi|Helix|Neovim|Starship|Atuin|Kitty|Catppuccin|Kvantum|Snapper|PipeWire|NVIDIA|Lazygit|Lazydocker|mpvpaper|swww|SDDM|Plymouth|Spicetify|Vesktop|Vivaldi|MangoHud|Fastfetch|sheldon|Thunar|Nautilus|Dolphin|PCManFM|Docker|containerd|runc|GNU Stow|Stow|Zsh|systemd-boot|btrfs|LUKS|ripgrep|zoxide|Visual Studio|VS Code)\b' tex/ || (echo "LEAK"; exit 1)
	@echo "   clean"
	@echo "== fleet hostnames =="
	@! grep -rIEi '\b(shodan|optiplex|latitude|dev-fortress|docker-services)\b' tex/ || (echo "LEAK"; exit 1)
	@echo "   clean"
	@echo "== em-dashes =="
	@! grep -rIE -- '---' tex/ || (echo "LEAK: em-dashes still present"; exit 1)
	@echo "   clean"
	@echo ""
	@echo "all checks passed"
