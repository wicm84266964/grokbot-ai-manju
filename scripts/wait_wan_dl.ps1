$diffPath = 'C:\saveproject\LBJ-workspace\ComfyUI\models\diffusion_models\wan2.1_t2v_1.3B_fp16.safetensors'
$tePath = 'C:\saveproject\LBJ-workspace\ComfyUI\models\text_encoders\umt5_xxl_fp8_e4m3fn_scaled.safetensors'
$diffExpect = 2838303560L
$teExpect = 6735845504L
$diffUrl = 'https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/diffusion_models/wan2.1_t2v_1.3B_fp16.safetensors'
$teUrl = 'https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors'
$curlBin = 'C:\WINDOWS\system32\curl.exe'
$proxy = 'http://127.0.0.1:7897'

function Restart-Curl($path, $url, $pattern) {
  Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'curl.exe' -and $_.CommandLine -match $pattern } | ForEach-Object {
    Stop-Process -Id $_.ProcessId -Force -ErrorAction SilentlyContinue
  }
  Start-Sleep -Seconds 1
  $a = @('-x',$proxy,'-L','--connect-timeout','30','--retry','0','-C','-','-o',$path,$url)
  Start-Process -FilePath $curlBin -ArgumentList $a -WindowStyle Hidden
  Write-Output "RESTARTED $pattern size=$((Get-Item $path -EA SilentlyContinue).Length)"
}

$lastDiff = -1L; $lastTe = -1L
$stallDiff = 0; $stallTe = 0
$minutes = 20
$deadline = (Get-Date).AddMinutes($minutes)
while ((Get-Date) -lt $deadline) {
  $d = if (Test-Path $diffPath) { (Get-Item $diffPath).Length } else { 0 }
  $t = if (Test-Path $tePath) { (Get-Item $tePath).Length } else { 0 }
  $curls = @(Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'curl.exe' -and ($_.CommandLine -match 'wan2.1_t2v|umt5_xxl') })
  $diffCurl = @($curls | Where-Object { $_.CommandLine -match 'wan2.1_t2v' }).Count
  $teCurl = @($curls | Where-Object { $_.CommandLine -match 'umt5_xxl' }).Count
  Write-Output ("[$(Get-Date -Format 'HH:mm:ss')] diff=$([math]::Round($d/1MB,1))MB/$([math]::Round($diffExpect/1MB,0)) curl=$diffCurl | te=$([math]::Round($t/1MB,1))MB/$([math]::Round($teExpect/1MB,0)) curl=$teCurl")

  if ($d -gt $lastDiff) { $stallDiff = 0 } elseif ($d -lt $diffExpect) { $stallDiff++ }
  if ($t -gt $lastTe) { $stallTe = 0 } elseif ($t -lt $teExpect) { $stallTe++ }
  # truncation: only note, resume from current (do not delete)
  if ($lastDiff -gt 0 -and $d + 50MB -lt $lastDiff) { Write-Output "WARN_DIFF_SHRINK $lastDiff -> $d" }
  if ($lastTe -gt 0 -and $t + 50MB -lt $lastTe) { Write-Output "WARN_TE_SHRINK $lastTe -> $t" }
  $lastDiff = $d; $lastTe = $t

  if ($d -ge $diffExpect -and $diffCurl -gt 0) {
    # done but curl still up briefly
  }
  if ($diffCurl -eq 0 -and $d -lt $diffExpect) { Restart-Curl $diffPath $diffUrl 'wan2.1_t2v'; $stallDiff = 0 }
  if ($teCurl -eq 0 -and $t -lt ([Math]::Min($teExpect, $teExpect))) { Restart-Curl $tePath $teUrl 'umt5_xxl'; $stallTe = 0 }
  # stall 3 min = 9 * 20s
  if ($stallDiff -ge 9 -and $d -lt $diffExpect) { Restart-Curl $diffPath $diffUrl 'wan2.1_t2v'; $stallDiff = 0 }
  if ($stallTe -ge 9 -and $t -lt $teExpect) { Restart-Curl $tePath $teUrl 'umt5_xxl'; $stallTe = 0 }

  if ($d -ge $diffExpect -and $t -ge ([int64]($teExpect * 0.999)) -and $diffCurl -eq 0 -and $teCurl -eq 0) {
    Write-Output 'ALL_DONE'; break
  }
  if ($d -eq $diffExpect -and $teCurl -eq 0 -and $diffCurl -eq 0 -and $t -gt 6GB) {
    # if te finished to unknown exact, accept when curl gone and size stable large
  }
  Start-Sleep -Seconds 20
}
$d = if (Test-Path $diffPath) { (Get-Item $diffPath).Length } else { 0 }
$t = if (Test-Path $tePath) { (Get-Item $tePath).Length } else { 0 }
$curls = @(Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'curl.exe' -and ($_.CommandLine -match 'wan2.1_t2v|umt5_xxl') })
Write-Output ("FINAL diff=$d te=$t curls=$($curls.Count)")
if ($d -ge $diffExpect -and $t -ge ([int64]($teExpect * 0.999)) -and $curls.Count -eq 0) { Write-Output 'STATUS=COMPLETE' } else { Write-Output 'STATUS=IN_PROGRESS' }
