##########################################################################
#
# Remove VM with VHDs
#
##########################################################################
Param( $VM_Name, [switch]$WhatIf )


##########################################################################
# Find Parent VHD
##########################################################################
function FindParentVHD( $Path ){
	$VHD =Get-VHD -Path $Path
	$ParentPath = $VHD.ParentPath
	if( $ParentPath -ne "" ){
		$BaseVHD = Get-Item $ParentPath
		if( $BaseVHD.Mode -match "-.r..." ){
			# 親が Read Only(差分ベース) なのでこいつが Root VHD と判断
			$script:RootVHD = $Path
		}
		else{
			# 親をたどる
			FindParentVHD $ParentPath
		}
	}
	else{
		# Root VHD
		$script:RootVHD = $Path
	}
}

##########################################################################
# main
##########################################################################
if( $VM_Name -eq $null ){
	echo "Usage..."
	echo "    RemoveVM.ps1 VMName [-WhatIf]"
	exit
}

$VM = Get-VM -Name $VM_Name -ErrorAction SilentlyContinue
if( $VM -eq $null ){
	echo "$VM_Name not found !"
	exit
}

if( $VM.State -ne "Off" ){
	echo "$VM_Name is running now !"
	exit
}

# Useing VHD
[array]$VM_VHDs = Get-VMHardDiskDrive -VMName $VM_Name

# Get Root VHDs
$RootVHDs = @()
foreach( $VM_VHD in $VM_VHDs ){
	$TergetVHD = $VM_VHD.Path
	FindParentVHD $TergetVHD
	$RootVHDs += $RootVHD
}

# Remove VM
echo "Remove VM : $VM_Name"
if( -not $WhatIf ){
	Remove-VM -Name $VM_Name -Force
}

# Remve Root VHDs
foreach( $RootVHD in $RootVHDs ){
	echo "Remove VHD : $RootVHD"
	if( -not $WhatIf ){
		del $RootVHD
	}
}
