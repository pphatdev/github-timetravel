#!/usr/bin/env sh

_() {
    # Prompt for GitHub credentials
    read -p "GitHub Username: " -r USERNAME
    printf "GitHub Access Token: "
    stty -echo
    read -r ACCESS_TOKEN
    stty echo
    echo

    # Prompt for repository details
    read -p "Repository name (default: YEAR): " -r REPO_NAME
    read -p "Year (e.g., 2001): " -r YEAR
    read -p "Month (01-12, default: 10): " -r MONTH
    read -p "Day (01-31, default: 10): " -r DAY

    # Validate inputs
    [ -z "$USERNAME" ] && { echo "Error: GitHub Username is required."; exit 1; }
    [ -z "$ACCESS_TOKEN" ] && { echo "Error: GitHub Access Token is required."; exit 1; }
    [ -z "$YEAR" ] && YEAR="2001"
    [ -z "$REPO_NAME" ] && REPO_NAME="$YEAR"
    [ -z "$MONTH" ] && MONTH="10"
    [ -z "$DAY" ] && DAY="10"

    # Create repository directory
    [ ! -d "$REPO_NAME" ] && mkdir "$REPO_NAME"
    cd "${REPO_NAME}" || exit

    # Initialize Git repository
    git init

    # Create README.md
    cat > README.md <<'EOF'
# 🚀 Time Travel to [YEAR]

This repository was dynamically generated for the year **[YEAR]** using the [github-timetravel](https://github.com/github-timetravel/timetravel) script.

---

## 📜 Purpose
This repository simulates a "time travel" effect by backdating a GitHub repository to a specific year, month, and day. It's a fun way to create a historical footprint on your GitHub profile.

---

## 🛠️ Usage
1. **Clone this repository** to your local machine:
   ```sh
   git clone https://github.com/[USERNAME]/[REPO_NAME].git
