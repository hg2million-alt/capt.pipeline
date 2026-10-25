#!/usr/bin/env bash
# Roda sozinho no começo de cada sessão (hook SessionStart em .claude/settings.json).
# Instala o que o pipeline usa e que não vem no ambiente da nuvem:
# Pillow (paleta/fotos), yt-dlp (reels) e um ffmpeg com H.264 (vídeo pro site).
# Se já estiver tudo instalado, não faz nada. Nunca trava a sessão: erro só vira aviso.
falta=()
python3 -c "import PIL" 2>/dev/null || falta+=(pillow)
python3 -c "import yt_dlp" 2>/dev/null || command -v yt-dlp >/dev/null || falta+=(yt-dlp)
command -v ffmpeg >/dev/null || python3 -c "import imageio_ffmpeg" 2>/dev/null || falta+=(imageio-ffmpeg)

if [ ${#falta[@]} -gt 0 ]; then
  pip install -q "${falta[@]}" 2>/dev/null \
    || pip install -q --break-system-packages "${falta[@]}" 2>/dev/null \
    || echo "AVISO setup-nuvem: não consegui instalar ${falta[*]} — fotos/vídeos podem precisar ser feitos à mão."
fi
exit 0
