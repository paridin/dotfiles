## Helpers for work with AWS ECR
##
## MVP - Sep 5 2022
## Copyrigth (C) 2022 defdo.dev

# $1 - profile
# $2 - region
build_ecr_remote_path() {
  account_number=$1
  region=$2
  # account_number.dkr.ecr.region.amazonaws.com
  echo ${account_number}.dkr.ecr.${region}.amazonaws.com
}

# $1 - profile
# $2 - region
# $3 - account_number
log_in_ecr() {
  profile=$1
  region=$2
  account_number=$3
  remote_path=$(build_ecr_remote_path ${account_number} ${region})

  aws ecr get-login-password --region ${region} --profile ${profile} | docker login --username AWS --password-stdin ${remote_path}
}

# $1 - image - expected format image:version
# $2 - region - aws region ex. us-east-1
# $3 - account_number - aws account number
# $4 - profile - aws config profile
download_ecr_image() {
  image=$1
  region=$2
  account_number=$3
  remote_path=$(build_ecr_remote_path ${account_number} ${region})

  # download the image
  docker pull ${remote_path}/${image}
  RESULT=$?

  if [[ $RESULT == 0 ]]; then
    echo "🥷 Docker image downloaded successfully using existing ECR authentication token"
    echo "📥 Downloaded"
  else
    echo "🥷 Docker requires a new token to download from ECR"
    # ECR authentication is invalid, fetch new token
    log_in_ecr $profile $region $account_number
    echo "🔥 Token fetched"
    docker pull ${remote_path}/${image}
    echo "📥 Downloaded"
  fi
}

# $1 - image - expected format image:version
# $2 - region - aws region ex. us-east-1
# $3 - account_number - aws account number
# $4 - profile - aws config profile
push_ecr_image() {
  image=$1
  region=$2
  account_number=$3
  profile=$4

  remote_path=$(build_ecr_remote_path ${account_number} ${region})

  # push the image to our destination
  docker image push ${remote_path}/${image}
  RESULT=$?

  if [[ $RESULT == 0 ]]; then
    echo "🥷 Docker image pushed successfully using existing ECR authentication token"
    echo "📤 push completed"
  else
    echo "🥷 Docker requires a new token to push to ECR"
    # ECR authentication is invalid, fetch new token
    # log in into the destination
    log_in_ecr $profile $region $account_number
    echo "🔥 Token fetched"
    docker image push ${remote_path}/${image}
    echo "📤 Pushed"
  fi
}

# $1 - origin profile - because we relay on configured profiles to simplify the workflow - expected an environment aws profile
# $2 - origin region - aws region ex. us-east-1
# $3 - origin account_number - aws account number
# $4 - origin image - expected format image:version
# $5 - destination profile - because we relay on configured profiles to simplify the workflow - expected an environment aws profile
# $6 - destination region - aws region ex. us-east-1
# $7 - destination account_number - aws account number
# $8 - destination image - expected format image:version
sync_image_origin_dest() {
  # Initialize variables
  origin_profile=$1
  origin_region=$2
  origin_account_number=$3
  origin_image=$4
  origin_remote_path=$(build_ecr_remote_path ${origin_account_number} ${origin_region})

  dest_profile=$5
  dest_region=$6
  dest_account_number=$7
  dest_image=$8
  dest_remote_path=$(build_ecr_remote_path ${dest_account_number} ${dest_region})

  # download the ecr image
  download_ecr_image $origin_image $origin_region $origin_account_number $origin_profile
  # create a tag to push into our destination
  docker tag ${origin_remote_path}/${origin_image} ${dest_remote_path}/${dest_image}
  # push the image to our destination
  push_ecr_image $dest_image $dest_region $dest_account_number $dest_profile
  echo "✅ Sync completed"
}
