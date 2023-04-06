# build windows app
echo "building windows release..."
# get args
app_name=$1
version=$2
aim_path=$3/windows/$version
# set args
arch_name=$(uname -m|tr A-Z a-z)
if [ "$arch_name" = "x86_64" ]
then
  arch_name=x64
elif [ "$arch_name" = "aarch64" ]
then
  arch_name=arm64
fi
res_path=./build/windows/runner
curr_name="$app_name"-windows-"$arch_name"-"$version"
# build
flutter build windows --tree-shake-icons
# compress
cp -r "$res_path"/Release "$res_path"/"$curr_name"
tar -czvf "$res_path"/"$curr_name".tar.gz -C "$res_path" "$curr_name"
# move
mkdir -p "$aim_path"
mv "$res_path"/"$curr_name".tar.gz "$aim_path"/
# clear
rm -r "$res_path"/"$curr_name"

echo "Windows release build completed..."