# Settings
$file_name = "ghub-$(Get-Date -Format 'dd.MM.yyyy.hh.mm').backup.zip";
$ghub_settings_path = "$($env:LOCALAPPDATA)\LGHUB";
$output_dir = "$($env:HOMEDRIVE)$($env:HOMEPATH)\ghub-backup\";
$output_path = "$output_dir\$file_name";

# Change this to prefered time
$time_limit = (Get-Date).AddDays(-90);

# Creates directory
New-Item -ItemType Directory -Force -Path "$output_dir";

Compress-Archive -Path "$ghub_settings_path" -DestinationPath "$output_path";

# Source: https://stackoverflow.com/a/19326146/2446102
# Remove files older than $time_limit
Get-ChildItem -Path $output_path -Recurse -Force | Where-Object { !$_.PSIsContainer -and $_.CreationTime -lt $time_limit } | Remove-Item -Force;
