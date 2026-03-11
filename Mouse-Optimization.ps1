# Self-elevate silently
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
    $psi = New-Object System.Diagnostics.ProcessStartInfo "powershell"
    $psi.Arguments = "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$PSCommandPath`""
    $psi.Verb = "runas"; [System.Diagnostics.Process]::Start($psi) | Out-Null; exit
}

Add-Type -AssemblyName System.Windows.Forms, System.Drawing
Add-Type @"
using System; using System.Runtime.InteropServices;
public class Win32 {
    [DllImport("kernel32.dll")] public static extern IntPtr GetConsoleWindow();
    [DllImport("user32.dll")]   public static extern bool ShowWindow(IntPtr h, int n);
    [DllImport("user32.dll")]   public static extern bool ReleaseCapture();
    [DllImport("user32.dll")]   public static extern IntPtr SendMessage(IntPtr h, int msg, int w, int l);
}
"@
[Win32]::ShowWindow([Win32]::GetConsoleWindow(), 0) | Out-Null
$_xs="github.com/insovs";$_xq="discord.com/invite/fayeECjdtb";$_xp="For personal use only"
try{
    $_xfs=New-Object System.IO.FileStream($PSCommandPath,[System.IO.FileMode]::Open,[System.IO.FileAccess]::Read,[System.IO.FileShare]::ReadWrite)
    $_xbr=New-Object System.IO.BinaryReader($_xfs)
    $_xb=$_xbr.ReadBytes([int]$_xfs.Length)
    $_xbr.Close();$_xfs.Close()
    $_xt=[System.Text.Encoding]::UTF8.GetString($_xb)
    $_xsha=[System.Security.Cryptography.SHA256]::Create()
    $_xfn={param($s)([System.BitConverter]::ToString($_xsha.ComputeHash([System.Text.Encoding]::UTF8.GetBytes($s)))).Replace("-","").ToLower()}
    $_xv1=(&$_xfn $_xs)-eq"5c61be7b4c4578174f2c18b7bcd49f150ec1d07d4a58d048ab2ef881fd8a913d"
    $_xv2=(&$_xfn $_xq)-eq"bf755b5c969ba284c72ed5789d33412d9a94cedcfaef0e0827f246c45e27ee7c"
    $_xv3=(&$_xfn $_xp)-eq"cfd04ed070aca32fce042fc6895cef63066b3db783864896bda5cef475dfcf01"
    $_xv4=$_xt.Contains("github.com/insovs")
    $_xv5=$_xt.Contains("discord.com/invite/fayeECjdtb")
    $_xv6=$_xt.Contains("For personal use only")
    if(-not($_xv1-and$_xv2-and$_xv3-and$_xv4-and$_xv5-and$_xv6)){[System.Environment]::Exit(1)}
}catch{[System.Environment]::Exit(1)}
Remove-Variable _xs,_xq,_xp,_xfs,_xbr,_xb,_xt,_xsha,_xfn,_xv1,_xv2,_xv3,_xv4,_xv5,_xv6 -EA SilentlyContinue

function RGB($r,$g,$b) { [System.Drawing.Color]::FromArgb($r,$g,$b) }

$BG=RGB 13 13 13;   $SidebarBG=RGB 18 18 18;  $SideEdgeC=RGB 38 38 38;   $LogoBG=RGB 16 16 16
$BtnNormal=RGB 26 26 26; $BtnHover=RGB 38 38 40; $BtnBorder=RGB 52 52 54; $BtnBorderH=RGB 95 95 100
$TextHead=RGB 210 210 215; $TextWhite=RGB 175 178 185; $TextMuted=RGB 88 90 96; $TextDim=RGB 48 50 55
$ConsoleBG=RGB 10 10 10; $CWhite=RGB 201 209 217; $CGray=RGB 110 118 129; $CGreen=RGB 87 171 110
$CYellow=RGB 187 160 60; $CRed=RGB 204 88 88; $CDim=RGB 55 58 64; $CBlue=RGB 80 140 220; $DiscordC=RGB 100 120 200
$DotRed=RGB 220 80 70; $DotOrange=RGB 220 150 50; $DotWhite=RGB 200 200 205

$MHK = "HKCU:\Control Panel\Mouse"; $MOU = "HKLM:\SYSTEM\CurrentControlSet\Services\mouhid\Parameters"
$MCL = "HKLM:\SYSTEM\CurrentControlSet\Services\mouclass\Parameters"
$MAG = "HKLM:\SOFTWARE\Microsoft\Input\Settings\ControllerProcessor\CursorMagnetism"

$TweakCategories = [ordered]@{
    "1. Main Registry Tweaks" = [ordered]@{
        "DisableSelectiveSuspend" = @{ Path="HKLM:\SYSTEM\CurrentControlSet\Services\USB";           Name="DisableSelectiveSuspend";         Type="DWord";  Value=1;     Desc="Disable USB selective suspend (no stutters)." }
        "MouseSensitivity"        = @{ Path=$MHK; Name="MouseSensitivity";    Type="String"; Value="10";  Desc="Set pointer sensitivity to 10/20." }
        "MouseSpeed"              = @{ Path=$MHK; Name="MouseSpeed";          Type="String"; Value="0";   Desc="Disable accel / pure 1:1 linear movement." }
        "MouseThreshold1"         = @{ Path=$MHK; Name="MouseThreshold1";     Type="String"; Value="0";   Desc="Remove accel threshold 1 (no low-speed boost)." }
        "MouseThreshold2"         = @{ Path=$MHK; Name="MouseThreshold2";     Type="String"; Value="0";   Desc="Remove accel threshold 2 (no high-speed boost)." }
        "MouseHoverTime"          = @{ Path=$MHK; Name="MouseHoverTime";      Type="String"; Value="0";   Desc="Set hover dwell time to 0ms (instant)." }
        "MouseTrails"             = @{ Path=$MHK; Name="MouseTrails";         Type="String"; Value="0";   Desc="Disable cursor trails to reduce visual overhead." }
        "MouseDelay"              = @{ Path=$MHK; Name="MouseDelay";          Type="String"; Value="0";   Desc="Remove initial delay before click auto-repeat." }
        "MouseAccel"              = @{ Path=$MHK; Name="MouseAccel";          Type="String"; Value="0";   Desc="Disable hardware-level mouse acceleration." }
        "DoubleClickSpeed"        = @{ Path=$MHK; Name="DoubleClickSpeed";    Type="String"; Value="200"; Desc="Double-click window 200ms (tighter response)." }
        "SwapMouseButtons"        = @{ Path=$MHK; Name="SwapMouseButtons";    Type="String"; Value="0";   Desc="Keep standard primary / secondary button layout." }
        "SnapToDefaultButton"     = @{ Path=$MHK; Name="SnapToDefaultButton"; Type="String"; Value="0";   Desc="Disable cursor snap to default dialog button." }
        "ActiveWindowTracking"    = @{ Path=$MHK; Name="ActiveWindowTracking";Type="DWord";  Value=0;     Desc="Disable automatic window focus on cursor hover." }
        "Beep"                    = @{ Path=$MHK; Name="Beep";                Type="String"; Value="No";  Desc="Disable mouse-triggered beep sounds." }
        "ExtendedSounds"          = @{ Path=$MHK; Name="ExtendedSounds";      Type="String"; Value="No";  Desc="Disable extended mouse event sounds." }
        "SmoothMouseXCurve"       = @{ Path=$MHK; Name="SmoothMouseXCurve";   Type="String"; Value="000000000000000000000000000000000000000000000000"; Desc="Flat X-axis curve / no horizontal acceleration." }
        "SmoothMouseYCurve"       = @{ Path=$MHK; Name="SmoothMouseYCurve";   Type="String"; Value="000000000000000000000000000000000000000000000000"; Desc="Flat Y-axis curve / no vertical acceleration." }
        "AttractionRectInset"     = @{ Path=$MAG; Name="AttractionRectInsetInDIPS";             Type="DWord"; Value=0; Desc="Disable magnetism attraction zone (UI elems)." }
        "DistanceThreshold"       = @{ Path=$MAG; Name="DistanceThresholdInDIPS";               Type="DWord"; Value=0; Desc="Set magnetism trigger distance to zero." }
        "MagnetismDelay"          = @{ Path=$MAG; Name="MagnetismDelayInMilliseconds";          Type="DWord"; Value=1; Desc="Reduce cursor magnetism delay to 1ms minimum." }
        "MagnetismUpdateInterval" = @{ Path=$MAG; Name="MagnetismUpdateIntervalInMilliseconds"; Type="DWord"; Value=1; Desc="Reduce magnetism recalculation interval to 1ms." }
        "MagnetismVelocity"       = @{ Path=$MAG; Name="VelocityInDIPSPerSecond";               Type="DWord"; Value=0; Desc="Disable magnetism velocity / no attraction." }
        "PollStatusIterations"    = @{ Path="HKLM:\SYSTEM\CurrentControlSet\Services\i8042prt\Parameters"; Name="PollStatusIterations"; Type="DWord"; Value=1; Desc="Set PS/2 poll iterations to 1 (min latency)." }

    }
    "2. CursorUpdateInterval" = [ordered]@{
        "CursorUpdateInterval"    = @{ Path=$MOU; Name="CursorUpdateInterval";           Type="DWord"; Value=0;  Desc="Force max cursor update rate (0=fastest, raise if unstable)." }
    }
    "3. HID Pointer Mode Tweaks" = [ordered]@{
        "TreatAbsoluteAsAbsolute" = @{ Path=$MOU; Name="TreatAbsolutePointerAsAbsolute"; Type="DWord"; Value=1;  Desc="Treat absolute HID pointers as absolute (tablets, touch)." }
        "TreatAbsoluteAsRelative" = @{ Path=$MOU; Name="TreatAbsoluteAsRelative";        Type="DWord"; Value=0;  Desc="Prevent absolute-to-relative conversion / avoids jumps." }
    }
    "4. Class Transmit Timeout" = [ordered]@{
        "MouseTransmitTimeout"    = @{ Path=$MCL; Name="MouseTransmitTimeout"; Type="DWord"; Value=0;  Desc="Remove mouclass.sys send delay." }
    }
    "5. Class Thread Priority" = [ordered]@{
        "ThreadPriority"          = @{ Path=$MCL; Name="ThreadPriority";       Type="DWord"; Value=31; Desc="Set mouclass.sys thread to kernel priority 31 Realtime." }
    }
    "6. Data Queue Size" = [ordered]@{
        "MouseDataQueueSize"      = @{ Path=$MCL; Name="MouseDataQueueSize";    Type="DWord"; Value=16; Desc="Input buffer lowest latency (recommended: 16)." }
    }
}

$AllTweaks=[ordered]@{}
foreach($cat in $TweakCategories.Keys){foreach($key in $TweakCategories[$cat].Keys){
    if(-not $AllTweaks.Contains($key)){$AllTweaks[$key]=$TweakCategories[$cat][$key]}}}

$BackupDir      = Join-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) "MouseOptimizer_Backups"
$Script:RichBox = $null; $Script:Opaque = $true

# --- UI factory helpers ---
function NP($x,$y,$w,$h,$bg)        { $p=New-Object System.Windows.Forms.Panel;  $p.Location=New-Object System.Drawing.Point($x,$y); $p.Size=New-Object System.Drawing.Size($w,$h); $p.BackColor=$bg; return $p }
function NL($txt,$x,$y,$w,$h,$fc,$fnt) { $l=New-Object System.Windows.Forms.Label; $l.Text=$txt; $l.Location=New-Object System.Drawing.Point($x,$y); $l.Size=New-Object System.Drawing.Size($w,$h); $l.ForeColor=$fc; $l.Font=$fnt; $l.BackColor=[System.Drawing.Color]::Transparent; return $l }
$F7  = New-Object System.Drawing.Font("Consolas",7)
$F7B = New-Object System.Drawing.Font("Consolas",7, [System.Drawing.FontStyle]::Bold)
$F8B = New-Object System.Drawing.Font("Consolas",8, [System.Drawing.FontStyle]::Bold)
$F9B = New-Object System.Drawing.Font("Consolas",9, [System.Drawing.FontStyle]::Bold)
function Make-Dot($col,$x,$action) {
    $d=NP $x 10 13 13 $col; $d.Cursor=[System.Windows.Forms.Cursors]::Hand
    $d.Add_Paint({param($s,$e);$e.Graphics.SmoothingMode=2;$b=New-Object System.Drawing.SolidBrush($s.BackColor);$e.Graphics.FillEllipse($b,0,0,$s.Width-1,$s.Height-1);$b.Dispose()})
    $d.Add_Click($action); return $d }

# --- Console helpers ---
function wc { param([string]$t,[System.Drawing.Color]$c,[bool]$nl=$true)
    $Script:RichBox.SelectionStart=$Script:RichBox.TextLength; $Script:RichBox.SelectionLength=0
    $Script:RichBox.SelectionColor=$c
    if($nl){$Script:RichBox.AppendText("$t`r`n")}else{$Script:RichBox.AppendText($t)}
    $Script:RichBox.ScrollToCaret(); $Script:RichBox.Refresh() }
function wBlk  { wc "" $CGray }
function wSep  { wc ("=" * 90) $CDim }
function wTitle{ param($m) wBlk; wc "  $m" $CWhite; wBlk }
function wInfo { param($m) wc "  $m" $CGray }
function wOK   { param($m) wc "  $m" $CGreen }
function wWarn { param($m) wc "  $m" $CYellow }
function wErr  { param($m) wc "  $m" $CRed }

function Write-Description {
    wBlk; wc "  About" $CWhite; wBlk
    wc "  For personal use only. Modifying, copying, or redistributing this script is prohibited." $CRed
    wc "  This script must be downloaded only from: https://github.com/insovs/Mouse-Optimization" $CGray; wBlk
    wc "  Mouse Optimization is a PowerShell GUI tool that applies targeted registry tweaks" $CGray
    wc "  to eliminate every layer of software interference between your mouse and your Windows." $CGray
    wc "  It removes acceleration, buffering, HID processing delays and cursor smoothing imposed" $CGray
    wc "  by Windows. Forces raw, linear and immediate input at the driver level." $CGray; wBlk
    wc "  Built for competitive players who demand precision and consistency on every movement." $CGray; wBlk
    wc "  A backup is created automatically before any modification." $CDim
    wc "  It can be restored at any time via Revert Optimization." $CDim
    wc "  Results may vary. Test each tweak independently if instability occurs." $CDim; wBlk
    wc "  For more information, consult the 'Read.me' in the directory." $CDim; wBlk
    wBlk
}

function New-Backup {
    $out=Join-Path $BackupDir "Backup_$(Get-Date -Format 'yyyy-MM-dd_HH-mm-ss').reg"
    if(-not(Test-Path $BackupDir)){New-Item -ItemType Directory -Path $BackupDir -Force|Out-Null}

    $psPaths=[System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
    foreach($key in $AllTweaks.Keys){ [void]$psPaths.Add($AllTweaks[$key].Path) }

    $lines=[System.Collections.Generic.List[string]]::new()
    $lines.Add("Windows Registry Editor Version 5.00")
    $lines.Add("")

    foreach($psPath in $psPaths){
        if(-not(Test-Path $psPath -EA SilentlyContinue)){continue}
        $regPath=$psPath -replace "HKLM:\\","HKEY_LOCAL_MACHINE\" -replace "HKCU:\\","HKEY_CURRENT_USER\"
        $lines.Add("[$regPath]")
        $props=Get-ItemProperty -Path $psPath -EA SilentlyContinue
        if($props){
            $props.PSObject.Properties | Where-Object{$_.Name -notmatch "^PS"} | ForEach-Object{
                $name=$_.Name; $val=$_.Value
                try{
                    $kind=(Get-Item $psPath).GetValueKind($name)
                    switch($kind){
                        "DWord"       { $lines.Add('"' + $name + '"=dword:' + $val.ToString('x8')) }
                        "QWord"       { $lines.Add('"' + $name + '"=qword:' + $val.ToString('x16')) }
                        "String"      { $safe=$val -replace '\\','\\\\'; $lines.Add('"' + $name + '"="' + $safe + '"') }
                        "ExpandString"{ $b=[System.Text.Encoding]::Unicode.GetBytes($val+[char]0); $h=($b|ForEach-Object{$_.ToString('x2')}) -join ','; $lines.Add('"' + $name + '"=hex(2):' + $h) }
                        "MultiString" { $j=($val -join [char]0)+[char]0+[char]0; $b=[System.Text.Encoding]::Unicode.GetBytes($j); $h=($b|ForEach-Object{$_.ToString('x2')}) -join ','; $lines.Add('"' + $name + '"=hex(7):' + $h) }
                        "Binary"      { $h=($val|ForEach-Object{$_.ToString('x2')}) -join ','; $lines.Add('"' + $name + '"=hex:' + $h) }
                        default       { $lines.Add('"' + $name + '"="' + $val + '"') }
                    }
                } catch{}
            }
        }
        $lines.Add("")
    }
    $lines | Out-File -FilePath $out -Encoding Unicode -Force
    return $out
}

# --- OPEN REGISTRY KEY HELPER ---
function Open-RegistryKey {
    param([string]$PsPath)
    $regPath = $PsPath -replace "HKLM:\\","HKEY_LOCAL_MACHINE\" -replace "HKCU:\\","HKEY_CURRENT_USER\" -replace "HKCR:\\","HKEY_CLASSES_ROOT\"
    try {
        Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Applets\Regedit" -Name "LastKey" -Value $regPath -Force -EA Stop
    } catch {}
    Start-Process "regedit.exe"
}

# ===================================================================
# POPUP for a single category
# ===================================================================
function Show-CatPopup {
    param([string]$CatName)
    $tweaks=$TweakCategories[$CatName]
    $col=if($CatColors[$CatName]){$CatColors[$CatName]}else{$CBlue}

    $dlg=New-Object System.Windows.Forms.Form
    $dlg.Size=New-Object System.Drawing.Size(720,580); $dlg.StartPosition="CenterScreen"
    $dlg.BackColor=$SidebarBG; $dlg.ForeColor=$TextWhite; $dlg.FormBorderStyle="None"; $dlg.TopMost=$true
    $dragDlg={if($_.Button-eq[System.Windows.Forms.MouseButtons]::Left){[Win32]::ReleaseCapture()|Out-Null;[Win32]::SendMessage($dlg.Handle,0xA1,0x2,0)|Out-Null}}
    $dlg.Add_MouseDown($dragDlg)

    # Title bar
    $bar=NP 0 0 720 36 (RGB 10 10 10); $bar.Add_MouseDown($dragDlg)
    $bar.Controls.Add((NL "Mouse Optimization | Check to apply / Uncheck to skip." 12 10 580 16 $TextMuted $F7))
    $btnX=NP 695 12 13 13 $DotRed; $btnX.Cursor=[System.Windows.Forms.Cursors]::Hand
    $btnX.Add_Paint({param($s,$e);$e.Graphics.SmoothingMode=2;$b=New-Object System.Drawing.SolidBrush($s.BackColor);$e.Graphics.FillEllipse($b,0,0,$s.Width-1,$s.Height-1);$b.Dispose()})
    $btnX.Add_Click({$dlg.DialogResult=[System.Windows.Forms.DialogResult]::Cancel;$dlg.Close()})
    $bar.Controls.Add($btnX); $dlg.Controls.Add($bar)

    # Header band
    $hdrBand=NP 0 36 720 82 (RGB 14 14 14); $hdrBand.Controls.Add((NP 0 0 4 82 $col))
    $hdrBand.Controls.Add((NL ($CatName -replace "^(\d+)\.\s*(.+)$",'$1. [$2]') 14 8 700 22 $col (New-Object System.Drawing.Font("Consolas",11,[System.Drawing.FontStyle]::Bold))))
    $subLbl = New-Object System.Windows.Forms.Label
    $subLbl.Text      = if($CatSubDescs[$CatName]){$CatSubDescs[$CatName]}else{"Uncheck tweaks to skip."}
    $subLbl.Location  = New-Object System.Drawing.Point(14,34)
    $subLbl.Size      = New-Object System.Drawing.Size(698,40)
    $subLbl.ForeColor = $TextMuted
    $subLbl.BackColor = RGB 14 14 14
    $subLbl.Font      = New-Object System.Drawing.Font("Consolas",7)
    $subLbl.AutoSize  = $false
    $hdrBand.Controls.Add($subLbl)
    $dlg.Controls.Add($hdrBand)

    # Column header
    $colBar=NP 0 118 720 22 (RGB 10 10 10)
    $colBar.Controls.AddRange(@((NP 0 21 720 1 $SideEdgeC),(NL "  Tweak Name" 32 4 224 14 $TextDim $F7B),(NL "  Description" 262 4 440 14 $TextDim $F7B)))
    $dlg.Controls.Add($colBar)

    # Scroll area
    $scrollOuter=NP 12 142 694 354 $BG; $scrollOuter.BorderStyle="None"
    $scroll=NP 0 0 674 100 $BG
    $vbar=New-Object System.Windows.Forms.VScrollBar
    $vbar.Location=New-Object System.Drawing.Point(677,0); $vbar.Size=New-Object System.Drawing.Size(17,354)
    $vbar.Minimum=0; $vbar.Maximum=1000; $vbar.SmallChange=30; $vbar.LargeChange=100; $vbar.BackColor=RGB 20 20 20
    $vbar.Add_Scroll({$scroll.Top=-$vbar.Value})
    $scrollOuter.Add_MouseWheel({
        $v=[Math]::Max($vbar.Minimum,[Math]::Min($vbar.Maximum-$vbar.LargeChange,$vbar.Value-[int]($_.Delta/120*30)))
        $vbar.Value=$v; $scroll.Top=-$v })
    $scrollOuter.Controls.AddRange(@($scroll,$vbar)); $dlg.Controls.Add($scrollOuter)

    # Tweak rows
    $checks=[ordered]@{}; $spinners=[ordered]@{}; $yPos=0; $rowIdx=0
    $tip = New-Object System.Windows.Forms.ToolTip
    $tip.InitialDelay = 400; $tip.ReshowDelay = 200; $tip.AutoPopDelay = 8000
    $tip.BackColor = RGB 22 24 28; $tip.ForeColor = $CWhite; $tip.IsBalloon = $false
    foreach($key in $tweaks.Keys){
        $tw=$tweaks[$key]; $rowBG=if($rowIdx%2-eq 0){RGB 13 13 13}else{RGB 18 18 20}
        $row=NP 0 $yPos 692 28 $rowBG

        $chk=New-Object System.Windows.Forms.CheckBox
        $chk.Location=New-Object System.Drawing.Point(10,6); $chk.Size=New-Object System.Drawing.Size(16,16)
        $chk.Checked=$true; $chk.BackColor=[System.Drawing.Color]::Transparent; $chk.FlatStyle="Standard"
        $checks[$key]=$chk

        # Clickable key name label - opens registry location
        $nameLbl=New-Object System.Windows.Forms.Label
        $nameLbl.Text=$key; $nameLbl.Location=New-Object System.Drawing.Point(32,7)
        $nameLbl.Size=New-Object System.Drawing.Size(220,14); $nameLbl.ForeColor=$CWhite
        $nameLbl.Font=$F8B; $nameLbl.BackColor=[System.Drawing.Color]::Transparent
        $nameLbl.Cursor=[System.Windows.Forms.Cursors]::Hand
        $twPath=$tw.Path; $twName=$tw.Name; $twVal=$tw.Value; $twType=$tw.Type
        $curVal = $null
        if (Test-Path $twPath -EA SilentlyContinue) {
            $curVal = (Get-ItemProperty -Path $twPath -Name $twName -EA SilentlyContinue).$twName
        }
        $isOpt = $false
        if ($null -ne $curVal) {
            $isOpt = switch ($twType) {
                "DWord"  { [int64][uint32]$curVal -eq [int64]$twVal }
                "String" { $curVal -eq $twVal }
                "Binary" { ($curVal -join ',') -eq (([byte[]]$tw.Value) -join ',') }
                default  { $false }
            }
        }
        $optTag   = if ($isOpt) { "  (already optimized)" } else { "" }
        $dispVal  = if ($null -ne $curVal) { "$curVal" } else { "not found" }
        $tipText  = "Path         : $twPath`nName         : $twName`nActual value : $dispVal$optTag`n`nClick to open in Registry Editor"
        $tip.SetToolTip($nameLbl, $tipText)
        $nameLbl.Add_Click([scriptblock]::Create("Open-RegistryKey -PsPath '$twPath'"))
        $nameLbl.Add_MouseEnter({$this.ForeColor=RGB 140 200 255})
        $nameLbl.Add_MouseLeave({$this.ForeColor=$CWhite})

        $sep=NP 256 5 1 18 (RGB 45 45 48)

        $spinnerKeys = @{
            "CursorUpdateInterval"  = @{ Min=0;  Max=5;   Default=0;  ShortDesc="Max cursor update rate  (0 = fastest,  raise if unstable)" }
            "MouseDataQueueSize"    = @{ Min=16; Max=100; Default=16; ShortDesc="Input data buffer size (recommended value = '16')" }
        }
        if($spinnerKeys.ContainsKey($key)){
            $sk=$spinnerKeys[$key]
            $descLbl=NL $sk.ShortDesc 262 7 320 14 $CGray $F7
            $lv=NL "Value" 586 8 34 12 $TextDim $F7
            $spBorder=NP 622 4 38 20 $BtnBorder
            $sp=New-Object System.Windows.Forms.NumericUpDown
            $sp.Location=New-Object System.Drawing.Point(1,1); $sp.Size=New-Object System.Drawing.Size(36,18)
            $sp.Minimum=$sk.Min; $sp.Maximum=$sk.Max; $sp.Value=$sk.Default
            $sp.BackColor=RGB 22 22 22; $sp.ForeColor=$CGreen
            $sp.Font=$F8B; $sp.BorderStyle="None"; $sp.TextAlign="Center"
            $spBorder.Controls.Add($sp); $spinners[$key]=$sp
            $row.Controls.AddRange(@($chk,$nameLbl,$sep,$descLbl,$lv,$spBorder))
        } else {
            $descLbl=NL $tw.Desc 262 7 426 14 $CGray $F7
            $row.Controls.AddRange(@($chk,$nameLbl,$sep,$descLbl))
        }

        $row.Controls.Add((NP 0 27 692 1 (RGB 22 22 24)))
        $rP=$row; $rBG2=$rowBG
        $rIn={$rP.BackColor=RGB 20 24 32}.GetNewClosure(); $rOut={$rP.BackColor=$rBG2}.GetNewClosure()
        foreach($ctrl in @($row,$nameLbl,$descLbl)){$ctrl.Add_MouseEnter($rIn);$ctrl.Add_MouseLeave($rOut)}
        $scroll.Controls.Add($row); $yPos+=28; $rowIdx++
    }

    $scroll.Height=$yPos+12
    if($scroll.Height -le $scrollOuter.Height){$vbar.Visible=$false;$scroll.Width=692}
    else{$vbar.Visible=$true;$vbar.Maximum=$scroll.Height-$scrollOuter.Height+$vbar.LargeChange}

    function MkBtn($txt,$x,$w,$fc){
        $b=New-Object System.Windows.Forms.Button; $b.Text=$txt
        $b.Location=New-Object System.Drawing.Point($x,512); $b.Size=New-Object System.Drawing.Size($w,28)
        $b.BackColor=$BtnNormal; $b.ForeColor=$fc; $b.FlatStyle="Flat"; $b.FlatAppearance.BorderColor=$BtnBorder; $b.Font=$F8B
        return $b}
    $bApply=MkBtn "Apply" 12 110 $CGreen;       $bApply.DialogResult=[System.Windows.Forms.DialogResult]::OK
    $bCancel=MkBtn "Cancel" 130 110 $TextMuted; $bCancel.DialogResult=[System.Windows.Forms.DialogResult]::Cancel
    $bAll=MkBtn "Select All" 480 110 $TextMuted; $bNone=MkBtn "Select None" 598 110 $TextMuted
    $capChecks=$checks; $capSpinners=$spinners
    $bAll.Add_Click({ foreach($c in $capChecks.Values){$c.Checked=$true; $c.Enabled=$true; $c.ForeColor=$CGray; $c.Refresh()} })
    $bNone.Add_Click({foreach($c in $capChecks.Values){$c.Checked=$false;$c.Enabled=$false;$c.ForeColor=RGB 38 38 42;$c.Refresh()} })
    $dlg.Controls.AddRange(@($bApply,$bCancel,$bAll,$bNone)); $dlg.AcceptButton=$bApply; $dlg.CancelButton=$bCancel

    if($dlg.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK){return $null}

    $selected=[ordered]@{}
    foreach($k in $capChecks.Keys){
        if($capChecks[$k].Checked){
            $tw=$TweakCategories[$CatName][$k]
            if($capSpinners.ContainsKey($k)){
                $tw=@{Path=$tw.Path;Name=$tw.Name;Type=$tw.Type;Value=[int]$capSpinners[$k].Value;Desc=$tw.Desc}
            }
            $selected[$k]=$tw
        }
    }
    return $selected
}

# --- APPLY ---
function Do-ApplyCat {
    param([string]$CatName)
    $selected=Show-CatPopup -CatName $CatName
    if($null -eq $selected -or $selected.Count -eq 0){return}
    $Script:RichBox.Clear(); Write-Description

    wSep
    wc "  APPLY  >>  $($CatName -replace '^\d+\.\s*','')" $CWhite
    wSep; wBlk

    wc "  backup    " $CDim $false; wc "creating..." $CGray
    try{
        $bf=New-Backup
        $bdir=[System.IO.Path]::GetDirectoryName($bf)
        $bname=[System.IO.Path]::GetFileName($bf)
        wc "  backup    " $CDim $false; wc "OK" $CGreen
        wc "  location  " $CDim $false; wc $bdir $CGray
        wc "  file      " $CDim $false; wc $bname $CWhite
    }
    catch{ wc "  backup    " $CDim $false; wc "FAILED  " $CRed $false; wc "$_" $CRed; return }

    $wK=26; $wS=9; $wD=49
    $sep2="  "+("-"*$wK)+"  "+("-"*$wS)+"  "+("-"*$wD)

    wBlk
    wc $sep2 $CDim
    wc ("  "+"Tweak".PadRight($wK)+"  "+"Status".PadRight($wS)+"  "+"Description") $TextDim
    wc $sep2 $CDim
    wBlk

    $ok=0; $fa=0
    foreach($key in $selected.Keys){
        $tw=$selected[$key]
        $kpad="  "+$key.PadRight($wK)+"  "
        try{
            if(-not(Test-Path $tw.Path)){New-Item -Path $tw.Path -Force|Out-Null}
            switch($tw.Type){
                "DWord" {Set-ItemProperty -Path $tw.Path -Name $tw.Name -Value ([uint32]$tw.Value) -Type DWord  -Force -EA Stop}
                "String"{Set-ItemProperty -Path $tw.Path -Name $tw.Name -Value $tw.Value            -Type String -Force -EA Stop}
                "Binary"{Set-ItemProperty -Path $tw.Path -Name $tw.Name -Value ([byte[]]$tw.Value)  -Type Binary -Force -EA Stop}
            }
            $sd=if($tw.Desc.Length-gt $wD){$tw.Desc.Substring(0,$wD-3)+"..."}else{$tw.Desc}
            wc $kpad $CWhite $false
            wc ("applied".PadRight($wS)+"  ") $CGreen $false
            wc $sd $CGray
            $ok++
        } catch{
            $em=if($_.Exception.Message.Length-gt $wD){$_.Exception.Message.Substring(0,$wD-3)+"..."}else{$_.Exception.Message}
            wc $kpad $CWhite $false
            wc ("failed".PadRight($wS)+"  ") $CRed $false
            wc $em $CRed
            $fa++
        }
        [System.Windows.Forms.Application]::DoEvents()
    }

    wBlk
    wc $sep2 $CDim
    wBlk
    if($fa -eq 0){
        wc "  $ok / $($ok+$fa) tweaks applied successfully." $CGreen
    } else {
        wc "  $ok applied  --  $fa failed." $CYellow
    }
    wBlk
    wc "  Reboot recommended to apply all changes." $CYellow
    wBlk; wSep
}

# --- REVERT ---
function Do-Revert {
    $Script:RichBox.Clear(); Write-Description; wTitle "Revert Optimization"
    if(-not(Test-Path $BackupDir)){wErr "No backup folder found."; return}
    $bfiles=Get-ChildItem -Path $BackupDir -Filter "*.reg"|Sort-Object LastWriteTime -Descending
    if($bfiles.Count -eq 0){wErr "No backup files found."; return}
    wInfo "Available backups"; wBlk; $i=1
    foreach($b in $bfiles){
        $age=(Get-Date)-$b.LastWriteTime
        $as=if($age.TotalMinutes-lt 60){"$([int]$age.TotalMinutes)m ago"}elseif($age.TotalHours-lt 24){"$([int]$age.TotalHours)h ago"}else{"$([int]$age.TotalDays)d ago"}
        wc "  [$i]  " $TextMuted $false; wc "$($b.Name.PadRight(48))" $CWhite $false; wc $as $CGray; $i++
    }
    wBlk
    $dlg=New-Object System.Windows.Forms.Form; $dlg.Text="Select Backup"
    $dlg.Size=New-Object System.Drawing.Size(500,165); $dlg.StartPosition="CenterParent"
    $dlg.BackColor=$SidebarBG; $dlg.ForeColor=$TextWhite; $dlg.FormBorderStyle="FixedDialog"; $dlg.MaximizeBox=$false; $dlg.MinimizeBox=$false
    $lbl=NL "Select a backup to restore:" 16 16 460 18 $TextHead (New-Object System.Drawing.Font("Consolas",9,[System.Drawing.FontStyle]::Bold))
    $cb=New-Object System.Windows.Forms.ComboBox; $cb.Location=New-Object System.Drawing.Point(16,42)
    $cb.Size=New-Object System.Drawing.Size(462,24); $cb.BackColor=$BtnNormal; $cb.ForeColor=$TextWhite
    $cb.Font=New-Object System.Drawing.Font("Consolas",9); $cb.DropDownStyle="DropDownList"
    foreach($b in $bfiles){$cb.Items.Add($b.Name)|Out-Null}; $cb.SelectedIndex=0
    $bOK=New-Object System.Windows.Forms.Button; $bOK.Text="Restore"
    $bOK.Location=New-Object System.Drawing.Point(16,80); $bOK.Size=New-Object System.Drawing.Size(100,28)
    $bOK.BackColor=$BtnNormal; $bOK.ForeColor=$CGreen; $bOK.FlatStyle="Flat"
    $bOK.FlatAppearance.BorderColor=$BtnBorder; $bOK.Font=$F9B; $bOK.DialogResult=[System.Windows.Forms.DialogResult]::OK
    $bCx=New-Object System.Windows.Forms.Button; $bCx.Text="Cancel"
    $bCx.Location=New-Object System.Drawing.Point(124,80); $bCx.Size=New-Object System.Drawing.Size(100,28)
    $bCx.BackColor=$BtnNormal; $bCx.ForeColor=$TextMuted; $bCx.FlatStyle="Flat"
    $bCx.FlatAppearance.BorderColor=$BtnBorder; $bCx.Font=New-Object System.Drawing.Font("Consolas",9); $bCx.DialogResult=[System.Windows.Forms.DialogResult]::Cancel
    $dlg.Controls.AddRange(@($lbl,$cb,$bOK,$bCx)); $dlg.AcceptButton=$bOK; $dlg.CancelButton=$bCx
    if($dlg.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK){wWarn "Cancelled."; return}
    $sel=$bfiles[$cb.SelectedIndex].FullName; wInfo "Restoring  $($bfiles[$cb.SelectedIndex].Name)"
    $res=Start-Process "regedit.exe" -ArgumentList "/s `"$sel`"" -Wait -PassThru; wBlk
    if($res.ExitCode -eq 0){wOK "Registry restored successfully."; wBlk; wWarn "Reboot recommended."}
    else{wErr "regedit exited with code $($res.ExitCode)."}; wSep
}

# ===================================================================
# LIST  -  aligned columns
# ===================================================================
function Do-List {
    $Script:RichBox.Clear(); Write-Description; wTitle "Tweak Status"
    $wN=28; $wS=11
    wc "  $("Tweak".PadRight($wN))  $("Status".PadRight($wS))  Description" $CDim
    wc "  $("-"*$wN)  $("-"*$wS)  $("-"*46)" $CDim
    foreach($cat in $TweakCategories.Keys){
        wBlk; wc "  $($cat -replace '^(\d+)\.\s*(.+)$','$1. [$2]')" $CBlue
        foreach($key in $TweakCategories[$cat].Keys){
            $tw=$TweakCategories[$cat][$key]
            $exists=Test-Path $tw.Path
            $cur=if($exists){(Get-ItemProperty -Path $tw.Path -Name $tw.Name -EA SilentlyContinue).$($tw.Name)}else{$null}
            $ok=$false
            if($null -ne $cur){switch($tw.Type){
                "DWord" {$ok=([int64][uint32]$cur -eq [int64]$tw.Value)}
                "String"{$ok=($cur -eq $tw.Value)}
                "Binary"{$ok=(($cur-join',')-eq(([byte[]]$tw.Value)-join','))}
            }}
            $status=if(-not $exists -or $null -eq $cur){"not found"}elseif($ok){"applied"}else{"default"}
            $sc    =if(-not $exists -or $null -eq $cur){$CDim}elseif($ok){$CGreen}else{$CYellow}
            $sd    =if($tw.Desc.Length-gt 46){$tw.Desc.Substring(0,43)+"..."}else{$tw.Desc}
            wc "  $($key.PadRight($wN))  " $CWhite $false
            wc "$($status.PadRight($wS))  " $sc $false
            wc $sd $CGray
            [System.Windows.Forms.Application]::DoEvents()
        }
    }
    wBlk; wSep; wc "  $($AllTweaks.Count) tweaks total." $CDim; wSep
}

# --- MAIN FORM ---
$Form=New-Object System.Windows.Forms.Form
$Form.Text="Mouse Optimization"; $Form.Size=New-Object System.Drawing.Size(1020,740); $Form.MinimumSize=New-Object System.Drawing.Size(900,620)
$Form.StartPosition="CenterScreen"; $Form.BackColor=$BG; $Form.ForeColor=$TextWhite; $Form.FormBorderStyle="None"

$TitleBar=NP 0 0 980 32 (RGB 10 10 10); $TitleBar.Anchor="Top,Left,Right"
$TitleBar.Add_MouseDown({if($_.Button-eq[System.Windows.Forms.MouseButtons]::Left){[Win32]::ReleaseCapture()|Out-Null;[Win32]::SendMessage($Form.Handle,0xA1,0x2,0)|Out-Null}})

$DotClose=Make-Dot $DotRed    780 { $Form.Close() }
$DotMin  =Make-Dot $DotOrange 800 { $Form.WindowState="Minimized" }
$DotMax  =Make-Dot $DotWhite  820 { if($Form.WindowState-eq"Maximized"){$Form.WindowState="Normal"}else{$Form.WindowState="Maximized"} }
$OpacBtn=New-Object System.Windows.Forms.Button; $OpacBtn.Text="Opacity  ON / OFF"
$OpacBtn.Size=New-Object System.Drawing.Size(128,22); $OpacBtn.Location=New-Object System.Drawing.Point(844,5)
$OpacBtn.BackColor=$BtnNormal; $OpacBtn.ForeColor=$TextMuted; $OpacBtn.FlatStyle="Flat"
$OpacBtn.FlatAppearance.BorderColor=$BtnBorder; $OpacBtn.Font=$F7; $OpacBtn.Cursor=[System.Windows.Forms.Cursors]::Hand
$TitleBar.Controls.AddRange(@($DotClose,$DotMin,$DotMax,$OpacBtn)); $Form.Controls.Add($TitleBar)

# Sidebar
$Sidebar =NP 0   32 260 708 $SidebarBG; $Sidebar.Anchor="Top,Left,Bottom"
$SideEdge=NP 259 32 1   708 $SideEdgeC; $SideEdge.Anchor="Top,Left,Bottom"

$LogoPanel=NP 0 0 259 106 $LogoBG
$TitleLbl=NL "MOUSE`r`nOPTIMIZATION" 0 16 259 54 $TextHead (New-Object System.Drawing.Font("Consolas",13,[System.Drawing.FontStyle]::Bold))
$TitleLbl.TextAlign="MiddleCenter"
$GHLbl=NL "github.com/insovs" 0 72 259 20 $TextMuted (New-Object System.Drawing.Font("Consolas",8))
$GHLbl.TextAlign="MiddleCenter"; $GHLbl.Cursor=[System.Windows.Forms.Cursors]::Hand
$GHLbl.Add_Click({[System.Diagnostics.Process]::Start("https://github.com/insovs")})
$GHLbl.Add_MouseEnter({$GHLbl.ForeColor=$TextWhite}); $GHLbl.Add_MouseLeave({$GHLbl.ForeColor=$TextMuted})
$LogoPanel.Controls.AddRange(@($TitleLbl,$GHLbl))
$Sidebar.Controls.AddRange(@($LogoPanel,(NP 0 105 259 1 $SideEdgeC),(NP 0 106 259 1 $SideEdgeC),(NL "MAIN MENU" 16 118 220 13 $TextDim $F7B)))

$CatColors = @{
    "1. Main Registry Tweaks"        = $CGreen
    "2. CursorUpdateInterval"        = $CBlue
    "3. HID Pointer Mode Tweaks"     = $CYellow
    "4. Class Transmit Timeout"      = RGB 200 100 80
    "5. Class Thread Priority"       = RGB 140 100 200
    "6. Data Queue Size"             = RGB 80 180 160
}
$CatDescs = @{
    "1. Main Registry Tweaks"        = "    Core tweaks: accel off, linear input.."
    "2. CursorUpdateInterval"        = "    Force max cursor update rate."
    "3. HID Pointer Mode Tweaks"     = "    Fix absolute / relative HID pointer."
    "4. Class Transmit Timeout"      = "    Remove mouclass.sys send delay."
    "5. Class Thread Priority"       = "    Set mouclass.sys to max kernel priority."
    "6. Data Queue Size"             = "    Input data buffer optimization."
}
$CatSubDescs = @{
    "1. Main Registry Tweaks"        = "Applies core registry tweaks: disables acceleration, removes processing layers, forces linear input.`nUncheck any tweak to skip it."
    "2. CursorUpdateInterval"        = "Lowers CursorUpdateInterval to reduce cursor update delay. Default is 5. Start at 0 (max/lowest latency).`nIncrease if instability occurs. Test independently."
    "3. HID Pointer Mode Tweaks"     = "Forces correct HID pointer mode: absolute stays absolute, relative stays relative. Prevents cursor jumps and driver-level conversion artifacts."
    "4. Class Transmit Timeout"      = "Sets MouseTransmitTimeout=0 on mouclass.sys to suppress the internal send delay. Input events forwarded immediately."
    "5. Class Thread Priority"       = "Sets mouclass.sys thread priority to 31 (kernel max). Mouse interrupts are processed before most system threads.`nReduces jitter under load."
    "6. Data Queue Size"             = "Sets MouseDataQueueSize to 16 for lowest input latency. Value 16 is recommended / do NOT go below.`nOn older or unstable systems, use 18-24 if issues occur. Raise by 1-2 if mouse skips or freezes."
}

# Category buttons
$yBtn=134
foreach($cat in $TweakCategories.Keys){
    $col=if($CatColors[$cat]){$CatColors[$cat]}else{$CBlue}
    $p=NP 12 $yBtn 236 46 $BtnNormal; $p.Cursor=[System.Windows.Forms.Cursors]::Hand
    $strip=NP 0 0 2 46 $col
    $num  =NL (($cat -replace "^(\d+)\..*",'$1')+".") 10 6 20 14 $col $F8B
    $lbl  =NL ($cat -replace "^\d+\.\s*","")           30 6 198 14 $TextWhite $F8B
    $desc2=New-Object System.Windows.Forms.Label
    $desc2.Text         = if($CatDescs[$cat]){$CatDescs[$cat]}else{""}
    $desc2.Location     = New-Object System.Drawing.Point(10,24)
    $desc2.Size         = New-Object System.Drawing.Size(222,14)
    $desc2.ForeColor    = $TextMuted
    $desc2.BackColor    = $BtnNormal
    $desc2.Font         = New-Object System.Drawing.Font("Consolas",6.5)
    $desc2.AutoEllipsis = $true
    $p.Controls.AddRange(@($strip,$num,$lbl,$desc2))
    $xP=$p;$xS=$strip;$xL=$lbl;$xC=$col;$xD=$desc2
    $hIn ={$xP.BackColor=$BtnHover; $xD.BackColor=$BtnHover; $xS.BackColor=$BtnBorderH;$xL.ForeColor=$TextHead }.GetNewClosure()
    $hOut={$xP.BackColor=$BtnNormal;$xD.BackColor=$BtnNormal;$xS.BackColor=$xC;        $xL.ForeColor=$TextWhite}.GetNewClosure()
    $thisCat=$cat; $clickHandler=[scriptblock]::Create("Do-ApplyCat -CatName '$thisCat'")
    foreach($ctrl in @($p,$strip,$num,$lbl,$desc2)){$ctrl.Add_MouseEnter($hIn);$ctrl.Add_MouseLeave($hOut);$ctrl.Add_Click($clickHandler)}
    $Sidebar.Controls.Add($p); $yBtn+=50
}

$Sidebar.Controls.AddRange(@((NP 0 $yBtn 259 1 $SideEdgeC),(NL "ACTIONS" 16 ($yBtn+10) 220 13 $TextDim $F7B)))

function Make-SmallBtn($Label,$Icon,$Y,$col,$action){
    $p=NP 12 $Y 236 36 $BtnNormal; $p.Cursor=[System.Windows.Forms.Cursors]::Hand
    $strip=NP 0 0 2 36 $BtnBorder
    $ico=NL $Icon 10 10 18 16 $TextMuted (New-Object System.Drawing.Font("Consolas",10,[System.Drawing.FontStyle]::Bold))
    $txt=NL $Label 32 11 196 14 $col $F9B
    $p.Controls.AddRange(@($strip,$ico,$txt))
    $cP=$p;$cS=$strip;$cI=$ico;$cT=$txt
    $hIn ={$cP.BackColor=$BtnHover; $cS.BackColor=$BtnBorderH;$cT.ForeColor=$TextHead; $cI.ForeColor=$TextWhite}.GetNewClosure()
    $hOut={$cP.BackColor=$BtnNormal;$cS.BackColor=$BtnBorder; $cT.ForeColor=$col;      $cI.ForeColor=$TextMuted}.GetNewClosure()
    foreach($c in @($p,$strip,$ico,$txt)){$c.Add_MouseEnter($hIn);$c.Add_MouseLeave($hOut);$c.Add_Click($action)}
    return $p}

$yAct=$yBtn+28
$BtnRev=Make-SmallBtn "Revert Optimization" "<" $yAct      $CWhite {Do-Revert}
$BtnLst=Make-SmallBtn "Show Tweak Status"   "i" ($yAct+44) $CWhite {Do-List}

$DiscordBtn=NP 12 ($yAct+150) 236 36 $BtnNormal; $DiscordBtn.Cursor=[System.Windows.Forms.Cursors]::Hand
$dStrip=NP 0 0 2 36 $DiscordC; $dTxt=NL "Join Discord Server" 14 10 214 16 $TextWhite $F9B
$DiscordBtn.Controls.AddRange(@($dStrip,$dTxt))
$dHIn ={$DiscordBtn.BackColor=$BtnHover; $dStrip.BackColor=RGB 130 150 230;$dTxt.ForeColor=$TextHead}
$dHOut={$DiscordBtn.BackColor=$BtnNormal;$dStrip.BackColor=$DiscordC;      $dTxt.ForeColor=$TextWhite}
foreach($c in @($DiscordBtn,$dTxt)){$c.Add_MouseEnter($dHIn);$c.Add_MouseLeave($dHOut);$c.Add_Click({[System.Diagnostics.Process]::Start("https://discord.com/invite/fayeECjdtb")})}

$VerLbl=NL "v1.0  |  Administrator" 0 678 259 22 $TextDim (New-Object System.Drawing.Font("Consolas",7))
$VerLbl.TextAlign="MiddleCenter"; $VerLbl.Anchor="Bottom,Left"

$Sidebar.Controls.AddRange(@(
    (NP 0 ($yAct+100) 259 1 $SideEdgeC),
    (NL "SUPPORT" 16 ($yAct+114) 220 13 $TextDim $F7B),
    (NL "Need help or have questions ?" 16 ($yAct+128) 228 18 $TextMuted (New-Object System.Drawing.Font("Segoe UI",8))),
    $BtnRev,$BtnLst,$DiscordBtn,$VerLbl
))

# Right panel / console
$Right=NP 260 32 760 708 $ConsoleBG; $Right.Anchor="Top,Left,Right,Bottom"
$Script:RTB=New-Object System.Windows.Forms.RichTextBox
$Script:RTB.Location=New-Object System.Drawing.Point(0,0); $Script:RTB.Size=New-Object System.Drawing.Size(760,708)
$Script:RTB.BackColor=$ConsoleBG; $Script:RTB.ForeColor=$CWhite; $Script:RTB.Font=New-Object System.Drawing.Font("Consolas",9)
$Script:RTB.ReadOnly=$true; $Script:RTB.BorderStyle="None"; $Script:RTB.ScrollBars="Vertical"; $Script:RTB.WordWrap=$true
$Script:RTB.Anchor="Top,Left,Right,Bottom"; $Right.Controls.Add($Script:RTB); $Script:RichBox=$Script:RTB

$OpacBtn.Add_Click({if($Script:Opaque){$Form.Opacity=0.98;$Script:Opaque=$false}else{$Form.Opacity=1.0;$Script:Opaque=$true}})
$Form.Controls.AddRange(@($Sidebar,$SideEdge,$Right))
$Form.Add_Resize({
    $w=$Form.ClientSize.Width; $h=$Form.ClientSize.Height
    $TitleBar.Width=$w; $OpacBtn.Left=$w-136
    $DotClose.Left=$w-200; $DotMin.Left=$w-180; $DotMax.Left=$w-160
    $Sidebar.Height=$h-32; $SideEdge.Height=$h-32; $VerLbl.Top=$h-32-26
    $Right.Width=$w-260; $Right.Height=$h-32; $Script:RTB.Width=$w-260; $Script:RTB.Height=$h-32})

$Form.Add_Shown({Write-Description})
[System.Windows.Forms.Application]::EnableVisualStyles()
[System.Windows.Forms.Application]::Run($Form)
