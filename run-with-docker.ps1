$WinTZ = Get-TimeZone | Select-Object -ExpandProperty Id
$TZ = ""
[System.TimeZoneInfo]::TryConvertWindowsIdToIanaId($WinTZ, [ref]$TZ) | Out-Null
docker run -it --rm --env TZ=$TZ -v ${PWD}:/bookmark-gen -w /bookmark-gen ruby bash
