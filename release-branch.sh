#!/bin/bash

# Get Current Date
Year=`date +%Y`
Month=`date +%m`
Day=`date +%d`

# Release Branch Name for Current Date
ReleaseBranch="release/$Day-$Month-$Year"

# Create a release branch
createReleaseBranch(){
    echo " Creating Release BRanch $ReleaseBranch \n"
    git checkout -b $ReleaseBranch
    git push --set-upstream origin $ReleaseBranch 
}

# Function to switch to Base Branch
switchToBaseBranch(){
    echo " Switching Base Branch $sourceBranch \n"
    git fetch --all
    git checkout $sourceBranch
    git pull
    echo -n "\n Do you want to create release branch? (y/n): "
    read releaseYes
    if [ $releaseYes = "y" ]; then
        createReleaseBranch
    fi
    startFromHere
}

# Show List of Repositories
showRepoList(){
    echo " Showing Repositories/Projects"
    echo " ============================="
    echo " 1. SFL-Front-End"
    echo " 2. SFL-API"
    echo " 3. SFL-Lead-API"
    echo " 4. SFL-CMS"
    echo " 5. SFL-FD-FrontEnd"
    echo " 6. SFL-PL-FrontEnd"
    echo " 7. SFL-GL-FrontEnd"
    echo " 8. SFL-FW-FrontEnd"
    echo " 9. SFL-TW-FrontEnd"
    echo " 10. SFL-Customer-Portal"
    echo " 11. SFL-Customer-Portal-API"
    echo " 12. ALL"
}

getUserSelectedRepo(){
    case "$userRepoSelected" in
        1) 
        repo="SFL-Front-End";;
        2) 
        repo="SFL-API";;
        3) 
        repo="SFL-Lead-API";;
        4) 
        repo="SFL-CMS";;
        5) 
        repo="SFL-FD-FrontEnd";;
        6) 
        repo="SFL-PL-FrontEnd";;
        7) 
        repo="SFL-GL-FrontEnd";;
        8) 
        repo="SFL-FW-FrontEnd";;
        9) 
        repo="SFL-TW-FrontEnd";;
        10) 
        repo="SFL-Customer-Portal";;
        11) 
        repo="SFL-Customer-Portal-API";;
        12) 
        repo="ALL";;
        *)
        repo="";;
    esac
    echo $repo
}

# Change Directory and Change Branch
chenageRepoBranch(){
    echo " Changing to the Project Directory $switchRepo"
    cd "/WorkSpace/sfl/git/$switchRepo/"
    switchToBaseBranch $sourceBranch
}

startFromHere(){
    # Show Repo List
    showRepoList

    # Get user input for selecting Repository
    echo -n "\n Select Repository: "
    read userRepoSelected

    # Get the base branch from which the release branch to be created
    echo -n "\n Enter the Branch name to checkout: "
    read sourceBranch
    echo "\n Source Branch: $sourceBranch"

    # Switch to User opted Repo and Checkout to the user given branch
    if [ $userRepoSelected -eq 12 ]; then
        echo " User Selected All Repos.."
        max=11
        for i in `seq 1 $max`
        do
            userRepoSelected=$i
            switchRepo=$(getUserSelectedRepo)
            echo "\n Selected $switchRepo Repository \n"
            echo "$i"
        done
    else
        switchRepo=$(getUserSelectedRepo)
        echo "\n Selected $switchRepo Repository \n"
        if [ $switchRepo != "" ]; then
            echo " Changing Branch.. \n"
            chenageRepoBranch
        fi
    fi
}

# Show Repo List
startFromHere