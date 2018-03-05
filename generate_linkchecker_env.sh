set -x
test "${BUILD_NUMBER}x" == "x" && BUILD_NUMBER="${USER}_`date +%Y-%m-%d_%H-%M-%S`" 
linkchecker_git_describe=$(cd linkchecker/ && git describe --tags --abbrev=8 --match v*.*.*)
linkchecker_git_describe_build=${linkchecker_git_describe}-${BUILD_NUMBER}
echo "linkchecker_git_describe_build=${linkchecker_git_describe_build}"  > linkchecker.env
if [ "${BUILD_URL}x" != "x" ]; then
  echo "build_url=${BUILD_URL}"                                         >> linkchecker.env
fi
