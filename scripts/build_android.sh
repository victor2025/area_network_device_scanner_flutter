# build android app
echo "$0"
echo "Building android release..."
# get args
app_name=$1
version=$2
aim_path=$3/android/$version
# set args
res_path="$(pwd)"/build/app/outputs/apk/release
v7a=armeabi-v7a
v8a=arm64-v8a
v7a_name="$app_name"-v7a-"$version".apk
v8a_name="$app_name"-v8a-"$version".apk
# build
flutter build apk --target-platform android-arm,android-arm64 --split-per-abi --release --obfuscate --split-debug-info=obfuscate/debug-info --tree-shake-icons
# move
mkdir -p "$aim_path"
cp "$res_path"/app-$v7a-release.apk "$aim_path"/"$v7a_name"
cp "$res_path"/app-$v8a-release.apk "$aim_path"/"$v8a_name"

echo "Android release build completed..."