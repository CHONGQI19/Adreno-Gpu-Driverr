# Info
device=$(getprop ro.product.system.device)
model=$(getprop ro.product.system.model)
soc=$(getprop ro.product.board)
modver=$(grep_prop version "$MODPATH"/module.prop)
moddesc=$(grep_prop description "$MODPATH"/module.prop)
ui_print "- Version: $modver"
ui_print "- $moddesc"
ui_print " ";

# Determine which version information to display
if [ "$KSU" == true ]; then
  ui_print "- KSUVersion=$KSU_VER";
  sleep 1.80
  ui_print "- KSUVersionCode=$KSU_VER_CODE";
  sleep 1.80
  ui_print "- KSUKernelVersionCode=$KSU_KERNEL_VER_CODE";
  sleep 1.80
else
  ui_print "- MagiskVersion=$MAGISK_VER";
  sleep 1.80
  ui_print "- MagiskVersionCode=$MAGISK_VER_CODE";
  sleep 1.80
fi

#Running Installing Script

ui_print "installing gpu driver"
ui_print ""
ui_print "installing drivers for $device, $model, $soc"
ui_print ""
ui_print ""
ui_print " ";

# Add patch permissions for paths
if set_perm_recursive "$MODPATH" 0 0 0755 0644 \
   && set_perm_recursive "$MODPATH"/system/vendor/ 0 0 0755 0644 u:object_r:same_process_hal_file:s0 \
   && set_perm_recursive "$MODPATH"/system/lib*/ 0 0 0644 u:object_r:system_lib_file:s0; then
  sleep 8
  ui_print "- Drivers successfully installed!"
else
  ui_print "- Error: Failed to install drivers."
  exit 1
fi

#GPU Cache Cleaner Running
ui_print " ";
ui_print "- GPU Cache Cleaner is load wait!";
ui_print " ";

sleep 3

check_file_exists() {
    if [ -e "$1" ]; then
        ui_print "- File $1 still exists.";
        sleep 1.80
    else
        ui_print "- File $1 has been deleted.";
        sleep 1.80
    fi
}

find /data/user_de -type f -name '*shader*' -exec rm -f {} \; 
check_file_exists /data/*shader*

find /data/user_de -type f -name '*shader_cache*/code_cache' -exec rm -f {} \;
check_file_exists /data/user_de/*shader_cache*/code_cache

find /data/user_de -type f -name '*shader_cache*/cache' -exec rm -f {} \;
check_file_exists /data/user_de/*shader_cache*/cache

ui_print " ";
sleep 1.80
ui_print "- Done 🥰";
sleep 1.80
ui_print " ";
ui_print "- Please reboot! ";
ui_print " ";
