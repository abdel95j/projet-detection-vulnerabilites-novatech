#!/usr/bin/env bash
set -euo pipefail
export_dir=/data/LaboVulnerabilites/exports
names=("kali-linux-2026.3-virtualbox-amd64" "srv-web" "srv-legacy")
files=("kali-novatech.ova" "srv-web-novatech.ova" "srv-legacy-novatech.ova")
mkdir -p "$export_dir"
for i in "${!names[@]}"; do
  state=$(VBoxManage showvminfo "${names[$i]}" --machinereadable | sed -n 's/^VMState="\(.*\)"$/\1/p')
  if [[ "$state" != "poweroff" ]]; then
    echo "Arreter proprement ${names[$i]} avant export (etat : $state)." >&2; exit 1
  fi
  if [[ -e "$export_dir/${files[$i]}" ]]; then
    echo "Export deja present : ${files[$i]}. Aucun ecrasement automatique." >&2; exit 1
  fi
done
for i in "${!names[@]}"; do
  VBoxManage export "${names[$i]}" --output "$export_dir/${files[$i]}" --ovf20
done
cd "$export_dir"
sha256sum "${files[@]}" > SHA256SUMS
ls -lh "${files[@]}" SHA256SUMS
echo "Exports termines. Partager ce dossier en prive et verifier les imports sur le poste destinataire."
