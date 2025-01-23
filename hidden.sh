#!/usr/bin/env sh

_() {
    YEAR="2024"
    echo "GitHub Username: "
    read -r USERNAME
    echo "GitHub Access token: "
    read -r ACCESS_TOKEN

    # Validate inputs
    [ -z "$USERNAME" ] && echo "Error: Username cannot be empty" && exit 1
    [ -z "$ACCESS_TOKEN" ] && echo "Error: Access token cannot be empty" && exit 1
    
    # Create and enter directory
    [ ! -d "$YEAR" ] && mkdir "$YEAR"
    cd "$YEAR" || { echo "Error: Could not enter directory"; exit 1; }

    # Initialize git and create content
    git init
    echo "**I am the hidden god!**" > README.md
    git add .

    # Create commits for specific dates
    DATES=(
        "${YEAR}-09-22"
        "${YEAR}-09-29"
        "${YEAR}-09-30"
        "${YEAR}-10-01"
        "${YEAR}-10-01"
        "${YEAR}-10-03"
        "${YEAR}-10-04"
        "${YEAR}-10-05"
        "${YEAR}-10-06"
        "${YEAR}-10-07"
        "${YEAR}-10-08"
        "${YEAR}-10-09"
        "${YEAR}-10-12"
        "${YEAR}-10-13"
        "${YEAR}-10-14"
        "${YEAR}-10-14"
        "${YEAR}-10-20"
        "${YEAR}-10-22"
        "${YEAR}-10-26"
        "${YEAR}-10-27"
        "${YEAR}-10-28"
        "${YEAR}-11-01"
        "${YEAR}-11-03"
        "${YEAR}-11-05"
        "${YEAR}-11-07"
        "${YEAR}-11-08"
        "${YEAR}-11-09"
        "${YEAR}-11-10"
        "${YEAR}-11-11"
    )

    for date in "${DATES[@]}"; do
        GIT_AUTHOR_DATE="${date}T18:00:00" \
        GIT_COMMITTER_DATE="${date}T18:00:00" \
        git commit --allow-empty -m "🤖: I'm god robot"
    done

    # Setup remote and push
    git remote add origin "https://${ACCESS_TOKEN}@github.com/${USERNAME}/hidden.git"
    git branch -M main
    git push -u origin main -f || { echo "Error: Failed to push to remote"; exit 1; }
    
    # Cleanup
    cd ..
    rm -rf "$YEAR"

    echo
    echo "✨ Cool, check your profile now! Your commits should appear in ${YEAR}"
} && _

unset -f _
