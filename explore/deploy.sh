#!/usr/bin/env bash

FILE_PATH="partners-list.ts"
FILE_PATH2="sum.ts"

rm $FILE_PATH2 partner* networks*


wget  https://raw.githubusercontent.com/layerztec/layerzwallet/refs/heads/master/shared/types/networks.ts
wget https://raw.githubusercontent.com/layerztec/layerzwallet/refs/heads/master/shared/models/partners-list.ts
wget https://raw.githubusercontent.com/layerztec/layerzwallet/refs/heads/master/shared/types/partner-info.ts


if [[ ! -f "$FILE_PATH" ]]; then
echo "Error: file not found after download: $FILE_PATH" >&2
exit 1
fi

tmp_file=$(mktemp)
tail -n +3 -- "$FILE_PATH" | head -n -3 > "$tmp_file"
mv -- "$tmp_file" "$FILE_PATH"
echo "Trimmed $FILE_PATH"



# Remove the first line from partner-info.ts
FILE_PATH_PARTNER_INFO="partner-info.ts"
if [[ ! -f "$FILE_PATH_PARTNER_INFO" ]]; then
  echo "Error: file not found: $FILE_PATH_PARTNER_INFO" >&2
  exit 1
fi


tmp_file_partner_info=$(mktemp)
tail -n +2 -- "$FILE_PATH_PARTNER_INFO" > "$tmp_file_partner_info"
mv -- "$tmp_file_partner_info" "$FILE_PATH_PARTNER_INFO"
echo "Removed first line from $FILE_PATH_PARTNER_INFO"




cat networks.ts >> $FILE_PATH2
cat partner-info.ts >> $FILE_PATH2
cat partners-list.ts >> $FILE_PATH2


echo 'export { partnersList };' >> $FILE_PATH2


bun run write-partners.ts


