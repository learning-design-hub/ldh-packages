# Learning Design Hub - package installer: simple-course (Simple Repetitive Course standard)
# Install (Windows PowerShell):
#   irm https://raw.githubusercontent.com/learning-design-hub/ldh-packages/main/install/simple-course.ps1 | iex
# Pin a version:
#   $env:LDH_VERSION = 'v1.1.0'; irm https://raw.githubusercontent.com/learning-design-hub/ldh-packages/main/install/simple-course.ps1 | iex
& {
  $ErrorActionPreference = 'Stop'
  $ProgressPreference = 'SilentlyContinue'
  $repo = 'learning-design-hub/ldh-packages'
  $id = 'simple-course'
  $here = (Get-Location).ProviderPath
  $dest = Join-Path $here $id
  if (Test-Path -LiteralPath $dest) {
    Write-Host "A folder named '$id' already exists here. Remove it or run the command from another folder." -ForegroundColor Yellow
    return
  }
  $ver = $env:LDH_VERSION
  if ($ver) { $url = "https://github.com/$repo/releases/download/$ver/$id.zip" }
  else { $url = "https://github.com/$repo/releases/latest/download/$id.zip" }
  [Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12
  $zip = Join-Path ([IO.Path]::GetTempPath()) ("ldh-" + [guid]::NewGuid() + ".zip")
  try {
    Write-Host "Downloading $id ..."
    Invoke-WebRequest -Uri $url -OutFile $zip -UseBasicParsing
    Write-Host "Extracting ..."
    # Extract straight into ./<id>, dropping the archive's top folder (keeps paths short).
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $archive = [IO.Compression.ZipFile]::OpenRead($zip)
    try {
      foreach ($e in $archive.Entries) {
        $rel = $e.FullName -replace '^[^/]+/', ''
        if (-not $rel -or $rel -match '(^|/)\.\.(/|$)') { continue }
        $target = Join-Path $dest ($rel -replace '/', '\')
        if ($e.FullName.EndsWith('/')) { [void][IO.Directory]::CreateDirectory($target); continue }
        [void][IO.Directory]::CreateDirectory([IO.Path]::GetDirectoryName($target))
        [IO.Compression.ZipFileExtensions]::ExtractToFile($e, $target, $true)
      }
    }
    finally { $archive.Dispose() }
    Write-Host ""
    Write-Host "Installed: $dest" -ForegroundColor Green
    Write-Host "Next: open the folder and start with the file whose name begins with 00 (start here)."
  }
  catch {
    Write-Host "Install failed: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "If the error mentions the path, run the command from a shorter folder such as C:\Projects"
    Write-Host "Or download it manually: $url"
    Remove-Item -LiteralPath $dest -Recurse -Force -ErrorAction SilentlyContinue
  }
  finally {
    Remove-Item -LiteralPath $zip -Force -ErrorAction SilentlyContinue
  }
}
