$os = Get-WMIObject win32_operatingsystem
echo "Host name: $($os.CSName)"
echo "OS version: $($os.Caption)"

$computer = Get-CimInstance Win32_ComputerSystem
echo "CPU cores: $($computer.NumberOfLogicalProcessors)"
echo "RAM: $($computer.TotalPhysicalMemory/1024)kb"

$disk = Get-WmiObject Win32_LogicalDisk -Filter "DeviceID='C:'" | Select-Object Size,FreeSpace
echo "HDD size: $($disk.Size/1024/1024/1024)G"
echo "HDD disk usage: $(($disk.Size-$disk.FreeSpace)/1024/1024/1024)G"
