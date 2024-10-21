# our shadow_recon repo link
remote_repo="https://github.com/moajb990/shadow_recon.git"
#our temp directory
temp_dir="/tmp/shadow_repo"
#our final directory
traget_dir="/usr/local/bin"

if [ -d "$temp_dir" ];then

 rm -rf "$temp_dir"
fi
git clone "$remote_repo" "$temp_dir"

if [ -d "$temp_dir" ];then

  rm -rf "$target_dir"/*
  # copy all shadow_recon files to our final directory
  cp -r "$temp_dir"/recon.sh "$target_dir"/shr
  cp -r "$temp_dir"/scan.lib "$target_dir"
  cp -r "$temp_dir"/update_repo.sh "$target_dir"/up-shr
  echo "files updated successfully in $target_dir"
  
else
echo "faild to clone the files......"

fi

rm -rf "$temp_dir"

