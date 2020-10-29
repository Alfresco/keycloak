#!/bin/bash -e

TAG=$1

if [ -z "$TAG" ]; then
    echo "Tag argument is required."
    echo "Example:"
    echo "        sh tag.sh 7.0.1-patch"
    exit 1
fi

CURRENT_BRANCH=$(git branch | grep '*' | cut -d' ' -f 2)

echo "Do you wish to tag and push the current branch '$CURRENT_BRANCH' as '$TAG' ?"
select yn in "Yes" "No"; do
    case $yn in
    Yes)
        git tag "$TAG" -m ""
        git push origin "$TAG"
        break
        ;;
    No)
        exit
        ;;
    esac
done
