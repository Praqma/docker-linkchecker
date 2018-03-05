
set -e 
if [ "${1}x" == "x" ]; then
  echo "!!!! You did not supply an image to test. These are the available:"
  docker images
  echo
  if [ -z ${PS1} ] ; then
    echo "Please the docker IMAGE ID of the image you want to test - or exit and supply it as a parameter which also takes <repo>:<tag> "
    read -t 30 docker_image_ref || (echo "Timed out" && exit 1)
  else
    echo "Exit.."
  fi
else
  docker_image_ref=$1
fi 
test "${docker_image_ref}empty" == "empty" && (echo "Error: The docker image reference is empty" && exit 1)
docker run --rm -t $docker_image_ref linkchecker --version
docker run --rm -t $docker_image_ref cat /home/jenkins/linkchecker/linkchecker.env
