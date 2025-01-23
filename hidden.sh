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
        "${YEAR}-11-13"
        "${YEAR}-11-14"
        "${YEAR}-11-15"
        "${YEAR}-11-18"
        "${YEAR}-11-18"
        "${YEAR}-12-01"
        "${YEAR}-12-21"
        "${YEAR}-12-22"
        "${YEAR}-12-28"
    )

    for date in "${DATES[@]}"; do
        GIT_AUTHOR_DATE="${date}T18:00:00" \
        GIT_COMMITTER_DATE="${date}T18:00:00" \
        git commit --allow-empty -m "I am the hidden god!!"
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
