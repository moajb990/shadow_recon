#! /bin/bash
remote_repo="https://github.com/moajb990/shadow_recon/"

temp_dir="/tmp/shadow_repo"

target_dir="/usr/local/bin"

if [ -d "$temp_dir" ];then
  rm -rf "$temp_dir"
fi
git clone "$remote_repo" "$temp_dir"

if [ -d "$temp_dir" ];then

	rm -rf "$target_dir"/*


	cp -r "$temp_dir"/shadow_recon.sh "$target_dir"/shadow_recon
 	cp -r "$temp_dir"/scan_lib "$target_dir"
  	cp -r "$temp_dir"/update_repo.sh "$target_dir"/update_repo
	echo "files updated successfully in $target_dir "
else
echo "faild to clone the files."
fi

rm -rf "$temp_dir"
