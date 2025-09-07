#!/usr/bin/env bash

FILE_PATH_SUM="sum.ts"

rm $FILE_PATH_SUM partner-info.ts networks.ts partners-list.ts


wget https://raw.githubusercontent.com/layerztec/layerzwallet/refs/heads/master/shared/types/networks.ts
wget https://raw.githubusercontent.com/layerztec/layerzwallet/refs/heads/master/shared/models/partners-list.ts
wget https://raw.githubusercontent.com/layerztec/layerzwallet/refs/heads/master/shared/types/partner-info.ts


if [[ ! -f "partners-list.ts" ]]; then
echo "Error: file not found after download: partners-list.ts" >&2
exit 1
fi

tmp_file=$(mktemp)
tail -n +3 -- "partners-list.ts" | head -n -3 > "$tmp_file"
mv -- "$tmp_file" "partners-list.ts"
echo "Trimmed partners-list.ts"



# Remove the first line from partner-info.ts
if [[ ! -f "partner-info.ts" ]]; then
  echo "Error: file not found: partner-info.ts" >&2
  exit 1
fi


tmp_file_partner_info=$(mktemp)
tail -n +2 -- "partner-info.ts" > "$tmp_file_partner_info"
mv -- "$tmp_file_partner_info" "partner-info.ts"
echo "Removed first line from partner-info.ts"




cat networks.ts >> $FILE_PATH_SUM
cat partner-info.ts >> $FILE_PATH_SUM
cat partners-list.ts >> $FILE_PATH_SUM


echo 'export { partnersList };' >> $FILE_PATH_SUM


bun run write-partners.ts


