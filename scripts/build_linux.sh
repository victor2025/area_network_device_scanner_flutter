# build linux app
echo "building linux release..."
# get args
app_name=$1
version=$2
aim_path=$3/linux/$version
# set args
arch_name=$(uname -m|tr A-Z a-z)
if [ "$arch_name" = "x86_64" ];then
  arch_name=x64
elif [ "$arch_name" = "aarch64" ];then
  arch_name=arm64
fi
res_path="$(pwd)"/build/linux/"$arch_name"/release
curr_name="$app_name"-linux-"$arch_name"-"$version"
# build
flutter build linux --target-platform linux-$arch_name --release --build-name=0.0.1 --obfuscate --split-debug-info=obfuscate/debug-info --tree-shake-icons
# compress
cp -r "$res_path"/bundle "$res_path"/"$curr_name"
tar -czvf "$res_path"/"$curr_name".tar.gz -C "$res_path" "$curr_name"
# move
mkdir -p "$aim_path"
mv "$res_path"/"$curr_name".tar.gz "$aim_path"/
# clear
rm -r "$res_path"/"$curr_name"

echo "Linux release build completed..."