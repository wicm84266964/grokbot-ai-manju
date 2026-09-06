$files = @(
  'C:\saveproject\LBJ-workspace\ComfyUI\models\vae\wan_2.1_vae.safetensors',
  'C:\saveproject\LBJ-workspace\ComfyUI\models\diffusion_models\wan2.1_t2v_1.3B_fp16.safetensors',
  'C:\saveproject\LBJ-workspace\ComfyUI\models\text_encoders\umt5_xxl_fp8_e4m3fn_scaled.safetensors'
)
$expect = @(253815318, 2837220156, 6735845504)
for ($i=0; $i -lt $files.Count; $i++) {
  $f = $files[$i]
  if (Test-Path $f) {
    $sz = (Get-Item $f).Length
    $mb = [math]::Round($sz/1MB, 2)
    $pct = [math]::Round(100.0*$sz/$expect[$i], 1)
    Write-Output "SIZE $mb MB ($sz) $pct% :: $f"
  } else {
    Write-Output "MISSING :: $f"
  }
}
Write-Output '---CURL---'
Get-CimInstance Win32_Process | Where-Object { $_.Name -eq 'curl.exe' } | ForEach-Object {
  Write-Output ("PID=$($_.ProcessId) CMD=$($_.CommandLine)")
}
Write-Output '---COMFY---'
Get-CimInstance Win32_Process | Where-Object { $_.Name -match 'python' -and $_.CommandLine -match 'main.py|ComfyUI' } | ForEach-Object {
  Write-Output ("PID=$($_.ProcessId) CMD=$($_.CommandLine)")
}
