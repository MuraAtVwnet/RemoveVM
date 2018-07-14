●○●○ Remove VM & VHD ○●○●


■ これは何?

	Hyper-V の VM と、VM が使用している VHD をまとめて削除するスクリプトです。

■ 何がうれしいの ?

	Hyper-V の VM を削除した場合、VHD はそのまま残るので、VM 削除後に不要になった VHD を手動削除する必要があります。
	複数の VHD をバラバラの場所に配置している場合、削除するのが面倒なのですが、このスクリプトを使うとその手間がありません。

■ どうやって使うの ?

	管理権限 PowerSehll で RemoveVM.ps1 に VM 名(-VM_Name)を渡します。
	-WhatIf を指定するとテストモードで実削除はしません。

	引数)
		RemoveVM.ps1 [-VM_Name] VM名 [-WhatIf]

	例)
		RemoveVM.ps1 VmName -WhatIf

■ チェックポイントに対応している ?

	はい
	VM を削除した時に、チェックポイントで作成された差分ディスク全てがマージされるので、元の VHD だけ削除します。

■ 差分ディスクに対応している ?

	はい
	差分元の VHD は読み取り専用に設定されているので、ファイル属性を見て判断しています。
	(差分元は削除しません)

■ 動作確認が取れている環境は ?

	以下環境で動作確認しています。

		・Windows Server 2016 Hyper-V
		・Windows Server 2012 R2 Hyper-V

	Windows 10 Hyper-V でも動くと思います。

■ 最新版はどこにあるの ?

	以下リポジトリに置いています

	git@github.com:MuraAtVwnet/RemoveVM.git

	https://github.com/MuraAtVwnet/RemoveVM

■ スクリプトの入手方法

	リポジトリを Clone するのが面倒な場合は、PowerShell で wget(Invoke-WebRequest) してください

	Invoke-WebRequest https://raw.githubusercontent.com/MuraAtVwnet/RemoveVM/master/RemoveVM.ps1 -OutFile ~/RemoveVM.ps1

■ Web サイトはあるの ?

	以下 Web サイトをご覧ください

	Hyper-V の VM と VHD をまとめて削除する
	http://www.vwnet.jp/windows/PowerShell/2018071401/RemoveVM.htm

