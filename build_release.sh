# build scripts
echo "Building flutter app releases..."
flutter clean
# init
app_name="device-detector"
version=$(git describe --tags `git rev-list --tags --max-count=1`)
aim_path="$(pwd)/releases"
scripts_path="./scripts"
os_name=$(uname -s|tr A-Z a-z)
# 处理win下的os_name
result=$(echo "$os_name"|grep "mingw")
if [ "$result" != "" ]
then
	os_name="win"
fi

# build for different platform
# android, enable by input arg
if [ "$1" = "true" ];then
  sh $scripts_path/build_android.sh "$app_name" "$version" "$aim_path"
fi
# linux
if [ "$os_name" = "linux" ];then
  sh $scripts_path/build_linux.sh "$app_name" "$version" "$aim_path"
fi
# windows
if [ "$os_name" = "win" ];then
  sh $scripts_path/build_win.sh "$app_name" "$version" "$aim_path"
fi