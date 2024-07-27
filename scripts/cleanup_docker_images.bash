#!/bin/bash

#!/bin/bash

# Get all image IDs of aichallenge-2024 repository
image_ids=$(docker images | grep aichallenge-2024 | awk '{print $3}')

# Check if there are any images to delete
if [ -z "$image_ids" ]; then
  echo "No images found for repository aichallenge-2024."
else
  # Delete all images
  for id in $image_ids; do
    docker rmi $id
  done
  echo "Deleted all images for repository aichallenge-2024."
fi

docker system prune -f