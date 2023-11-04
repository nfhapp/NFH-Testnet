Invoke-WebRequest -Uri "https://dl.walletbuilders.com/download?customer=55a8157afe81a49ddaa04223282ff75d4dc800b079d83f728e&filename=nonfungiblehistory-qt-windows.zip" -OutFile "$HOME\Downloads\nonfungiblehistory-qt-windows.zip"

Start-Sleep -s 15

Expand-Archive -LiteralPath "$HOME\Downloads\nonfungiblehistory-qt-windows.zip" -DestinationPath "$HOME\Desktop\NonFungibleHistory"

$ConfigFile = "rpcuser=rpc_nonfungiblehistory
rpcpassword=dR2oBQ3K1zYMZQtJFZeAerhWxaJ5Lqeq9J2
rpcbind=0.0.0.0
rpcallowip=127.0.0.1
listen=1
server=1
addnode=node2.walletbuilders.com"

New-Item -Path "$env:appdata" -Name "NonFungibleHistory" -ItemType "directory"
New-Item -Path "$env:appdata\NonFungibleHistory" -Name "NonFungibleHistory.conf" -ItemType "file" -Value $ConfigFile

$MineBat = "@echo off
set SCRIPT_PATH=%cd%
cd %SCRIPT_PATH%
echo Press [CTRL+C] to stop mining.
:begin
 for /f %%i in ('nonfungiblehistory-cli.exe getnewaddress') do set WALLET_ADDRESS=%%i
 nonfungiblehistory-cli.exe generatetoaddress 1 %WALLET_ADDRESS%
goto begin"

New-Item -Path "$HOME\Desktop\NonFungibleHistory" -Name "mine.bat" -ItemType "file" -Value $MineBat

Start-Process "$HOME\Desktop\NonFungibleHistory\nonfungiblehistory-qt.exe"

Start-Sleep -s 15

Set-Location "$HOME\Desktop\NonFungibleHistory\"
Start-Process "mine.bat"